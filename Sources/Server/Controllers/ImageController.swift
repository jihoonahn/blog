import Vapor
import Fluent

struct ImageController {
    func upload(_ req: Request) async throws -> ImageUploadResponse {
        let admin = try req.requireAdmin()
        
        struct UploadData: Content {
            var file: File
            var imageType: ImageType?
        }
        
        let uploadData = try req.content.decode(UploadData.self)
        let file = uploadData.file
        let imageType = uploadData.imageType ?? .content
        
        guard file.data.readableBytes > 0 else {
            throw Abort(.badRequest, reason: "Is Empty File")
        }
        
        guard file.data.readableBytes <= imageType.maxFileSize else {
            let maxSizeMB = imageType.maxFileSize / (1024 * 1024)
            throw Abort(.payloadTooLarge, reason: "File Size Too Big. Maxium Size is \(maxSizeMB)MB.")
        }
        
        let mimeType = file.contentType?.description ?? "application/octet-stream"
        guard imageType.allowedMimeTypes.contains(mimeType) else {
            throw Abort(.unsupportedMediaType, reason: "Not Support Image Type")
        }
        
        let fileExtension = file.extension ?? "jpg"
        let filename = "\(UUID().uuidString).\(fileExtension)"
        let directory = req.application.directory.publicDirectory + imageType.uploadPath
        let filePath = directory + filename
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true)
        }
        
        try await req.fileio.writeFile(file.data, at: filePath)
        
        let image = Image(
            filename: filename,
            originalFilename: file.filename,
            filePath: filePath,
            fileSize: file.data.readableBytes,
            mimeType: mimeType,
            imageType: imageType,
            uploaderID: try admin.requireID()
        )
        
        try await image.save(on: req.db)
        
        return ImageUploadResponse(
            id: try image.requireID(),
            url: "/\(imageType.uploadPath)\(filename)",
            filename: filename,
            originalFilename: image.originalFilename,
            fileSize: image.fileSize
        )
    }
    
    func myImages(_ req: Request) async throws -> [ImageResponse] {
        let admin = try req.requireAdmin()
        
        let adminID = try admin.requireID()
        let images = try await Image.query(on: req.db)
            .filter(\.$uploader.$id == adminID)
            .sort(\.$createdAt, .descending)
            .limit(50)
            .all()
        
        return images.map { image in
            ImageResponse(
                id: try! image.requireID(),
                filename: image.filename,
                originalFilename: image.originalFilename,
                url: "/\(image.imageType.uploadPath)\(image.filename)",
                fileSize: image.fileSize,
                mimeType: image.mimeType,
                imageType: image.imageType,
                createdAt: image.createdAt
            )
        }
    }
    
    // 이미지 삭제
    func delete(_ req: Request) async throws -> HTTPStatus {
        let _ = try req.requireAdmin()
        
        guard let image = try await Image.find(req.parameters.get("imageID"), on: req.db) else {
            throw Abort(.notFound, reason: "이미지를 찾을 수 없습니다.")
        }
        
        // 파일 시스템에서 파일 삭제
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: image.filePath) {
            try fileManager.removeItem(atPath: image.filePath)
        }
        
        // 데이터베이스에서 삭제
        try await image.delete(on: req.db)
        
        return .noContent
    }
}

// 간단한 응답용 DTO
struct ImageUploadResponse: Content {
    let id: UUID
    let url: String
    let filename: String
    let originalFilename: String
    let fileSize: Int
}

struct ImageResponse: Content {
    let id: UUID
    let filename: String
    let originalFilename: String
    let url: String
    let fileSize: Int
    let mimeType: String
    let imageType: ImageType
    let createdAt: Date?
}
