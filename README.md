# Swift Blog

Swift 6.0으로 만든 정적 사이트 생성기 (Static Site Generator)

## ✨ 특징

- 🚀 **Swift 6.0** - 최신 Swift 기능 활용 (Sendable, Strict Concurrency)
- 📝 **Markdown 지원** - 마크다운 파일을 자동으로 HTML로 변환
- 🎨 **Tailwind CSS** - 유틸리티 기반 CSS 프레임워크
- ⚡ **Vite** - 빠른 개발 서버
- 🌳 **중첩 구조** - JSON 스타일의 페이지 구조
- 🎯 **커스텀 레이아웃** - Swift로 작성하는 HTML 템플릿

## 📦 설치

### 1. Swift 의존성 설치

```bash
swift build
```

### 2. Node.js 의존성 설치

```bash
npm install
```

## 🚀 사용법

### 블로그 빌드

```bash
# 1. Tailwind CSS 빌드
npm run css:build

# 2. Swift 블로그 생성
swift run Blog

# 또는 한 번에
npm run css:build && swift run Blog
```

### 개발 모드

```bash
# Tailwind CSS watch 모드
npm run css:watch

# 다른 터미널에서 프리뷰 서버 실행
swift run Blog preview
```

### Vite 개발 서버 사용

```bash
npm run dev
```

## 📁 프로젝트 구조

```
swiftblog/
├── Sources/
│   ├── Blog/              # 메인 실행 파일
│   │   ├── main.swift
│   │   ├── Pages/         # 페이지 정의
│   │   ├── Layouts/       # 레이아웃 컴포넌트
│   │   ├── Components/    # 재사용 컴포넌트
│   │   └── Styles/        # CSS 파일
│   │       ├── input.css  # Tailwind 입력
│   │       └── global.css # 추가 스타일
│   ├── Generator/         # 사이트 생성 엔진
│   │   ├── Generator.swift
│   │   ├── Content.swift
│   │   ├── Post.swift
│   │   └── MarkdownParse.swift
│   ├── Web/              # HTML DSL 라이브러리
│   └── Content/          # 마크다운 블로그 포스트
│       ├── *.md
│       └── tutorials/
│           └── *.md
├── Public/               # 정적 파일 (dist에 복사됨)
│   ├── favicon.ico
│   └── styles.css       # Tailwind가 생성
├── dist/                # 빌드 결과물
├── Package.swift        # Swift 패키지
├── package.json         # Node.js 패키지
├── tailwind.config.js   # Tailwind 설정
├── vite.config.js       # Vite 설정
└── postcss.config.js    # PostCSS 설정
```

## 📝 콘텐츠 작성

### 1. 마크다운 파일 생성

```bash
# Sources/Content/ 폴더에 마크다운 파일 추가
echo "# My New Post" > Sources/Content/my-post.md
```

### 2. 중첩 폴더 지원

```bash
mkdir -p Sources/Content/tutorials
echo "# Tutorial 1" > Sources/Content/tutorials/tutorial-1.md
```

→ 자동으로 `dist/blog/tutorials/tutorial-1.html` 생성

### 3. 페이지 정의 (main.swift)

```swift
let pages = [
    Page(
        name: "Blog",
        path: "blog",
        html: blogIndex(),
        children: try content.load()  // 자동으로 마크다운 로드
    )
]
```

## 🎨 스타일링

### Tailwind CSS 사용

1. **input.css 편집** (`Sources/Blog/Styles/input.css`)
2. **빌드**:
   ```bash
   npm run css:build
   ```

### 커스텀 CSS 추가

- `Sources/Blog/Styles/global.css` - 자동으로 `dist/`에 복사됨
- `Public/` 폴더의 모든 파일 - `dist/` 루트에 복사됨

## 🛠️ NPM 스크립트

```bash
# Tailwind CSS 빌드
npm run css:build

# Tailwind CSS watch 모드 (자동 재빌드)
npm run css:watch

# Vite 개발 서버 (HMR 지원)
npm run dev

# Vite 프로덕션 빌드
npm run build

# Vite 프리뷰
npm run preview
```

## 🔧 Swift 명령어

```bash
# 블로그 빌드
swift run Blog

# 프리뷰 서버 (Python)
swift run Blog preview

# 빌드 & 테스트
swift build
swift test
```

## 📦 의존성

### Swift

- **swift-markdown** - 마크다운 파싱
- **swift-log** - 로깅
- **swift-file** - 파일 시스템
- **swift-command** - 커맨드 실행

### Node.js

- **tailwindcss** - CSS 프레임워크
- **vite** - 빌드 도구
- **postcss** - CSS 후처리
- **autoprefixer** - CSS 벤더 프리픽스

## 🚀 워크플로우

### 개발

```bash
# 터미널 1: Tailwind watch
npm run css:watch

# 터미널 2: Swift 빌드 & 프리뷰
swift run Blog preview

# 또는 Vite 사용
npm run dev
```

### 프로덕션 빌드

```bash
# CSS 빌드
npm run css:build

# 블로그 생성
swift run Blog

# 결과물: dist/ 폴더
```

## 📄 라이선스

MIT License

## 👤 Author

@jihoonahn
