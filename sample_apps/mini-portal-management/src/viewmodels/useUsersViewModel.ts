import { ref, computed, onMounted } from 'vue'
import { mockUsers, type PortalUser } from '../data/mockData'

export function useUsersViewModel() {
  const users = ref<PortalUser[]>([])
  const isLoading = ref(true)
  const searchQuery = ref('')
  const selectedRole = ref('All')

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      users.value = [...mockUsers]
      isLoading.value = false
    }, 450)
  })

  const roles = ['All', 'Super Admin', 'Operator', 'Developer', 'Auditor']

  const filteredUsers = computed(() => {
    return users.value.filter(u => {
      const matchRole = selectedRole.value === 'All' || u.role === selectedRole.value
      const matchSearch = u.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          u.email.toLowerCase().includes(searchQuery.value.toLowerCase())
      return matchRole && matchSearch
    })
  })

  const toggleUserStatus = (user: PortalUser) => {
    user.status = user.status === 'active' ? 'suspended' : 'active'
  }

  return {
    users,
    isLoading,
    searchQuery,
    selectedRole,
    roles,
    filteredUsers,
    toggleUserStatus
  }
}
