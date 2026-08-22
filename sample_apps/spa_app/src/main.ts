import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import uiFramework from '@phanna/ui-framework'
import '@phanna/ui-framework/style.css'

const app = createApp(App)

app.use(router)
app.use(uiFramework as any)

app.mount('#app')
