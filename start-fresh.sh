#!/bin/bash

echo "🚀 블로그 서버 완전 새로 시작"
echo "=========================="

# 기존 데이터베이스 삭제 및 재생성
echo "🗄️ 데이터베이스 초기화 중..."
psql -d postgres -c "DROP DATABASE IF EXISTS blog_db;" 2>/dev/null || echo "데이터베이스 삭제 시도"
psql -d postgres -c "CREATE DATABASE blog_db;" 2>/dev/null || echo "데이터베이스 생성 시도"

# 환경 변수 설정
export ADMIN_EMAIL="jihoonahn.dev@gmail.com"
export ADMIN_PASSWORD="2848hoon"
export JWT_SECRET="test-jwt-scret"

echo "📧 Admin Email: $ADMIN_EMAIL"
echo "📧 Admin Password: $ADMIN_PASSWORD"
echo "🗄️ 데이터베이스: blog_db"
echo ""

# 서버 실행
swift run Server serve --port 8080
