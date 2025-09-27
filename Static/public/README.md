# Static/Public Directory

이 디렉토리는 개발 중에 Swift WASM 파일이 복사되는 곳입니다.

## 파일 설명

- `Blog.wasm`: Swift로 컴파일된 WebAssembly 파일
- 기타 정적 자산들 (이미지, 폰트 등)

## 빌드 과정

개발 모드:

```bash
npm run swift:wasm:dev
# 또는
make dev-swift
```

프로덕션 빌드:

```bash
npm run swift:wasm:build
# 또는
make build-swift
```

빌드된 WASM 파일은 `Static/dist/` 디렉토리로 복사됩니다.
