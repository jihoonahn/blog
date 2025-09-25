#!/bin/bash

echo "🚀 블로그 서버 완전 새로 시작"
echo "=========================="

# 환경 변수 설정
export ADMIN_EMAIL="jihoonahn.dev@gmail.com"
export ADMIN_PASSWORD="2848hoon"
export JWT_SECRET="test-jwt-scret"

echo "📧 Admin Email: $ADMIN_EMAIL"
echo "📧 Admin Password: $ADMIN_PASSWORD"
echo "🗄️ 데이터베이스: blog_db"
echo ""

# 서버 실행
swift run Server
