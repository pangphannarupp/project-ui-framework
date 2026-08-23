import { ref, computed } from 'vue'
import {
  mockConsentPolicies,
  mockUserConsentRecords,
  mockMiniApps,
  type ConsentPolicy,
  type UserConsentRecord
} from '../data/mockData'

export function useConsentManagementViewModel() {
  const isLoading = ref(true)
  const activeTab = ref<'policies' | 'records' | 'analytics'>('policies')
  const searchQuery = ref('')
  const selectedCategory = ref('All')
  const selectedStatus = ref('All')

  // Policies Data
  const policies = ref<ConsentPolicy[]>([...mockConsentPolicies])
  const records = ref<UserConsentRecord[]>([...mockUserConsentRecords])
  const availableApps = computed(() => ['Global (All Mini Apps)', ...mockMiniApps.map(a => a.name)])

  // Modal State for Policy Edit / Create
  const showPolicyModal = ref(false)
  const isEditing = ref(false)
  const editingPolicy = ref<ConsentPolicy>({
    id: '',
    title: '',
    category: 'Terms of Service',
    scopeApp: 'Global (All Mini Apps)',
    version: 'v1.0.0',
    content: '',
    status: 'Active',
    isRequired: true,
    requireReconsentOnUpdate: false,
    consentedUsersCount: 0,
    lastUpdated: new Date().toISOString().split('T')[0]
  })

  // Detail View for Consent Record
  const showRecordDetailModal = ref(false)
  const selectedRecord = ref<UserConsentRecord | null>(null)

  // Feedback notifications
  const toastMessage = ref('')
  const showToast = ref(false)

  const triggerToast = (msg: string) => {
    toastMessage.value = msg
    showToast.value = true
    setTimeout(() => {
      showToast.value = false
    }, 3000)
  }

  // Filtered Policies
  const filteredPolicies = computed(() => {
    return policies.value.filter(p => {
      const matchSearch = p.title.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          p.scopeApp.toLowerCase().includes(searchQuery.value.toLowerCase())
      const matchCat = selectedCategory.value === 'All' || p.category === selectedCategory.value
      const matchStatus = selectedStatus.value === 'All' || p.status === selectedStatus.value
      return matchSearch && matchCat && matchStatus
    })
  })

  // Filtered User Consent Records
  const filteredRecords = computed(() => {
    return records.value.filter(r => {
      const q = searchQuery.value.toLowerCase()
      const matchSearch = r.customerName.toLowerCase().includes(q) ||
                          r.customerPhone.toLowerCase().includes(q) ||
                          r.policyTitle.toLowerCase().includes(q) ||
                          r.customerId.toLowerCase().includes(q)
      const matchStatus = selectedStatus.value === 'All' || r.consentStatus === selectedStatus.value
      return matchSearch && matchStatus
    })
  })

  // Aggregated Analytics
  const stats = computed(() => {
    const totalGranted = records.value.filter(r => r.consentStatus === 'Granted').length
    const totalRevoked = records.value.filter(r => r.consentStatus === 'Revoked').length
    const activePolicies = policies.value.filter(p => p.status === 'Active').length
    const totalUsersConsented = policies.value.reduce((acc, p) => acc + p.consentedUsersCount, 0)
    return {
      activePolicies,
      totalGranted,
      totalRevoked,
      totalUsersConsented,
      complianceRate: '98.4%'
    }
  })

  const openCreateModal = () => {
    isEditing.value = false
    editingPolicy.value = {
      id: `pol-${Date.now()}`,
      title: '',
      category: 'Terms of Service',
      scopeApp: 'Global (All Mini Apps)',
      version: 'v1.0.0',
      content: '',
      status: 'Active',
      isRequired: true,
      requireReconsentOnUpdate: false,
      consentedUsersCount: 0,
      lastUpdated: new Date().toISOString().split('T')[0]
    }
    showPolicyModal.value = true
  }

  const openEditModal = (policy: ConsentPolicy) => {
    isEditing.value = true
    editingPolicy.value = JSON.parse(JSON.stringify(policy))
    showPolicyModal.value = true
  }

  const savePolicy = () => {
    if (!editingPolicy.value.title.trim()) return
    editingPolicy.value.lastUpdated = new Date().toISOString().split('T')[0]
    
    if (isEditing.value) {
      const idx = policies.value.findIndex(p => p.id === editingPolicy.value.id)
      if (idx !== -1) {
        policies.value[idx] = { ...editingPolicy.value }
        triggerToast(`Updated policy "${editingPolicy.value.title}" (Version ${editingPolicy.value.version})`)
      }
    } else {
      policies.value.unshift({ ...editingPolicy.value })
      triggerToast(`Created new consent policy "${editingPolicy.value.title}"`)
    }
    showPolicyModal.value = false
  }

  const togglePolicyStatus = (policy: ConsentPolicy) => {
    policy.status = policy.status === 'Active' ? 'Draft' : 'Active'
    triggerToast(`Status changed to ${policy.status} for "${policy.title}"`)
  }

  const deletePolicy = (id: string) => {
    const idx = policies.value.findIndex(p => p.id === id)
    if (idx !== -1) {
      const deleted = policies.value.splice(idx, 1)[0]
      triggerToast(`Deleted policy "${deleted.title}"`)
    }
  }

  const inspectRecord = (record: UserConsentRecord) => {
    selectedRecord.value = record
    showRecordDetailModal.value = true
  }

  const revokeUserConsent = (record: UserConsentRecord) => {
    record.consentStatus = record.consentStatus === 'Granted' ? 'Revoked' : 'Granted'
    triggerToast(`Consent status changed to ${record.consentStatus} for customer ${record.customerName}`)
  }

  // Simulate loading delay for skeleton check
  setTimeout(() => {
    isLoading.value = false
  }, 400)

  return {
    isLoading,
    activeTab,
    searchQuery,
    selectedCategory,
    selectedStatus,
    policies,
    records,
    availableApps,
    filteredPolicies,
    filteredRecords,
    stats,
    showPolicyModal,
    isEditing,
    editingPolicy,
    showRecordDetailModal,
    selectedRecord,
    showToast,
    toastMessage,
    openCreateModal,
    openEditModal,
    savePolicy,
    togglePolicyStatus,
    deletePolicy,
    inspectRecord,
    revokeUserConsent
  }
}
