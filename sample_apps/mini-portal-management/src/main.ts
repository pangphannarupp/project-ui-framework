import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import '@phanna/ui-framework/style.css'
import './style.css'

const app = createApp(App)
app.use(router)
app.mount('#app')
