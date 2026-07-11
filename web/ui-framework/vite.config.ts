import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import * as fs from 'fs'

export default defineConfig({
  plugins: [
    vue(),
    {
      name: 'copy-khmer-date',
      closeBundle() {
        if (!fs.existsSync(resolve(__dirname, 'dist'))) {
          fs.mkdirSync(resolve(__dirname, 'dist'), { recursive: true });
        }
        fs.copyFileSync(
          resolve(__dirname, 'src/utils/KhmerDate.ts'),
          resolve(__dirname, 'dist/KhmerDate.ts')
        );
      }
    }
  ],
  build: {
    minify: false,
    lib: {
      entry: {
        'ui-framework': resolve(__dirname, 'src/index.ts')
      },
      name: 'UIFramework'
    },
    rollupOptions: {
      external: ['vue'],
      output: {
        globals: {
          vue: 'Vue'
        }
      }
    }
  }
})
