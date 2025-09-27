import Foundation
import Domain

public class FormRenderer {
    private let htmlRenderer: HTMLRenderer
    
    public init(htmlRenderer: HTMLRenderer) {
        self.htmlRenderer = htmlRenderer
    }
    
    // MARK: - Generic Form Components
    
    public func renderFormField(
        name: String,
        label: String,
        type: FormFieldType = .text,
        value: String = "",
        required: Bool = false,
        placeholder: String = "",
        options: [String] = [],
        error: String? = nil
    ) -> String {
        let fieldId = "field-\(name)"
        let errorClass = error != nil ? "error" : ""
        let requiredAttr = required ? "required" : ""
        let requiredMark = required ? " *" : ""
        
        var content = """
        <div class="form-group \(errorClass)">
            <label for="\(fieldId)">\(label)\(requiredMark)</label>
        """
        
        switch type {
        case .text, .email, .password, .url, .number:
            content += """
            <input type="\(type.rawValue)" id="\(fieldId)" name="\(name)" value="\(value)" placeholder="\(placeholder)" \(requiredAttr)>
            """
            
        case .textarea:
            content += """
            <textarea id="\(fieldId)" name="\(name)" placeholder="\(placeholder)" \(requiredAttr)>\(value)</textarea>
            """
            
        case .select:
            content += """
            <select id="\(fieldId)" name="\(name)" \(requiredAttr)>
                <option value="">선택하세요</option>
            """
            for option in options {
                let selected = option == value ? "selected" : ""
                content += "<option value=\"\(option)\" \(selected)>\(option)</option>"
            }
            content += "</select>"
            
        case .checkbox:
            let checked = value == "true" || value == "1" ? "checked" : ""
            content += """
            <input type="checkbox" id="\(fieldId)" name="\(name)" value="true" \(checked)>
            <label for="\(fieldId)" class="checkbox-label">\(label)</label>
            """
            
        case .radio:
            for option in options {
                let optionId = "\(fieldId)-\(option)"
                let checked = option == value ? "checked" : ""
                content += """
                <div class="radio-option">
                    <input type="radio" id="\(optionId)" name="\(name)" value="\(option)" \(checked)>
                    <label for="\(optionId)">\(option)</label>
                </div>
                """
            }
        }
        
        if let error = error {
            content += "<div class=\"field-error\">\(error)</div>"
        }
        
        content += "</div>"
        return content
    }
    
    public func renderFormActions(primaryText: String = "저장", secondaryText: String? = nil, secondaryUrl: String? = nil) -> String {
        var content = "<div class=\"form-actions\">"
        content += "<button type=\"submit\" class=\"btn btn-primary\">\(primaryText)</button>"
        
        if let secondaryText = secondaryText, let secondaryUrl = secondaryUrl {
            content += "<a href=\"\(secondaryUrl)\" class=\"btn btn-secondary\">\(secondaryText)</a>"
        }
        
        content += "</div>"
        return content
    }
    
    // MARK: - Post Forms
    
    public func renderPostForm(post: Post? = nil, categories: [Domain.Category] = [], tags: [Tag] = []) -> String {
        let isEdit = post != nil
        let formTitle = isEdit ? "포스트 수정" : "새 포스트 작성"
        
        var content = """
        <div class="post-form">
            <h1>\(formTitle)</h1>
            <form id="post-form" method="\(isEdit ? "PUT" : "POST")" action="\(isEdit ? "/admin/posts/\(post!.id)" : "/admin/posts")">
        """
        
        // Title
        content += renderFormField(
            name: "title",
            label: "제목",
            value: post?.title ?? "",
            required: true,
            placeholder: "포스트 제목을 입력하세요"
        )
        
        // Slug
        content += renderFormField(
            name: "slug",
            label: "슬러그",
            value: post?.slug ?? "",
            required: true,
            placeholder: "url-friendly-slug"
        )
        
        // Excerpt
        content += renderFormField(
            name: "excerpt",
            label: "요약",
            type: .textarea,
            value: post?.excerpt ?? "",
            placeholder: "포스트 요약을 입력하세요"
        )
        
        // Content
        content += renderFormField(
            name: "content",
            label: "내용",
            type: .textarea,
            value: post?.content ?? "",
            required: true,
            placeholder: "포스트 내용을 입력하세요"
        )
        
        // Status
        let statusOptions = PostStatus.allCases.map { $0.rawValue }
        content += renderFormField(
            name: "status",
            label: "상태",
            type: .select,
            value: post?.status.rawValue ?? "draft",
            options: statusOptions
        )
        
        // Category
        let categoryOptions = categories.map { $0.name }
        content += renderFormField(
            name: "categoryId",
            label: "카테고리",
            type: .select,
            value: post?.categoryId?.uuidString ?? "",
            options: categoryOptions
        )
        
        // Featured Image
        content += renderFormField(
            name: "featuredImage",
            label: "대표 이미지",
            type: .url,
            value: post?.featuredImage ?? "",
            placeholder: "https://example.com/image.jpg"
        )
        
        // Tags (multi-select)
        content += renderTagSelector(tags: tags, selectedTags: post?.tags ?? [])
        
        content += renderFormActions(
            primaryText: isEdit ? "수정" : "작성",
            secondaryText: "취소",
            secondaryUrl: "/admin/posts"
        )
        
        content += "</form></div>"
        return content
    }
    
    private func renderTagSelector(tags: [Tag], selectedTags: [Tag]) -> String {
        var content = """
        <div class="form-group">
            <label>태그</label>
            <div class="tag-selector">
        """
        
        for tag in tags {
            let isSelected = selectedTags.contains { $0.id == tag.id }
            let checked = isSelected ? "checked" : ""
            content += """
            <div class="tag-option">
                <input type="checkbox" id="tag-\(tag.id)" name="tags" value="\(tag.id)" \(checked)>
                <label for="tag-\(tag.id)">\(tag.name)</label>
            </div>
            """
        }
        
        content += """
            </div>
        </div>
        """
        return content
    }
    
    // MARK: - Comment Forms
    
    public func renderCommentForm(postId: UUID, parentId: UUID? = nil) -> String {
        let isReply = parentId != nil
        let formTitle = isReply ? "답글 작성" : "댓글 작성"
        
        var content = """
        <div class="comment-form">
            <h4>\(formTitle)</h4>
            <form id="comment-form" data-post-id="\(postId)" data-parent-id="\(parentId?.uuidString ?? "")">
        """
        
        content += renderFormField(
            name: "authorName",
            label: "이름",
            value: "",
            required: true,
            placeholder: "이름을 입력하세요"
        )
        
        content += renderFormField(
            name: "authorEmail",
            label: "이메일",
            type: .email,
            value: "",
            required: true,
            placeholder: "이메일을 입력하세요"
        )
        
        content += renderFormField(
            name: "content",
            label: "댓글",
            type: .textarea,
            value: "",
            required: true,
            placeholder: "댓글을 입력하세요"
        )
        
        content += renderFormField(
            name: "notifyOnReply",
            label: "답글 알림 받기",
            type: .checkbox,
            value: "false"
        )
        
        content += renderFormActions(
            primaryText: formTitle,
            secondaryText: isReply ? "취소" : nil,
            secondaryUrl: isReply ? nil : nil
        )
        
        content += "</form></div>"
        return content
    }
    
    // MARK: - Category Forms
    
    public func renderCategoryForm(category: Domain.Category? = nil, parentCategories: [Domain.Category] = []) -> String {
        let isEdit = category != nil
        let formTitle = isEdit ? "카테고리 수정" : "새 카테고리"
        
        var content = """
        <div class="category-form">
            <h1>\(formTitle)</h1>
            <form id="category-form" method="\(isEdit ? "PUT" : "POST")" action="\(isEdit ? "/admin/categories/\(category!.id)" : "/admin/categories")">
        """
        
        content += renderFormField(
            name: "name",
            label: "이름",
            value: category?.name ?? "",
            required: true,
            placeholder: "카테고리 이름"
        )
        
        content += renderFormField(
            name: "slug",
            label: "슬러그",
            value: category?.slug ?? "",
            required: true,
            placeholder: "category-slug"
        )
        
        content += renderFormField(
            name: "description",
            label: "설명",
            type: .textarea,
            value: category?.description ?? "",
            placeholder: "카테고리 설명"
        )
        
        content += renderFormField(
            name: "color",
            label: "색상",
            type: .text,
            value: category?.color ?? "",
            placeholder: "#FF0000"
        )
        
        content += renderFormField(
            name: "icon",
            label: "아이콘",
            type: .text,
            value: category?.icon ?? "",
            placeholder: "icon-name"
        )
        
        // Parent Category
        let parentOptions = parentCategories.map { $0.name }
        content += renderFormField(
            name: "parentId",
            label: "상위 카테고리",
            type: .select,
            value: category?.parentId?.uuidString ?? "",
            options: parentOptions
        )
        
        content += renderFormActions(
            primaryText: isEdit ? "수정" : "생성",
            secondaryText: "취소",
            secondaryUrl: "/admin/categories"
        )
        
        content += "</form></div>"
        return content
    }
    
    // MARK: - Tag Forms
    
    public func renderTagForm(tag: Tag? = nil) -> String {
        let isEdit = tag != nil
        let formTitle = isEdit ? "태그 수정" : "새 태그"
        
        var content = """
        <div class="tag-form">
            <h1>\(formTitle)</h1>
            <form id="tag-form" method="\(isEdit ? "PUT" : "POST")" action="\(isEdit ? "/admin/tags/\(tag!.id)" : "/admin/tags")">
        """
        
        content += renderFormField(
            name: "name",
            label: "이름",
            value: tag?.name ?? "",
            required: true,
            placeholder: "태그 이름"
        )
        
        content += renderFormField(
            name: "slug",
            label: "슬러그",
            value: tag?.slug ?? "",
            required: true,
            placeholder: "tag-slug"
        )
        
        content += renderFormField(
            name: "description",
            label: "설명",
            type: .textarea,
            value: tag?.description ?? "",
            placeholder: "태그 설명"
        )
        
        content += renderFormField(
            name: "color",
            label: "색상",
            type: .text,
            value: tag?.color ?? "",
            placeholder: "#FF0000"
        )
        
        content += renderFormActions(
            primaryText: isEdit ? "수정" : "생성",
            secondaryText: "취소",
            secondaryUrl: "/admin/tags"
        )
        
        content += "</form></div>"
        return content
    }
    
    // MARK: - Admin Forms
    
    public func renderLoginForm() -> String {
        var content = """
        <div class="login-form">
            <h1>관리자 로그인</h1>
            <form id="login-form" method="POST" action="/admin/login">
        """
        
        content += renderFormField(
            name: "username",
            label: "사용자명",
            value: "",
            required: true,
            placeholder: "사용자명을 입력하세요"
        )
        
        content += renderFormField(
            name: "password",
            label: "비밀번호",
            type: .password,
            value: "",
            required: true,
            placeholder: "비밀번호를 입력하세요"
        )
        
        content += renderFormField(
            name: "rememberMe",
            label: "로그인 상태 유지",
            type: .checkbox,
            value: "false"
        )
        
        content += renderFormActions(primaryText: "로그인")
        content += "</form></div>"
        return content
    }
    
    public func renderSettingsForm(config: BlogConfig) -> String {
        var content = """
        <div class="settings-form">
            <h1>블로그 설정</h1>
            <form id="settings-form" method="POST" action="/admin/settings">
        """
        
        // Basic Settings
        content += "<fieldset><legend>기본 설정</legend>"
        
        content += renderFormField(
            name: "siteName",
            label: "사이트 이름",
            value: config.siteName,
            required: true
        )
        
        content += renderFormField(
            name: "siteDescription",
            label: "사이트 설명",
            type: .textarea,
            value: config.siteDescription
        )
        
        content += renderFormField(
            name: "siteUrl",
            label: "사이트 URL",
            type: .url,
            value: config.siteUrl
        )
        
        content += renderFormField(
            name: "adminEmail",
            label: "관리자 이메일",
            type: .email,
            value: config.adminEmail
        )
        
        content += "</fieldset>"
        
        // Post Settings
        content += "<fieldset><legend>포스트 설정</legend>"
        
        content += renderFormField(
            name: "postsPerPage",
            label: "페이지당 포스트 수",
            type: .number,
            value: String(config.postsPerPage)
        )
        
        content += renderFormField(
            name: "allowComments",
            label: "댓글 허용",
            type: .checkbox,
            value: config.allowComments ? "true" : "false"
        )
        
        content += renderFormField(
            name: "moderateComments",
            label: "댓글 검토",
            type: .checkbox,
            value: config.moderateComments ? "true" : "false"
        )
        
        content += "</fieldset>"
        
        // SEO Settings
        content += "<fieldset><legend>SEO 설정</legend>"
        
        content += renderFormField(
            name: "seoTitle",
            label: "SEO 제목",
            value: config.seoTitle ?? ""
        )
        
        content += renderFormField(
            name: "seoDescription",
            label: "SEO 설명",
            type: .textarea,
            value: config.seoDescription ?? ""
        )
        
        content += "</fieldset>"
        
        content += renderFormActions(primaryText: "설정 저장")
        content += "</form></div>"
        return content
    }
}

// MARK: - FormFieldType

public enum FormFieldType: String {
    case text = "text"
    case email = "email"
    case password = "password"
    case url = "url"
    case number = "number"
    case textarea = "textarea"
    case select = "select"
    case checkbox = "checkbox"
    case radio = "radio"
}
