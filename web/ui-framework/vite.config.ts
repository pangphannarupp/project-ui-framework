import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import * as fs from 'fs'

export default defineConfig({
  esbuild: {
    keepNames: true, // Keep class names during minification
  },
  plugins: [
    vue(),
    {
      name: 'copy-utils',
      closeBundle() {
        if (!fs.existsSync(resolve(__dirname, 'dist'))) {
          fs.mkdirSync(resolve(__dirname, 'dist'), { recursive: true });
        }
        fs.copyFileSync(
          resolve(__dirname, 'src/utils/KhmerDate.ts'),
          resolve(__dirname, 'dist/KhmerDate.ts')
        );
        fs.copyFileSync(
          resolve(__dirname, 'src/utils/UIUtil.ts'),
          resolve(__dirname, 'dist/UIUtil.ts')
        );
      }
    }
  ],
  build: {
    lib: {
      entry: {
        'ui-framework': resolve(__dirname, 'src/index.ts')
      },
      name: 'UIFramework'
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
