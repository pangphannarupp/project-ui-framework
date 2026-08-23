import { ref, onMounted } from 'vue'
import { mockPushCampaigns, type PushCampaign } from '../data/mockData'

export interface PushGatewayConfig {
  id: string
  provider: 'FCM' | 'APNS' | 'OneSignal'
  appName: string
  environment: 'Production' | 'Sandbox'
  status: 'active' | 'inactive'
  apiKeyOrKeyId: string
  appIdOrBundleId: string
  teamIdOrProject: string
  serviceAccountFileName?: string
  serviceAccountJson?: string
  lastTestedAt: string
}

export function usePushManagementViewModel() {
  const isLoading = ref(true)
  const activeTab = ref<'campaigns' | 'configs'>('campaigns')
  const campaigns = ref<PushCampaign[]>([])

  const pushConfigs = ref<PushGatewayConfig[]>([
    {
      id: 'cfg-1',
      provider: 'FCM',
      appName: 'All Apps (Global Broadcast)',
      environment: 'Production',
      status: 'active',
      apiKeyOrKeyId: 'AIzaSyD-84kjsdf93-fkm39dklf3',
      appIdOrBundleId: 'com.miniportal.superapp',
      teamIdOrProject: 'miniportal-firebase-prod',
      serviceAccountFileName: 'miniportal-firebase-prod-adminsdk.json',
      serviceAccountJson: '{\n  "type": "service_account",\n  "project_id": "miniportal-firebase-prod"\n}',
      lastTestedAt: '2026-08-22 18:30:00'
    },
    {
      id: 'cfg-2',
      provider: 'APNS',
      appName: 'Coffee Pickup',
      environment: 'Production',
      status: 'active',
      apiKeyOrKeyId: 'AUTHKEY_849FKD9302',
      appIdOrBundleId: 'com.miniportal.coffeepickup',
      teamIdOrProject: 'TEAM_ID_849302KD',
      serviceAccountFileName: 'AuthKey_849FKD9302.p8',
      lastTestedAt: '2026-08-22 14:15:00'
    },
    {
      id: 'cfg-3',
      provider: 'FCM',
      appName: 'Mini POS Merchant',
      environment: 'Sandbox',
      status: 'active',
      apiKeyOrKeyId: 'AIzaSyA-92jdklsd8-fmm49dkss1',
      appIdOrBundleId: 'com.miniportal.posmerchant',
      teamIdOrProject: 'miniportal-pos-stage',
      serviceAccountFileName: 'miniportal-pos-adminsdk.json',
      lastTestedAt: '2026-08-21 09:45:00'
    }
  ])

  const showConfigModal = ref(false)
  const isEditingConfig = ref(false)
  const editingConfigId = ref<string | null>(null)

  const configForm = ref({
    provider: 'FCM' as 'FCM' | 'APNS' | 'OneSignal',
    appName: 'All Apps (Global Broadcast)',
    environment: 'Production' as 'Production' | 'Sandbox',
    status: 'active' as 'active' | 'inactive',
    apiKeyOrKeyId: '',
    appIdOrBundleId: '',
    teamIdOrProject: '',
    serviceAccountFileName: '',
    serviceAccountJson: ''
  })

  const newPush = ref({
    title: '',
    message: '',
    targetApp: 'Coffee Pickup',
    targetAudience: 'All Active Users',
    scheduledAt: ''
  })

  const appsList = [
    'All Apps (Global Broadcast)',
    'Coffee Pickup',
    'Smart Mini App Hub',
    'Cinema Ticket Booking',
    'EV Charge Station',
    'Mini POS Merchant'
  ]

  const audiences = [
    'All Active Users',
    'Tier >= Gold Members',
    'Users inactive for 14 days',
    'Cart Abandoners in last 24h'
  ]

  const isSending = ref(false)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      campaigns.value = [...mockPushCampaigns]
      isLoading.value = false
    }, 450)
  })

  const handleSendPush = () => {
    if (!newPush.value.title || !newPush.value.message) return

    isSending.value = true
    setTimeout(() => {
      campaigns.value.unshift({
        id: `push-${Date.now()}`,
        title: newPush.value.title,
        message: newPush.value.message,
        targetApp: newPush.value.targetApp,
        targetAudience: newPush.value.targetAudience,
        sentAt: 'Just now',
        sentCount: 12500,
        openRate: '0.0%',
        status: 'Sent'
      })
      isSending.value = false
      newPush.value = {
        title: '',
        message: '',
        targetApp: 'Coffee Pickup',
        targetAudience: 'All Active Users',
        scheduledAt: ''
      }
    }, 800)
  }

  const handleServiceAccountFileSelect = (e: Event) => {
    const target = e.target as HTMLInputElement
    if (target.files && target.files[0]) {
      const file = target.files[0]
      configForm.value.serviceAccountFileName = file.name
      const reader = new FileReader()
      reader.onload = (uploadEvent) => {
        const text = uploadEvent.target?.result as string
        configForm.value.serviceAccountJson = text
        try {
          const parsed = JSON.parse(text)
          if (parsed.project_id) {
            configForm.value.teamIdOrProject = parsed.project_id
          }
          if (parsed.private_key_id) {
            configForm.value.apiKeyOrKeyId = parsed.private_key_id
          }
          if (parsed.client_email) {
            configForm.value.appIdOrBundleId = parsed.client_email
          }
        } catch {
          // not JSON, store as raw string
        }
      }
      reader.readAsText(file)
    }
  }

  const openCreateConfigModal = () => {
    isEditingConfig.value = false
    editingConfigId.value = null
    configForm.value = {
      provider: 'FCM',
      appName: 'All Apps (Global Broadcast)',
      environment: 'Production',
      status: 'active',
      apiKeyOrKeyId: '',
      appIdOrBundleId: '',
      teamIdOrProject: '',
      serviceAccountFileName: '',
      serviceAccountJson: ''
    }
    showConfigModal.value = true
  }

  const openEditConfigModal = (cfg: PushGatewayConfig) => {
    isEditingConfig.value = true
    editingConfigId.value = cfg.id
    configForm.value = {
      provider: cfg.provider,
      appName: cfg.appName,
      environment: cfg.environment,
      status: cfg.status,
      apiKeyOrKeyId: cfg.apiKeyOrKeyId,
      appIdOrBundleId: cfg.appIdOrBundleId,
      teamIdOrProject: cfg.teamIdOrProject,
      serviceAccountFileName: cfg.serviceAccountFileName || '',
      serviceAccountJson: cfg.serviceAccountJson || ''
    }
    showConfigModal.value = true
  }

  const handleSaveConfig = () => {
    if (!configForm.value.apiKeyOrKeyId && !configForm.value.serviceAccountFileName) return

    if (isEditingConfig.value && editingConfigId.value) {
      const idx = pushConfigs.value.findIndex(c => c.id === editingConfigId.value)
      if (idx !== -1) {
        pushConfigs.value[idx] = {
          ...pushConfigs.value[idx],
          ...configForm.value,
          lastTestedAt: 'Just now'
        }
      }
    } else {
      pushConfigs.value.push({
        id: `cfg-${Date.now()}`,
        ...configForm.value,
        lastTestedAt: 'Never'
      })
    }
    showConfigModal.value = false
  }

  const toggleConfigStatus = (cfg: PushGatewayConfig) => {
    cfg.status = cfg.status === 'active' ? 'inactive' : 'active'
  }

  const deleteConfig = (id: string) => {
    pushConfigs.value = pushConfigs.value.filter(c => c.id !== id)
  }

  return {
    isLoading,
    activeTab,
    campaigns,
    pushConfigs,
    showConfigModal,
    isEditingConfig,
    configForm,
    newPush,
    appsList,
    audiences,
    isSending,
    handleSendPush,
    handleServiceAccountFileSelect,
    openCreateConfigModal,
    openEditConfigModal,
    handleSaveConfig,
    toggleConfigStatus,
    deleteConfig
  }
}
