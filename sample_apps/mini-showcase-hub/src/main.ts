import { createApp } from 'vue'
import '@phanna/ui-framework/style.css'
import './style.css'
import App from './App.vue'
import router from './router'
import UIFramework from '@phanna/ui-framework'

const app = createApp(App)

// Registration bizMOB as global
if (typeof window !== 'undefined') {
  app.config.globalProperties.$bizMOB = (window as any).bizMOB
  ;(window as any).Vue = app
}

app.use(router)
app.use(UIFramework as any)

app.mount('#app')
