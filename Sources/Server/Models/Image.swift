import Vapor
import Fluent

final class Image: Model, Content, @unchecked Sendable {
    static let schema = "images"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "filename")
    var filename: String
    
    @Field(key: "original_filename")
    var originalFilename: String
    
    @Field(key: "file_path")
    var filePath: String
    
    @Field(key: "file_size")
    var fileSize: Int
    
    @Field(key: "mime_type")
    var mimeType: String
    
    @Enum(key: "image_type")
    var imageType: ImageType
    
    @Parent(key: "uploader_id")
    var uploader: Admin
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, filename: String, originalFilename: String, filePath: String, fileSize: Int, mimeType: String, imageType: ImageType, uploaderID: UUID) {
        self.id = id
        self.filename = filename
        self.originalFilename = originalFilename
        self.filePath = filePath
        self.fileSize = fileSize
        self.mimeType = mimeType
        self.imageType = imageType
        self.$uploader.id = uploaderID
    }
}

// 마이그레이션
struct CreateImage: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("images")
            .id()
            .field("filename", .string, .required)
            .field("original_filename", .string, .required)
            .field("file_path", .string, .required)
            .field("file_size", .int, .required)
            .field("mime_type", .string, .required)
            .field("image_type", .string, .required)
            .field("uploader_id", .uuid, .required, .references("admins", "id"))
            .field("created_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("images").delete()
    }
}
