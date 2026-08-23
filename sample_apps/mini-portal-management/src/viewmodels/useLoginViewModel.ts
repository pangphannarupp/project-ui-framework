import { ref } from 'vue'
import { useRouter } from 'vue-router'

export function useLoginViewModel() {
  const router = useRouter()
  const email = ref('admin@mcnc.biz')
  const password = ref('••••••••••••')
  const rememberMe = ref(true)
  const isLoading = ref(false)

  const handleLogin = () => {
    isLoading.value = true
    setTimeout(() => {
      isLoading.value = false
      router.push('/dashboard')
    }, 600)
  }

  const fillQuickLogin = (roleEmail: string) => {
    email.value = roleEmail
    password.value = 'password123'
    handleLogin()
  }

  return {
    email,
    password,
    rememberMe,
    isLoading,
    handleLogin,
    fillQuickLogin
  }
}
