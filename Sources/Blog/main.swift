import Foundation
import App

// SSG (Static Site Generation)를 위한 진입점
@main
struct BlogApp {
    static func main() async {
        print("🚀 Starting Swift Blog SSG...")
        
        // WebBlogApp 인스턴스 생성
        let webBlogApp = WebBlogApp()
        
        // SSG 시작
        await webBlogApp.start()
        
        print("✅ Swift Blog SSG completed!")
    }
}