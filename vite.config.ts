import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [tailwindcss()],
  root: "Static",
  build: {
    outDir: "dist",
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: "Static/index.html"
      }
    }
  },
  define: {
    global: 'globalThis',
    'process.env': '{}',
    'Buffer': 'Buffer'
  },
  optimizeDeps: {
    exclude: ['@wasmer/wasi', '@wasmer/wasmfs', '@wasmer/wasm-transformer']
  },
  server: {
    port: 3000,
    host: true,
    open: true
  },
  preview: {
    port: 4173,
    host: true
  }
});
