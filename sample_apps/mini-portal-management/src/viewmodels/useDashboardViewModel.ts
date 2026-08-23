import { ref, onMounted } from 'vue'
import { mockMiniApps, mockLogs, type MiniApp, type AuditLog } from '../data/mockData'

export function useDashboardViewModel() {
  const isLoading = ref(true)

  const kpis = [
    { title: 'Registered Mini Apps', value: '30 Apps', change: '+4 this month', icon: 'apps', positive: true },
    { title: 'Monthly Active Users', value: '168,420', change: '+18.2%', icon: 'users', positive: true },
    { title: 'Payment Volume (Bakong/PayWay)', value: '$1.42M', change: '+24.5%', icon: 'card', positive: true },
    { title: 'Push Delivery Rate', value: '98.8%', change: '-0.2%', icon: 'bell', positive: false }
  ]

  const recentApps = ref<MiniApp[]>([])
  const recentLogs = ref<AuditLog[]>([])
  const selectedTimeRange = ref('7 Days')

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      recentApps.value = mockMiniApps.slice(0, 4)
      recentLogs.value = mockLogs.slice(0, 4)
      isLoading.value = false
    }, 450)
  })

  const getChipColor = (level: string): 'success' | 'warning' | 'danger' | 'info' => {
    switch (level) {
      case 'success': return 'success'
      case 'warn': return 'warning'
      case 'error': return 'danger'
      default: return 'info'
    }
  }

  return {
    isLoading,
    kpis,
    recentApps,
    recentLogs,
    selectedTimeRange,
    getChipColor
  }
}
