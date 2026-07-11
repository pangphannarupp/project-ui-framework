import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue({
      customElement: true
    })
  ],
  build: {
    emptyOutDir: false, // Don't empty out the standard build dir
    lib: {
      entry: resolve(__dirname, 'src/web-components.ts'),
      name: 'UIFrameworkWC',
      fileName: (format) => `wc/ui-framework-wc.${format}.js`
    },
    rollupOptions: {
      // For Web Components, we typically bundle Vue, but if we don't, we can externalize it.
      // Assuming consumers might not have Vue, we let Vite bundle the necessary Vue Custom Element runtime.
      // So we don't externalize vue here.
    }
  }
})
