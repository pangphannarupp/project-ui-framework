import { ref, computed, onMounted } from 'vue'
import { mockLogs, type AuditLog } from '../data/mockData'

export function useLogViewerViewModel() {
  const logs = ref<AuditLog[]>([])
  const isLoading = ref(true)
  const filterLevel = ref('all')
  const searchQuery = ref('')
  const isStreaming = ref(true)
  const currentPage = ref(1)
  const pageSize = ref(8)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      logs.value = [...mockLogs]
      isLoading.value = false
    }, 400)
  })

  const levels = ['all', 'info', 'warn', 'error', 'success']

  const filteredLogs = computed(() => {
    return logs.value.filter(l => {
      const matchLevel = filterLevel.value === 'all' || l.level === filterLevel.value
      const matchSearch = l.action.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          l.actor.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          l.target.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          l.details.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          l.ip.includes(searchQuery.value)
      return matchLevel && matchSearch
    })
  })

  const totalFilteredLogs = computed(() => filteredLogs.value.length)

  const paginatedLogs = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value
    return filteredLogs.value.slice(start, start + pageSize.value)
  })

  const getBadgeVariant = (lvl: string): 'success' | 'warning' | 'danger' | 'info' => {
    if (lvl === 'success') return 'success'
    if (lvl === 'warn') return 'warning'
    if (lvl === 'error') return 'danger'
    return 'info'
  }

  const clearLogs = () => {
    logs.value = []
  }

  const generateSampleLog = () => {
    const sampleActions = ['TOKEN_REFRESH', 'SANDBOX_RELOAD', 'CACHE_PURGE', 'RATE_LIMIT_HIT']
    const sampleActors = ['SYSTEM_DAEMON', 'Phanna Pang', 'Cron Worker', 'Gateway Router']
    const sampleTargets = ['mini-cinema', 'smart-mini-app', 'Payment Proxy', 'Auth Server']
    const sampleLevels: ('info' | 'warn' | 'error' | 'success')[] = ['info', 'warn', 'success', 'error']

    const randomIdx = Math.floor(Math.random() * 4)

    logs.value.unshift({
      id: `log-${Date.now()}`,
      timestamp: new Date().toISOString().replace('T', ' ').slice(0, 19),
      action: sampleActions[randomIdx],
      actor: sampleActors[randomIdx],
      target: sampleTargets[randomIdx],
      level: sampleLevels[randomIdx],
      details: 'Auto-generated telemetry heartbeat snapshot',
      ip: '10.244.0.8'
    })
  }

  return {
    logs,
    isLoading,
    filterLevel,
    searchQuery,
    isStreaming,
    currentPage,
    pageSize,
    totalFilteredLogs,
    levels,
    filteredLogs,
    paginatedLogs,
    getBadgeVariant,
    clearLogs,
    generateSampleLog
  }
}
