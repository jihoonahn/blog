---
title: Swift로 블로그 생성기 만들기
date: 2025-09-30
tags: swift, static-site-generator, markdown
image: https://picsum.photos/800/400?random=3
description: Swift를 사용하여 정적 사이트 생성기를 만드는 방법을 단계별로 알아봅니다.
---

# Swift로 블로그 생성기 만들기

Swift를 사용하여 정적 사이트 생성기를 만드는 방법을 알아봅니다.

## 프로젝트 구조

```
swiftblog/
├── Sources/
│   ├── Blog/
│   │   └── main.swift
│   ├── Generator/
│   │   ├── Generator.swift
│   │   ├── MarkdownParse.swift
│   │   └── Post.swift
│   └── Web/
│       └── ...
├── Content/
│   └── *.md
└── Package.swift
```

## 주요 기능

### 1. Markdown 파싱

Swift Markdown 라이브러리를 사용하여 마크다운 파일을 파싱합니다.

```swift
import Markdown

let document = Document(parsing: content)
```

### 2. HTML 생성

파싱된 마크다운을 HTML로 변환합니다.

### 3. 정적 파일 생성

`dist` 폴더에 정적 HTML 파일들을 생성합니다.

## 사용법

```bash
swift run Blog
```

이 명령어로 블로그를 빌드할 수 있습니다!
