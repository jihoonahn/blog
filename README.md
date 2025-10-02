# Website

A modern, static site built entirely in Swift, featuring a beautiful design and powerful functionality.

[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-macOS-lightgrey.svg)](https://developer.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## ✨ Features

- 🎨 **Beautiful Design**: Modern, responsive design with Tailwind CSS
- 📝 **Markdown Support**: Write posts in Markdown with YAML front matter
- 🔍 **Search Integration**: DocSearch integration for powerful site search
- 📱 **Mobile Responsive**: Optimized for all device sizes
- 🎯 **SEO Optimized**: Automatic RSS feeds and sitemap generation
- ⚡ **Fast Generation**: Lightning-fast static site generation
- 🎨 **Syntax Highlighting**: Beautiful code blocks with custom syntax highlighting
- 🔗 **Social Links**: Linktree-style social media integration
- 📊 **Post Navigation**: Previous/Next post navigation
- 🎭 **Copy Code**: One-click code copying functionality

## 🛠️ Tech Stack

- **Language**: Swift 6.0
- **Web Framework**: Custom Plot-inspired DSL
- **Styling**: Tailwind CSS v4
- **Build Tool**: Vite
- **File System**: swift-file
- **Command Execution**: swift-command
- **Markdown**: swift-markdown
- **Logging**: swift-log

## 📦 Installation

### Prerequisites

- macOS 13.0+
- Swift 6.0+
- Node.js 18+ (for Tailwind CSS)
- npm or yarn

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/jihoonahn/website.git
   cd website
   ```

2. **Install dependencies**

   ```bash
   # Install Node.js dependencies
   npm install

   # Build the project
   swift build
   ```

3. **Generate your blog**

   ```bash
   swift run Website
   ```

4. **Preview locally** (optional)
   ```bash
   swift run Website preview
   ```

## 📁 Project Structure

```
swift-blog-generator/
├── Sources/
│   ├── Website/           # Main website module
│   │   ├── Pages/         # Page components
│   │   ├── Components/    # Reusable components
│   │   ├── Layouts/       # Page layouts
│   │   ├── Styles/        # CSS styles
│   │   └── Contents/      # Markdown content
│   ├── Generator/         # Site generation logic
│   └── Web/              # Web framework (Plot-inspired)
├── Public/               # Static assets
├── dist/                 # Generated website
└── package.json          # Node.js dependencies
```

## 📝 Writing Posts

Create Markdown files in `Sources/Website/Contents/` with YAML front matter:

````markdown
---
title: "Hello Swift 6.0!"
date: 2025-01-01
tags: ["swift", "programming"]
image: "/image/hello-swift.jpg"
description: "Exploring the new features in Swift 6.0"
---

# Hello Swift 6.2!

This is a sample blog post written in Markdown...

```swift
func hello() {
    print("Hello, Swift 6.2!")
}
```
````

````

## 🎨 Customization

### Styling

The blog uses Tailwind CSS v4 for styling. Customize the design by editing:

- `Sources/Website/Styles/global.css` - Global styles and theme
- `tailwind.config.js` - Tailwind configuration

### Components

Add new components in `Sources/Website/Components/`:

```swift
struct MyComponent: Component {
    var body: Component {
        Div {
            Text("Hello, World!")
        }
        .class("my-custom-class")
    }
}
````

### Pages

Create new pages in `Sources/Website/Pages/`:

```swift
@HTMLBuilder
func myPage() -> HTML {
    let metadata = SiteMetaData(title: "My Page")

    Layout(metadata: metadata) {
        Main {
            H1("Welcome to My Page")
        }
    }
}
```

## 🚀 Deployment

### GitHub Pages

1. Generate your site:

   ```bash
   swift run Website
   ```

2. Push the `dist/` folder to your GitHub Pages repository

### Netlify

1. Connect your repository to Netlify
2. Set build command: `swift run Website`
3. Set publish directory: `dist`

### Vercel

1. Add `vercel.json`:
   ```json
   {
     "buildCommand": "swift run Website",
     "outputDirectory": "dist"
   }
   ```

## 🔧 Configuration

### Site Metadata

Edit `Sources/Generator/Metadata/SiteMetadata.swift`:

```swift
public struct SiteMetaData: Metadata {
    public let title: String
    public let description: String
    public let url: String
    public let favicon: Favicon?
}
```

### RSS Feed

The RSS feed is automatically generated at `/feed.rss` with all your posts.

### Sitemap

A sitemap is automatically generated at `/sitemap.xml` for SEO.

## 🎯 Features in Detail

### Search Integration

The blog includes DocSearch integration for powerful site search:

- Press `Ctrl+K` (or `Cmd+K` on Mac) to open search
- Search across all posts and pages
- Keyboard navigation support

### Code Highlighting

Beautiful syntax highlighting for multiple languages:

- Swift
- JavaScript
- Python
- HTML/CSS
- And more!

### Social Links

Linktree-style social media integration on the About page:

- GitHub
- LinkedIn
- Email
- Custom links

### Post Navigation

Navigate between posts with Previous/Next buttons:

- Automatically sorted by date
- Responsive design
- Smooth transitions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
