import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  esbuild: {
    keepNames: true, // Keep class names during minification
  },
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
      external: ['vue', '@ionic/vue', 'ionicons/icons'],
      output: {
        globals: {
          vue: 'Vue',
          '@ionic/vue': 'IonicVue',
          'ionicons/icons': 'IoniconsIcons'
        }
      }
    }
  }
})
