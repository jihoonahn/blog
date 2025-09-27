// Swift Blog - Main JavaScript Entry Point
import { WasmFs } from "@wasmer/wasmfs";
import { init, WASI } from "@wasmer/wasi";
import { lowerI64Imports } from "@wasmer/wasm-transformer";
import { Buffer } from "buffer";
import { createClient } from "@supabase/supabase-js";

// Buffer polyfill
globalThis.Buffer = Buffer;

// Supabase client
const supabaseUrl =
  import.meta.env.VITE_SUPABASE_URL || "https://your-project.supabase.co";
const supabaseKey = import.meta.env.VITE_SUPABASE_ANON_KEY || "your-anon-key";
const supabase = createClient(supabaseUrl, supabaseKey);

// Global variables
let wasmModule = null;
let wasmInstance = null;
let wasmFs = null;
let wasi = null;

// Initialize the application
async function initApp() {
  try {
    console.log("🚀 Initializing Swift Blog...");

    // Show loading screen
    showLoadingScreen();

    // Try to load Swift WASM, fallback to mock if fails
    try {
      await loadSwiftWasm();
      console.log("✅ Swift WASM loaded successfully");
      // Swift WASM이 로드되면 Swift에서 렌더링
      await initializeSwiftBlog();
    } catch (error) {
      console.warn("⚠️ Swift WASM not available, using mock data:", error);
      initializeMockBlog();
    }

    // Hide loading screen and show app
    hideLoadingScreen();
    showApp();

    console.log("✅ Swift Blog initialized successfully!");
  } catch (error) {
    console.error("❌ Failed to initialize Swift Blog:", error);
    showError("앱을 초기화하는 중 오류가 발생했습니다: " + error.message);
  }
}

// Load Swift WASM module
async function loadSwiftWasm() {
  console.log("📦 Loading Swift WASM module...");

  // Initialize WASI
  await init();
  wasmFs = new WasmFs();

  // Fetch WASM file
  const wasmResponse = await fetch("/Blog.wasm");
  if (!wasmResponse.ok) {
    throw new Error(`Failed to fetch WASM: ${wasmResponse.status}`);
  }

  const wasmBytes = await wasmResponse.arrayBuffer();

  // Transform WASM to lower i64 imports
  const loweredWasmBytes = await lowerI64Imports(wasmBytes);

  // Compile WASM module
  wasmModule = await WebAssembly.compile(loweredWasmBytes);

  // Create WASI instance
  wasi = new WASI({
    env: {
      NODE_ENV: "production",
      SUPABASE_URL: "https://your-project.supabase.co",
      SUPABASE_ANON_KEY: "your-anon-key",
    },
    args: [],
    preopens: {
      "/": "/",
      "/tmp": "/tmp",
    },
  });

  // Instantiate WASM module
  const importObject = wasi.getImports(wasmModule);
  wasmInstance = await WebAssembly.instantiate(wasmModule, importObject);

  // Start WASI
  wasi.start(wasmInstance);

  console.log("✅ Swift WASM module loaded successfully");
}

// Initialize Mock Blog (fallback)
function initializeMockBlog() {
  console.log("🎭 Initializing mock blog functionality...");

  // Mock blog data
  const mockPosts = [
    {
      id: "1",
      title: "Swift Blog에 오신 것을 환영합니다!",
      content: `이것은 JavaScriptKit을 사용한 Swift WASM 블로그입니다. 

현재는 Mock 데이터를 사용하고 있으며, 곧 실제 Swift WASM 기능이 추가될 예정입니다.

이 블로그는 다음과 같은 특징을 가지고 있습니다:
- Swift WASM을 사용한 클라이언트 사이드 렌더링
- Supabase를 통한 데이터 관리
- Tailwind CSS를 사용한 현대적인 디자인
- PWA 기능 지원

앞으로 더 많은 기능이 추가될 예정이니 기대해주세요!`,
      excerpt: "JavaScriptKit을 사용한 Swift WASM 블로그입니다.",
      author: "Jihoon Ahn",
      createdAt: new Date().toISOString(),
      tags: ["swift", "wasm", "blog"],
      category: "소개",
    },
    {
      id: "2",
      title: "JavaScriptKit의 장점",
      content: `JavaScriptKit은 Swift 코드를 WebAssembly로 컴파일하여 브라우저에서 실행할 수 있게 해줍니다. 

주요 장점:
1. 네이티브 성능 - WebAssembly의 빠른 실행 속도
2. 크로스 플랫폼 호환성 - 모든 브라우저에서 동일한 성능
3. Swift 생태계 활용 - 기존 Swift 라이브러리 사용 가능
4. 타입 안전성 - 컴파일 타임 오류 검출

이를 통해 네이티브 성능과 크로스 플랫폼 호환성을 동시에 얻을 수 있습니다.

실제 사용 예시와 더 자세한 내용은 다음 포스트에서 다루겠습니다.`,
      excerpt: "JavaScriptKit의 장점과 활용 방법에 대해 알아보겠습니다.",
      author: "Jihoon Ahn",
      createdAt: new Date(Date.now() - 86400000).toISOString(),
      tags: ["swift", "javascriptkit", "webassembly"],
      category: "기술",
    },
    {
      id: "3",
      title: "Supabase와의 연동",
      content: `Supabase는 Firebase의 오픈소스 대안으로, PostgreSQL 기반의 백엔드 서비스를 제공합니다.

주요 기능:
- 실시간 데이터베이스
- 인증 시스템
- 파일 스토리지
- API 자동 생성
- Edge Functions

이 블로그에서는 Supabase를 다음과 같이 활용하고 있습니다:
1. 블로그 포스트 데이터 저장
2. 댓글 시스템
3. 사용자 인증
4. 실시간 업데이트

PostgreSQL의 강력한 기능과 Supabase의 편리한 API를 통해 안정적이고 확장 가능한 백엔드를 구축할 수 있습니다.`,
      excerpt: "Supabase를 활용한 백엔드 구축 방법을 알아보겠습니다.",
      author: "Jihoon Ahn",
      createdAt: new Date(Date.now() - 172800000).toISOString(),
      tags: ["supabase", "database", "backend"],
      category: "기술",
    },
    {
      id: "4",
      title: "개발 일지 - 첫 번째 주",
      content: `블로그 개발을 시작한 지 일주일이 지났습니다.

이번 주에 완성한 것들:
- 기본적인 블로그 구조 설정
- Swift WASM 환경 구성
- Mock 데이터 시스템 구축
- SPA 라우팅 구현

아직 해결해야 할 과제들:
- 실제 Swift WASM 컴파일 및 실행
- Supabase 연동
- 댓글 시스템 구현
- 관리자 페이지 개발

다음 주 목표는 Swift WASM이 제대로 작동하도록 하는 것입니다. JavaScriptKit과의 호환성 문제를 해결해야 합니다.`,
      excerpt: "블로그 개발 첫 주의 경험과 느낀 점을 공유합니다.",
      author: "Jihoon Ahn",
      createdAt: new Date(Date.now() - 259200000).toISOString(),
      tags: ["개발일지", "swift", "wasm"],
      category: "일상",
    },
  ];

  // Store mock data globally
  window.mockBlogData = {
    posts: mockPosts,
    categories: ["소개", "기술", "일상"],
    tags: ["swift", "wasm", "blog", "webassembly", "javascriptkit"],
  };

  // Initialize routing
  initializeRouting();

  console.log("✅ Mock blog initialized successfully");
}

// Initialize Swift Blog
async function initializeSwiftBlog() {
  console.log("🍎 Initializing Swift blog functionality...");

  // Swift WASM이 로드되면 Swift에서 모든 렌더링을 처리
  // JavaScript는 Swift와의 브릿지 역할만 수행

  // Swift에서 렌더링된 HTML을 받아서 DOM에 삽입하는 함수
  window.updateContent = function (html) {
    document.getElementById("app").innerHTML = html;
  };

  // Swift에서 네비게이션을 처리하도록 설정
  window.navigateToSwift = function (path) {
    // Swift WASM에서 네비게이션 처리
    console.log("Swift navigation to:", path);
    // 실제로는 Swift WASM의 네비게이션 함수를 호출
  };

  // Swift WASM이 초기화되면 초기 페이지 렌더링
  // 실제로는 Swift의 WebBlogApp.start()를 호출
  console.log("✅ Swift blog initialized successfully");
}

// Load posts from Supabase
async function loadPostsFromSupabase() {
  try {
    const { data: posts, error } = await supabase
      .from("posts")
      .select("*")
      .eq("published", true)
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Error loading posts:", error);
      return [];
    }

    return posts || [];
  } catch (error) {
    console.error("Error loading posts from Supabase:", error);
    return [];
  }
}

// Load categories from Supabase
async function loadCategoriesFromSupabase() {
  try {
    const { data: categories, error } = await supabase
      .from("categories")
      .select("*")
      .order("name");

    if (error) {
      console.error("Error loading categories:", error);
      return [];
    }

    return categories || [];
  } catch (error) {
    console.error("Error loading categories from Supabase:", error);
    return [];
  }
}

// Initialize routing
function initializeRouting() {
  // Handle browser back/forward buttons
  window.addEventListener("popstate", () => {
    navigateTo(window.location.pathname);
  });

  // Handle initial route
  navigateTo(window.location.pathname);
}

// Navigate to a route
function navigateTo(path) {
  console.log("Navigating to:", path);

  // Update URL without page reload
  if (window.location.pathname !== path) {
    window.history.pushState(null, null, path);
  }

  // Route handling
  if (path === "/") {
    renderHomePage();
  } else if (path === "/posts") {
    renderPostsPage();
  } else if (path === "/about") {
    renderAboutPage();
  } else if (path.startsWith("/posts/")) {
    const slug = path.split("/posts/")[1];
    renderPostDetail(slug);
  } else {
    renderNotFoundPage();
  }
}

// Render home page
function renderHomePage() {
  const posts = window.mockBlogData?.posts || [];

  let html = `
    <div class="home-page">
      <nav class="main-nav">
        <div class="nav-brand">
          <h1>Swift Blog</h1>
        </div>
        <div class="nav-links">
          <a href="#" onclick="navigateTo('/')">홈</a>
          <a href="#" onclick="navigateTo('/posts')">포스트</a>
          <a href="#" onclick="navigateTo('/about')">소개</a>
        </div>
      </nav>
      
      <section class="hero">
        <h1>Swift Blog에 오신 것을 환영합니다!</h1>
        <p>JavaScriptKit을 사용한 Swift WASM 블로그입니다.</p>
      </section>
      
      <section class="recent-posts">
        <h2>최근 포스트</h2>
        <div class="posts-grid">
  `;

  posts.forEach((post) => {
    html += `
      <div class="post-card" onclick="navigateTo('/posts/${
        post.id
      }')" style="cursor: pointer;">
        <h3>${post.title}</h3>
        <p>${post.excerpt}</p>
        <div class="post-meta">
          <span>작성자: ${post.author}</span>
          <span>카테고리: ${post.category}</span>
        </div>
        <div class="post-tags">
          ${post.tags.map((tag) => `<span class="tag">${tag}</span>`).join("")}
        </div>
      </div>
    `;
  });

  html += `
        </div>
      </section>
    </div>
  `;

  document.getElementById("app").innerHTML = html;
}

// Render posts page
function renderPostsPage() {
  const posts = window.mockBlogData?.posts || [];

  let html = `
    <div class="posts-page">
      <nav class="main-nav">
        <div class="nav-brand">
          <h1>Swift Blog</h1>
        </div>
        <div class="nav-links">
          <a href="#" onclick="navigateTo('/')">홈</a>
          <a href="#" onclick="navigateTo('/posts')" class="active">포스트</a>
          <a href="#" onclick="navigateTo('/about')">소개</a>
        </div>
      </nav>
      
      <div class="page-content">
        <h1>모든 포스트</h1>
        <div class="posts-grid">
  `;

  posts.forEach((post) => {
    html += `
      <div class="post-card" onclick="navigateTo('/posts/${
        post.id
      }')" style="cursor: pointer;">
        <h3>${post.title}</h3>
        <p>${post.excerpt}</p>
        <div class="post-meta">
          <span>작성자: ${post.author}</span>
          <span>카테고리: ${post.category}</span>
          <span>작성일: ${new Date(post.createdAt).toLocaleDateString(
            "ko-KR"
          )}</span>
        </div>
        <div class="post-tags">
          ${post.tags.map((tag) => `<span class="tag">${tag}</span>`).join("")}
        </div>
      </div>
    `;
  });

  html += `
        </div>
      </div>
    </div>
  `;

  document.getElementById("app").innerHTML = html;
}

// Render post detail page
function renderPostDetail(postId) {
  const posts = window.mockBlogData?.posts || [];
  const post = posts.find((p) => p.id === postId);

  if (!post) {
    renderNotFoundPage();
    return;
  }

  const html = `
    <div class="post-detail-page">
      <nav class="main-nav">
        <div class="nav-brand">
          <h1>Swift Blog</h1>
        </div>
        <div class="nav-links">
          <a href="#" onclick="navigateTo('/')">홈</a>
          <a href="#" onclick="navigateTo('/posts')">포스트</a>
          <a href="#" onclick="navigateTo('/about')">소개</a>
        </div>
      </nav>
      
      <div class="post-header">
        <button onclick="navigateTo('/')" class="btn btn-secondary">← 뒤로가기</button>
      </div>
      
      <article class="post-content">
        <header class="post-header-content">
          <h1>${post.title}</h1>
          <div class="post-meta">
            <span>작성자: ${post.author}</span>
            <span>카테고리: ${post.category}</span>
            <span>작성일: ${new Date(post.createdAt).toLocaleDateString(
              "ko-KR"
            )}</span>
          </div>
          <div class="post-tags">
            ${post.tags
              .map((tag) => `<span class="tag">${tag}</span>`)
              .join("")}
          </div>
        </header>
        
        <div class="post-body">
          ${post.content
            .split("\n")
            .map((paragraph) => (paragraph.trim() ? `<p>${paragraph}</p>` : ""))
            .join("")}
        </div>
      </article>
      
      <div class="post-footer">
        <button onclick="navigateTo('/')" class="btn btn-primary">홈으로 돌아가기</button>
        <button onclick="navigateTo('/posts')" class="btn btn-secondary">모든 포스트 보기</button>
      </div>
    </div>
  `;

  document.getElementById("app").innerHTML = html;
}

// Render about page
function renderAboutPage() {
  const html = `
    <div class="about-page">
      <nav class="main-nav">
        <div class="nav-brand">
          <h1>Swift Blog</h1>
        </div>
        <div class="nav-links">
          <a href="#" onclick="navigateTo('/')">홈</a>
          <a href="#" onclick="navigateTo('/posts')">포스트</a>
          <a href="#" onclick="navigateTo('/about')" class="active">소개</a>
        </div>
      </nav>
      
      <div class="page-content">
        <h1>소개</h1>
        <div class="about-content">
          <p>이 블로그는 Swift WASM과 Supabase를 사용하여 구축되었습니다.</p>
          
          <h2>개발자 정보</h2>
          <p><strong>이름:</strong> Jihoon Ahn</p>
          
          <h2>기술 스택</h2>
          <ul>
            <li>Swift - 메인 개발 언어</li>
            <li>JavaScriptKit - Swift to WebAssembly 컴파일</li>
            <li>Supabase - 백엔드 서비스</li>
            <li>Tailwind CSS - 스타일링</li>
            <li>Vite - 빌드 도구</li>
            <li>Netlify - 배포 플랫폼</li>
          </ul>
          
          <h2>블로그 특징</h2>
          <ul>
            <li>Swift WASM을 사용한 클라이언트 사이드 렌더링</li>
            <li>실시간 데이터 동기화</li>
            <li>반응형 디자인</li>
            <li>PWA 지원</li>
          </ul>
        </div>
      </div>
    </div>
  `;
  document.getElementById("app").innerHTML = html;
}

// Render 404 page
function renderNotFoundPage() {
  const html = `
    <div class="error-page">
      <nav class="main-nav">
        <div class="nav-brand">
          <h1>Swift Blog</h1>
        </div>
        <div class="nav-links">
          <a href="#" onclick="navigateTo('/')">홈</a>
          <a href="#" onclick="navigateTo('/posts')">포스트</a>
          <a href="#" onclick="navigateTo('/about')">소개</a>
        </div>
      </nav>
      
      <div class="page-content">
        <h1>404 - 페이지를 찾을 수 없습니다</h1>
        <p>요청하신 페이지를 찾을 수 없습니다.</p>
        <div class="error-actions">
          <button onclick="navigateTo('/')" class="btn btn-primary">홈으로 돌아가기</button>
          <button onclick="navigateTo('/posts')" class="btn btn-secondary">포스트 보기</button>
        </div>
      </div>
    </div>
  `;
  document.getElementById("app").innerHTML = html;
}

// Load WASM module
async function loadWasmModule() {
  try {
    console.log("📦 Loading WASM module...");

    // Fetch WASM file
    const wasmResponse = await fetch("/Blog.wasm");
    if (!wasmResponse.ok) {
      throw new Error(`Failed to fetch WASM: ${wasmResponse.status}`);
    }

    const wasmBytes = await wasmResponse.arrayBuffer();

    // Transform WASM to lower i64 imports
    const loweredWasmBytes = await lowerI64Imports(wasmBytes);

    // Compile WASM module
    wasmModule = await WebAssembly.compile(loweredWasmBytes);

    console.log("✅ WASM module loaded successfully");
  } catch (error) {
    console.error("❌ Failed to load WASM module:", error);
    throw error;
  }
}

// Initialize Swift app
async function initializeSwiftApp() {
  try {
    console.log("🔧 Initializing Swift app...");

    // Create WASI instance
    wasi = new WASI({
      env: {
        // Environment variables
        NODE_ENV: "production",
        SUPABASE_URL:
          process.env.SUPABASE_URL || "https://your-project.supabase.co",
        SUPABASE_ANON_KEY: process.env.SUPABASE_ANON_KEY || "your-anon-key",
      },
      args: [],
      preopens: {
        "/": "/",
        "/tmp": "/tmp",
      },
    });

    // Instantiate WASM module
    const importObject = wasi.getImports(wasmModule);
    wasmInstance = await WebAssembly.instantiate(wasmModule, importObject);

    // Start WASI
    wasi.start(wasmInstance);

    console.log("✅ Swift app initialized successfully");
  } catch (error) {
    console.error("❌ Failed to initialize Swift app:", error);
    throw error;
  }
}

// UI Helper Functions
function showLoadingScreen() {
  const loadingScreen = document.getElementById("loading-screen");
  const app = document.getElementById("app");

  if (loadingScreen) loadingScreen.style.display = "flex";
  if (app) app.style.display = "none";
}

function hideLoadingScreen() {
  const loadingScreen = document.getElementById("loading-screen");
  const app = document.getElementById("app");

  if (loadingScreen) loadingScreen.style.display = "none";
  if (app) app.style.display = "block";
}

function showApp() {
  const app = document.getElementById("app");
  if (app) {
    app.style.display = "block";
    app.classList.add("fade-in");
  }
}

function showError(message) {
  const loadingScreen = document.getElementById("loading-screen");
  if (loadingScreen) {
    loadingScreen.innerHTML = `
            <div class="error-screen">
                <h2>오류가 발생했습니다</h2>
                <p>${message}</p>
                <button onclick="location.reload()" class="btn btn-primary">다시 시도</button>
            </div>
        `;
  }
}

// Notification System
function showNotification(message, type = "info") {
  const container = document.getElementById("notification-container");
  if (!container) return;

  const notification = document.createElement("div");
  notification.className = `notification notification-${type}`;
  notification.textContent = message;

  container.appendChild(notification);

  // Auto remove after 3 seconds
  setTimeout(() => {
    if (notification.parentNode) {
      notification.parentNode.removeChild(notification);
    }
  }, 3000);
}

// Global error handler
window.addEventListener("error", (event) => {
  console.error("Global error:", event.error);
  showNotification("예상치 못한 오류가 발생했습니다.", "error");
});

// Global unhandled promise rejection handler
window.addEventListener("unhandledrejection", (event) => {
  console.error("Unhandled promise rejection:", event.reason);
  showNotification("네트워크 오류가 발생했습니다.", "error");
});

// Service Worker Registration (for PWA)
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .then((registration) => {
        console.log("SW registered: ", registration);
      })
      .catch((registrationError) => {
        console.log("SW registration failed: ", registrationError);
      });
  });
}

// Initialize app when DOM is loaded
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initApp);
} else {
  initApp();
}

// Export functions for global access
window.SwiftBlog = {
  showNotification,
  wasmInstance,
  wasmModule,
  wasmFs,
  wasi,
};
