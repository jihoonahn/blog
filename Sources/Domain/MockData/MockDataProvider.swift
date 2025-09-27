import Foundation

// Mock Data Provider for Blog
public class MockDataProvider {
    
    // MARK: - Mock Tags
    public static let mockTags: [Tag] = [
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440030")!, name: "swift", slug: "swift"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440031")!, name: "wasm", slug: "wasm"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440032")!, name: "blog", slug: "blog"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440033")!, name: "supabase", slug: "supabase"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440034")!, name: "webassembly", slug: "webassembly"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440035")!, name: "javascriptkit", slug: "javascriptkit"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440036")!, name: "backend", slug: "backend"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440037")!, name: "database", slug: "database"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440038")!, name: "performance", slug: "performance"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440039")!, name: "일상", slug: "daily"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440040")!, name: "개발", slug: "development"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440041")!, name: "학습", slug: "learning"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440042")!, name: "성장", slug: "growth"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440043")!, name: "dom", slug: "dom"),
        Tag(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440044")!, name: "web", slug: "web")
    ]
    
    // MARK: - Mock Categories
    public static let mockCategories: [Category] = [
        Category(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440020")!,
            name: "소개",
            slug: "introduction"
        ),
        Category(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440021")!,
            name: "기술",
            slug: "technology"
        ),
        Category(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440022")!,
            name: "일상",
            slug: "daily"
        ),
        Category(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440023")!,
            name: "프로젝트",
            slug: "project"
        )
    ]
    
    // MARK: - Mock Posts
    public static let mockPosts: [Post] = [
        Post(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440001")!,
            title: "Swift Blog에 오신 것을 환영합니다!",
            content: """
            이것은 Swift와 Supabase를 사용하여 구축된 개인 블로그입니다.
            
            ## 주요 기능
            - Swift로 작성된 백엔드
            - Supabase를 통한 데이터 관리
            - 현대적인 웹 인터페이스
            - 반응형 디자인
            
            앞으로 더 많은 흥미로운 포스트를 올릴 예정입니다!
            """,
            excerpt: "Swift와 Supabase를 사용하여 구축된 개인 블로그입니다.",
            slug: "welcome-to-swift-blog",
            status: .published,
            publishedAt: Date(),
            createdAt: Date(),
            updatedAt: Date(),
            authorId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
            categoryId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440020")!,
            tags: [
                mockTags[0], // swift
                mockTags[1], // wasm
                mockTags[2], // blog
                mockTags[3]  // supabase
            ],
            featuredImage: nil,
            viewCount: 0,
            likeCount: 0
        ),
        Post(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440002")!,
            title: "Swift WASM의 장점과 활용법",
            content: """
            Swift WASM은 Swift 코드를 WebAssembly로 컴파일하여 브라우저에서 실행할 수 있게 해줍니다.
            
            ## 주요 장점
            1. **네이티브 성능**: C/C++ 수준의 성능
            2. **크로스 플랫폼**: 모든 브라우저에서 동일한 동작
            3. **타입 안전성**: Swift의 강력한 타입 시스템
            4. **메모리 안전성**: 자동 메모리 관리
            
            ## 활용 사례
            - 게임 엔진
            - 이미지/비디오 처리
            - 수학 계산
            - 데이터 분석
            
            Swift WASM을 통해 웹 개발의 새로운 가능성을 열어보세요!
            """,
            excerpt: "Swift WASM의 장점과 활용법을 알아보세요.",
            slug: "swift-wasm-advantages",
            status: .published,
            publishedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            createdAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            authorId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
            categoryId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440021")!,
            tags: [
                mockTags[0], // swift
                mockTags[1], // wasm
                mockTags[4], // webassembly
                mockTags[8]  // performance
            ],
            featuredImage: nil,
            viewCount: 0,
            likeCount: 0
        ),
        Post(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440003")!,
            title: "Supabase와의 완벽한 통합",
            content: """
            Supabase는 오픈소스 Firebase 대안으로, PostgreSQL 기반의 백엔드 서비스를 제공합니다.
            
            ## Supabase의 주요 기능
            - **실시간 데이터베이스**: PostgreSQL 기반
            - **인증 시스템**: 다양한 로그인 방법 지원
            - **파일 스토리지**: 이미지, 문서 등 저장
            - **Edge Functions**: 서버리스 함수 실행
            
            ## Swift와의 통합
            Supabase Swift SDK를 사용하면 타입 안전한 방식으로 데이터베이스와 상호작용할 수 있습니다.
            """,
            excerpt: "Supabase와 Swift의 완벽한 통합 방법을 알아보세요.",
            slug: "supabase-swift-integration",
            status: .published,
            publishedAt: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            authorId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
            categoryId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440021")!,
            tags: [
                mockTags[3], // supabase
                mockTags[6], // backend
                mockTags[7], // database
                mockTags[0]  // swift
            ],
            featuredImage: nil,
            viewCount: 0,
            likeCount: 0
        ),
        Post(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440004")!,
            title: "개발자의 일상과 생각",
            content: """
            개발자로서의 일상과 생각을 공유합니다.
            
            ## 오늘의 학습
            - Swift WASM에 대해 더 깊이 파고들었습니다
            - Supabase의 Row Level Security 기능을 학습했습니다
            - 웹 성능 최적화 기법들을 연구했습니다
            
            ## 앞으로의 계획
            - 더 많은 Swift WASM 프로젝트를 만들어보고 싶습니다
            - 오픈소스 기여를 늘려가고 싶습니다
            - 기술 블로그를 꾸준히 운영하고 싶습니다
            
            개발은 끝없는 학습의 과정이라고 생각합니다. 함께 성장해나가요!
            """,
            excerpt: "개발자로서의 일상과 생각을 공유합니다.",
            slug: "developer-daily-thoughts",
            status: .published,
            publishedAt: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            createdAt: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            authorId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
            categoryId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440022")!,
            tags: [
                mockTags[9],  // 일상
                mockTags[10], // 개발
                mockTags[11], // 학습
                mockTags[12]  // 성장
            ],
            featuredImage: nil,
            viewCount: 0,
            likeCount: 0
        ),
        Post(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440005")!,
            title: "JavaScriptKit으로 DOM 조작하기",
            content: """
            JavaScriptKit을 사용하여 Swift에서 DOM을 조작하는 방법을 알아보겠습니다.
            
            ## JavaScriptKit이란?
            JavaScriptKit은 Swift 코드에서 JavaScript API에 접근할 수 있게 해주는 라이브러리입니다.
            
            ## 기본 사용법
            ```swift
            import JavaScriptKit
            
            let document = JSObject.global.document
            let element = document.getElementById!("myElement")
            element.innerHTML = .string("Hello, World!")
            ```
            
            ## 실제 활용 예시
            - 동적 HTML 생성
            - 이벤트 리스너 등록
            - CSS 클래스 조작
            - 폼 데이터 처리
            
            JavaScriptKit을 통해 Swift의 강력함을 웹에서도 활용해보세요!
            """,
            excerpt: "JavaScriptKit을 사용하여 Swift에서 DOM을 조작하는 방법을 알아보세요.",
            slug: "javascriptkit-dom-manipulation",
            status: .published,
            publishedAt: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),
            createdAt: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),
            authorId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
            categoryId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440021")!,
            tags: [
                mockTags[5], // javascriptkit
                mockTags[13], // dom
                mockTags[0], // swift
                mockTags[14]  // web
            ],
            featuredImage: nil,
            viewCount: 0,
            likeCount: 0
        )
    ]
    
    // MARK: - Mock Comments
    public static let mockComments: [Comment] = [
        Comment(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440050")!,
            postId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440001")!,
            authorName: "김개발",
            authorEmail: "kim@example.com",
            content: "정말 유익한 포스트네요! Swift WASM에 대해 더 알고 싶어졌습니다.",
            status: .approved,
            createdAt: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
            parentId: nil,
            ipAddress: nil,
            userAgent: nil
        ),
        Comment(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440051")!,
            postId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440001")!,
            authorName: "이프로그래머",
            authorEmail: "lee@example.com",
            content: "블로그 잘 보고 있습니다. 앞으로도 좋은 글 부탁드려요!",
            status: .approved,
            createdAt: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(),
            parentId: nil,
            ipAddress: nil,
            userAgent: nil
        ),
        Comment(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440052")!,
            postId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440002")!,
            authorName: "박코더",
            authorEmail: "park@example.com",
            content: "Swift WASM 성능이 정말 좋다니 놀랍네요. 실제 프로젝트에 적용해보고 싶습니다.",
            status: .approved,
            createdAt: Calendar.current.date(byAdding: .hour, value: -1, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .hour, value: -1, to: Date()) ?? Date(),
            parentId: nil,
            ipAddress: nil,
            userAgent: nil
        ),
        Comment(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440053")!,
            postId: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440003")!,
            authorName: "최개발자",
            authorEmail: "choi@example.com",
            content: "Supabase 정말 좋은 서비스네요. Firebase 대안으로 고려해볼 만합니다.",
            status: .approved,
            createdAt: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
            updatedAt: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
            parentId: nil,
            ipAddress: nil,
            userAgent: nil
        )
    ]
    
    // MARK: - Mock Blog Config
    public static let mockBlogConfig: BlogConfig = BlogConfig(
        id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440060")!,
        siteName: "Swift Blog",
        siteDescription: "Swift와 Supabase를 사용하여 구축된 개인 블로그입니다.",
        siteUrl: "https://swiftblog.example.com",
        adminEmail: "admin@swiftblog.com",
        postsPerPage: 10,
        allowComments: true,
        moderateComments: true,
        allowRegistration: false,
        theme: "default",
        language: "ko",
        timezone: "Asia/Seoul",
        dateFormat: "yyyy-MM-dd",
        socialLinks: [:],
        seoTitle: "Swift Blog - Swift와 Supabase 블로그",
        seoDescription: "Swift와 Supabase를 사용하여 구축된 개인 블로그입니다.",
        seoKeywords: ["swift", "wasm", "blog", "supabase"],
        analyticsId: "GA-XXXXXXXXX",
        createdAt: Date(),
        updatedAt: Date()
    )
    
    // MARK: - Mock Admin
    public static let mockAdmin: Admin = Admin(
        id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440010")!,
        username: "admin",
        email: "admin@swiftblog.com",
        displayName: "관리자",
        avatar: nil,
        role: .admin,
        isActive: true,
        lastLoginAt: Date(),
        createdAt: Date(),
        updatedAt: Date()
    )
    
    // MARK: - Helper Methods
    
    public static func getPostsByCategory(_ categorySlug: String) -> [Post] {
        return mockPosts.filter { post in
            post.status == .published && 
            mockCategories.first { $0.slug == categorySlug }?.id == post.categoryId
        }
    }
    
    public static func getPostsByTag(_ tagSlug: String) -> [Post] {
        return mockPosts.filter { post in
            post.status == .published && 
            post.tags.contains { $0.slug == tagSlug }
        }
    }
    
    public static func getCommentsForPost(_ postId: UUID) -> [Comment] {
        return mockComments.filter { $0.postId == postId && $0.status == .approved }
    }
    
    public static func getRecentPosts(limit: Int = 5) -> [Post] {
        return Array(mockPosts.filter { $0.status == .published }.prefix(limit))
    }
    
    public static func searchPosts(query: String) -> [Post] {
        let lowercaseQuery = query.lowercased()
        return mockPosts.filter { post in
            post.status == .published && (
                post.title.lowercased().contains(lowercaseQuery) ||
                post.content.lowercased().contains(lowercaseQuery) ||
                post.tags.contains { $0.name.lowercased().contains(lowercaseQuery) }
            )
        }
    }
}
