import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import UIFramework from '@phanna/ui-framework'
import '@phanna/ui-framework/style.css'
import './style.css'

const app = createApp(App)
app.use(UIFramework as any)
app.use(router)
app.mount('#app')
