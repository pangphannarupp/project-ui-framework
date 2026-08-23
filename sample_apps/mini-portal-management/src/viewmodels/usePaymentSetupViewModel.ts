import { ref, onMounted } from 'vue'

export function usePaymentSetupViewModel() {
  const isLoading = ref(true)
  const gateways = ref<any[]>([])

  const defaultGateways = [
    {
      id: 'bakong',
      name: 'Bakong KHQR Universal',
      status: true,
      currency: 'KHR & USD',
      merchantId: 'MCNC_KHQR_99014',
      fee: '0.00% (National QR)',
      webhookUrl: 'https://api.miniportal.io/v1/webhooks/bakong-settlement',
      icon: 'qr-code',
      color: '#ef4444'
    },
    {
      id: 'payway',
      name: 'ABA PayWay Gateway',
      status: true,
      currency: 'USD & KHR',
      merchantId: 'ec44102919_abaprod',
      fee: '1.20% + $0.10 / txn',
      webhookUrl: 'https://api.miniportal.io/v1/webhooks/aba-payway',
      icon: 'card',
      color: '#06b6d4'
    },
    {
      id: 'wing',
      name: 'Wing Bank Commerce',
      status: false,
      currency: 'USD',
      merchantId: 'WING_BIZ_88301',
      fee: '0.80%',
      webhookUrl: 'https://api.miniportal.io/v1/webhooks/wing-notify',
      icon: 'shield',
      color: '#84cc16'
    }
  ]

  const saveSuccess = ref(false)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      gateways.value = [...defaultGateways]
      isLoading.value = false
    }, 450)
  })

  const handleSaveSettings = () => {
    saveSuccess.value = true
    setTimeout(() => {
      saveSuccess.value = false
    }, 3000)
  }

  return {
    isLoading,
    gateways,
    saveSuccess,
    handleSaveSettings
  }
}
