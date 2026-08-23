import { ref, computed, onMounted } from 'vue'
import { mockCustomers, type Customer } from '../data/mockData'

export function useCustomersViewModel() {
  const customers = ref<Customer[]>([])
  const isLoading = ref(true)
  const searchQuery = ref('')
  const selectedTier = ref('All')

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      customers.value = [...mockCustomers]
      isLoading.value = false
    }, 450)
  })

  const tiers = ['All', 'Platinum', 'Gold', 'Silver', 'Standard']

  const filteredCustomers = computed(() => {
    return customers.value.filter(c => {
      const matchTier = selectedTier.value === 'All' || c.tier === selectedTier.value
      const matchSearch = c.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          c.phone.includes(searchQuery.value) ||
                          c.email.toLowerCase().includes(searchQuery.value.toLowerCase())
      return matchTier && matchSearch
    })
  })

  return {
    customers,
    isLoading,
    searchQuery,
    selectedTier,
    tiers,
    filteredCustomers
  }
}
