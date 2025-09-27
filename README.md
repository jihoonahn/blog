# Swift Blog

Swift WASM과 Supabase를 사용한 Personal Blog입니다.

## 기술 스택

- **Swift 6.2+**: 메인 프로그래밍 언어
- **JavaScriptKit**: Swift와 JavaScript 간 브릿지
- **Supabase**: 백엔드 서비스 (데이터베이스, 인증, 스토리지)
- **Tailwind CSS**: 스타일링
- **Vite**: 프론트엔드 빌드 도구
- **Netlify**: 배포 플랫폼

## 주요 기능

- **SPA (Single Page Application)**: 클라이언트 사이드 라우팅
- **관리자 패널**: 포스트, 댓글, 카테고리, 태그 관리
- **댓글 시스템**: 실시간 댓글 작성 및 관리
- **반응형 디자인**: 모바일 친화적 UI
- **SEO 최적화**: 메타 태그 및 구조화된 데이터
- **다크 모드**: 사용자 선호도에 따른 테마 전환
- **검색 기능**: 포스트 및 콘텐츠 검색
- **태그 및 카테고리**: 콘텐츠 분류 및 필터링

## 시작하기

### 1. 프로젝트 설정

```bash
# 저장소 클론
git clone https://github.com/yourusername/swift-blog.git
cd swift-blog

# 의존성 설치
make setup
```

### 2. 환경 변수 설정

`.env` 파일을 생성하고 다음 변수들을 설정하세요:

```bash
# Supabase 설정
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# 블로그 설정
BLOG_SITE_NAME="My Personal Blog"
BLOG_SITE_DESCRIPTION="A personal blog built with Swift WASM and Supabase"
BLOG_SITE_URL=https://your-blog.netlify.app
BLOG_ADMIN_EMAIL=admin@yourblog.com

# 관리자 설정
ADMIN_USERNAME=admin
ADMIN_PASSWORD=your-secure-password
ADMIN_DISPLAY_NAME="Blog Administrator"

# 보안 설정
JWT_SECRET=your-jwt-secret-key
SESSION_SECRET=your-session-secret-key
```

### 3. 개발 서버 실행

```bash
# 개발 모드로 실행
make dev

# 또는 개별 실행
make dev-swift    # Swift WASM 빌드
make dev-frontend # 프론트엔드 개발 서버
```

## 환경 변수 설정

서버 실행 전에 다음 환경 변수를 설정할 수 있습니다:

```bash
export ADMIN_EMAIL="your-email@example.com"
export ADMIN_PASSWORD="your-password"
export JWT_SECRET="your-jwt-secret"
export DATABASE_URL="postgresql://username:password@localhost:5432/blog_db"
```

## API 엔드포인트

### 인증 관련

#### 1. 관리자 로그인

**`POST /api/v1/admin/login`**

**Request:**

```json
{
  "email": "admin@blog.com",
  "password": "admin123"
}
```

**Response (200 OK):**

```json
{
  "admin": {
    "id": "E93E0CBB-3627-450C-956B-EDAFE41BCF3A",
    "email": "admin@blog.com",
    "name": "Admin",
    "createdAt": "2025-09-25T07:27:50Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (401 Unauthorized):**

```json
{
  "error": true,
  "reason": "Wrong Email or Password"
}
```

#### 2. 토큰 갱신

**`POST /api/v1/admin/refresh`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json
```

**Response (200 OK):**

```json
{
  "admin": {
    "id": "E93E0CBB-3627-450C-956B-EDAFE41BCF3A",
    "email": "admin@blog.com",
    "name": "Admin",
    "createdAt": "2025-09-25T07:27:50Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (401 Unauthorized):**

```json
{
  "error": true,
  "reason": "Token is not available"
}
```

#### 3. 관리자 프로필 조회

**`GET /api/v1/admin/profile`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (200 OK):**

```json
{
  "id": "E93E0CBB-3627-450C-956B-EDAFE41BCF3A",
  "email": "admin@blog.com",
  "name": "Admin",
  "createdAt": "2025-09-25T07:27:50Z"
}
```

### 포스트 관리 (인증 필요)

#### 1. 모든 포스트 조회 (초안 포함)

**`GET /api/v1/admin/posts`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (200 OK):**

```json
[
  {
    "id": "POST_ID",
    "title": "포스트 제목",
    "slug": "post-slug",
    "content": "포스트 내용",
    "excerpt": "포스트 요약",
    "status": "published",
    "featuredImage": "image_url",
    "tags": ["tag1", "tag2"],
    "createdAt": "2025-09-25T07:27:50Z",
    "updatedAt": "2025-09-25T07:27:50Z",
    "publishedAt": "2025-09-25T07:27:50Z"
  }
]
```

#### 2. 포스트 생성

**`POST /api/v1/admin/posts`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json
```

**Request:**

```json
{
  "title": "새 포스트 제목",
  "content": "포스트 내용",
  "excerpt": "포스트 요약",
  "status": "draft",
  "featuredImage": "image_url",
  "tags": ["tag1", "tag2"]
}
```

**Response (201 Created):**

```json
{
  "id": "NEW_POST_ID",
  "title": "새 포스트 제목",
  "slug": "new-post-slug",
  "content": "포스트 내용",
  "excerpt": "포스트 요약",
  "status": "draft",
  "featuredImage": "image_url",
  "tags": ["tag1", "tag2"],
  "createdAt": "2025-09-25T07:27:50Z",
  "updatedAt": "2025-09-25T07:27:50Z"
}
```

#### 3. 포스트 상세 조회

**`GET /api/v1/admin/posts/:id`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (200 OK):**

```json
{
  "id": "POST_ID",
  "title": "포스트 제목",
  "slug": "post-slug",
  "content": "포스트 내용",
  "excerpt": "포스트 요약",
  "status": "published",
  "featuredImage": "image_url",
  "tags": ["tag1", "tag2"],
  "createdAt": "2025-09-25T07:27:50Z",
  "updatedAt": "2025-09-25T07:27:50Z",
  "publishedAt": "2025-09-25T07:27:50Z"
}
```

#### 4. 포스트 수정

**`PUT /api/v1/admin/posts/:id`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json
```

**Request:**

```json
{
  "title": "수정된 포스트 제목",
  "content": "수정된 포스트 내용",
  "excerpt": "수정된 포스트 요약",
  "status": "published",
  "featuredImage": "new_image_url",
  "tags": ["new_tag1", "new_tag2"]
}
```

**Response (200 OK):**

```json
{
  "id": "POST_ID",
  "title": "수정된 포스트 제목",
  "slug": "updated-post-slug",
  "content": "수정된 포스트 내용",
  "excerpt": "수정된 포스트 요약",
  "status": "published",
  "featuredImage": "new_image_url",
  "tags": ["new_tag1", "new_tag2"],
  "createdAt": "2025-09-25T07:27:50Z",
  "updatedAt": "2025-09-25T08:30:00Z",
  "publishedAt": "2025-09-25T08:30:00Z"
}
```

#### 5. 포스트 삭제

**`DELETE /api/v1/admin/posts/:id`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (204 No Content):**

```
(빈 응답)
```

#### 6. 포스트 발행

**`POST /api/v1/admin/posts/:id/publish`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (200 OK):**

```json
{
  "id": "POST_ID",
  "title": "포스트 제목",
  "slug": "post-slug",
  "content": "포스트 내용",
  "excerpt": "포스트 요약",
  "status": "published",
  "featuredImage": "image_url",
  "tags": ["tag1", "tag2"],
  "createdAt": "2025-09-25T07:27:50Z",
  "updatedAt": "2025-09-25T08:30:00Z",
  "publishedAt": "2025-09-25T08:30:00Z"
}
```

### 공개 포스트 (인증 불필요)

#### 1. 발행된 포스트 목록

**`GET /api/v1/posts`**

**Query Parameters:**

- `page` (optional): 페이지 번호 (기본값: 1)
- `limit` (optional): 페이지당 포스트 수 (기본값: 10)

**Response (200 OK):**

```json
{
  "posts": [
    {
      "id": "POST_ID",
      "title": "포스트 제목",
      "slug": "post-slug",
      "excerpt": "포스트 요약",
      "featuredImage": "image_url",
      "tags": ["tag1", "tag2"],
      "publishedAt": "2025-09-25T07:27:50Z"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalPosts": 50,
    "hasNext": true,
    "hasPrev": false
  }
}
```

#### 2. 슬러그로 포스트 조회

**`GET /api/v1/posts/:slug`**

**Response (200 OK):**

```json
{
  "id": "POST_ID",
  "title": "포스트 제목",
  "slug": "post-slug",
  "content": "포스트 내용",
  "excerpt": "포스트 요약",
  "featuredImage": "image_url",
  "tags": ["tag1", "tag2"],
  "publishedAt": "2025-09-25T07:27:50Z"
}
```

**Response (404 Not Found):**

```json
{
  "error": true,
  "reason": "Post not found"
}
```

### 이미지 관리 (인증 필요)

#### 1. 이미지 업로드

**`POST /api/v1/admin/images/upload`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: multipart/form-data
```

**Request:**

```
file: [이미지 파일]
type: "featured" | "content"
```

**Response (201 Created):**

```json
{
  "id": "IMAGE_ID",
  "filename": "uploaded_image.jpg",
  "url": "/uploads/featured/uploaded_image.jpg",
  "type": "featured",
  "size": 1024000,
  "uploadedAt": "2025-09-25T07:27:50Z"
}
```

#### 2. 내 이미지 목록

**`GET /api/v1/admin/images/my`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (200 OK):**

```json
[
  {
    "id": "IMAGE_ID",
    "filename": "image.jpg",
    "url": "/uploads/featured/image.jpg",
    "type": "featured",
    "size": 1024000,
    "uploadedAt": "2025-09-25T07:27:50Z"
  }
]
```

#### 3. 이미지 삭제

**`DELETE /api/v1/admin/images/:id`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (204 No Content):**

```
(빈 응답)
```

### 댓글 시스템

#### 1. 포스트별 댓글 목록

**`GET /api/v1/comments/post/:postId`**

**Response (200 OK):**

```json
[
  {
    "id": "COMMENT_ID",
    "content": "댓글 내용",
    "authorName": "익명",
    "authorEmail": "anonymous@example.com",
    "createdAt": "2025-09-25T07:27:50Z"
  }
]
```

#### 2. 댓글 작성 (익명)

**`POST /api/v1/comments/post/:postId`**

**Request:**

```json
{
  "content": "댓글 내용",
  "authorName": "익명",
  "authorEmail": "anonymous@example.com"
}
```

**Response (201 Created):**

```json
{
  "id": "NEW_COMMENT_ID",
  "content": "댓글 내용",
  "authorName": "익명",
  "authorEmail": "anonymous@example.com",
  "createdAt": "2025-09-25T07:27:50Z"
}
```

#### 3. 댓글 삭제 (관리자만)

**`DELETE /api/v1/admin/comments/:id`**

**Headers:**

```
Authorization: Bearer YOUR_JWT_TOKEN
```

**Response (204 No Content):**

```
(빈 응답)
```

### 공통 에러 응답

#### 401 Unauthorized

```json
{
  "error": true,
  "reason": "Need Verified Token"
}
```

#### 422 Unprocessable Entity

```json
{
  "error": true,
  "reason": "Missing 'Content-Type' header"
}
```

#### 500 Internal Server Error

```json
{
  "error": true,
  "reason": "Internal server error"
}
```

## 데이터베이스 설정

### PostgreSQL 설치 및 설정

```bash
# macOS (Homebrew)
brew install postgresql
brew services start postgresql

# 데이터베이스 생성
createdb blog_db
```

### 마이그레이션

```bash
# 마이그레이션 실행
swift run Server migrate

# 마이그레이션 되돌리기
swift run Server migrate --revert
```

## 개발 및 디버깅

### 서버 상태 확인

```bash
curl http://localhost:8080/health
```

### 로그인 테스트

```bash
curl -X POST http://localhost:8080/api/v1/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@blog.com", "password": "admin123"}'
```

### 토큰 갱신 테스트

```bash
curl -X POST http://localhost:8080/api/v1/admin/refresh \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## 문제 해결

### 포트 충돌 해결

```bash
# 8080 포트 사용 중인 프로세스 종료
lsof -ti:8080 | xargs kill -9
```

### 데이터베이스 초기화

```bash
# 데이터베이스 완전 삭제 후 재생성
psql -d postgres -c "DROP DATABASE IF EXISTS blog_db;"
psql -d postgres -c "CREATE DATABASE blog_db;"
```

### 환경 변수 확인

서버 시작 시 로그에서 환경 변수 상태를 확인할 수 있습니다:

```
[ INFO ] Environment ADMIN_EMAIL: your-email@example.com
[ INFO ] Environment ADMIN_PASSWORD: set
```

## 프로젝트 구조

```
Sources/
├── Server/                 # Vapor 서버 코드
│   ├── Controllers/        # API 컨트롤러
│   │   ├── AdminController.swift
│   │   ├── PostController.swift
│   │   ├── ImageController.swift
│   │   └── CommentController.swift
│   ├── Models/            # 데이터 모델
│   │   ├── Admin.swift
│   │   ├── Post.swift
│   │   ├── Image.swift
│   │   └── Comment.swift
│   ├── Middleware/        # 미들웨어
│   │   └── AdminAuthMiddleware.swift
│   ├── Extensions/        # 확장 기능
│   ├── Enum/             # 열거형
│   ├── Routes.swift      # 라우팅 설정
│   ├── Configure.swift   # 서버 설정
│   └── Server.swift      # 서버 진입점
└── Shared/               # 공유 코드
```

## 라이센스

**Blog Server** is under MIT license. See the [LICENSE](LICENSE) file for more info.

## 문의

프로젝트 관련 문의사항이 있으시면 [jihoonahn.dev@gmail.com](mailto:jihoonahn.dev@gmail.com)로 연락 주시기 바랍니다.
