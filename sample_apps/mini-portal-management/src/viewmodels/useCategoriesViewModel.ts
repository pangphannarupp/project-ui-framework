import { ref, computed, onMounted } from 'vue'
import { mockCategories, type MiniAppCategory } from '../data/mockData'

export function useCategoriesViewModel() {
  const categories = ref<MiniAppCategory[]>([])
  const isLoading = ref(true)
  const searchQuery = ref('')
  const selectedStatus = ref<'All' | 'active' | 'inactive'>('All')
  const showCreateModal = ref(false)
  const editingCategory = ref<MiniAppCategory | null>(null)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      categories.value = [...mockCategories]
      isLoading.value = false
    }, 450)
  })

  const availableColors = [
    '#3b82f6', '#10b981', '#f59e0b', '#ef4444',
    '#8b5cf6', '#ec4899', '#06b6d4', '#14b8a6',
    '#6366f1', '#64748b'
  ]

  const categoryForm = ref({
    name: '',
    slug: '',
    color: '#3b82f6',
    order: 1,
    description: '',
    status: 'active' as 'active' | 'inactive'
  })

  const filteredCategories = computed(() => {
    return categories.value.filter(cat => {
      const matchStatus = selectedStatus.value === 'All' || cat.status === selectedStatus.value
      const matchSearch = cat.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          cat.slug.toLowerCase().includes(searchQuery.value.toLowerCase())
      return matchStatus && matchSearch
    })
  })

  const activeCategoriesCount = computed(() => categories.value.filter(c => c.status === 'active').length)
  const totalApps = computed(() => categories.value.reduce((acc, c) => acc + c.appCount, 0))

  const openCreateModal = () => {
    editingCategory.value = null
    categoryForm.value = {
      name: '',
      slug: '',
      color: '#3b82f6',
      order: categories.value.length + 1,
      description: '',
      status: 'active'
    }
    showCreateModal.value = true
  }

  const openEditModal = (cat: MiniAppCategory) => {
    editingCategory.value = cat
    categoryForm.value = {
      name: cat.name,
      slug: cat.slug,
      color: cat.color,
      order: cat.order,
      description: cat.description,
      status: cat.status
    }
    showCreateModal.value = true
  }

  const handleSaveCategory = () => {
    if (!categoryForm.value.name) return

    if (editingCategory.value) {
      const idx = categories.value.findIndex(c => c.id === editingCategory.value?.id)
      if (idx !== -1) {
        categories.value[idx] = {
          ...categories.value[idx],
          name: categoryForm.value.name,
          slug: categoryForm.value.slug || categoryForm.value.name.toLowerCase().replace(/\s+/g, '-'),
          color: categoryForm.value.color,
          order: Number(categoryForm.value.order),
          description: categoryForm.value.description,
          status: categoryForm.value.status
        }
      }
    } else {
      const newCat: MiniAppCategory = {
        id: `cat-${Date.now()}`,
        name: categoryForm.value.name,
        slug: categoryForm.value.slug || categoryForm.value.name.toLowerCase().replace(/\s+/g, '-'),
        icon: 'folder',
        color: categoryForm.value.color,
        appCount: 0,
        order: Number(categoryForm.value.order),
        description: categoryForm.value.description || 'Custom classification grouping for mini applications.',
        status: categoryForm.value.status,
        createdAt: new Date().toISOString().split('T')[0]
      }
      categories.value.push(newCat)
    }

    showCreateModal.value = false
  }

  const toggleCategoryStatus = (cat: MiniAppCategory) => {
    cat.status = cat.status === 'active' ? 'inactive' : 'active'
  }

  const showDeleteConfirm = ref(false)
  const categoryToDelete = ref<string | null>(null)

  const requestDeleteCategory = (id: string) => {
    categoryToDelete.value = id
    showDeleteConfirm.value = true
  }

  const confirmDeleteCategory = () => {
    if (categoryToDelete.value) {
      categories.value = categories.value.filter(c => c.id !== categoryToDelete.value)
      categoryToDelete.value = null
    }
    showDeleteConfirm.value = false
  }

  const cancelDeleteCategory = () => {
    categoryToDelete.value = null
    showDeleteConfirm.value = false
  }

  return {
    categories,
    isLoading,
    searchQuery,
    selectedStatus,
    showCreateModal,
    editingCategory,
    categoryForm,
    availableColors,
    filteredCategories,
    activeCategoriesCount,
    totalApps,
    showDeleteConfirm,
    openCreateModal,
    openEditModal,
    handleSaveCategory,
    toggleCategoryStatus,
    requestDeleteCategory,
    confirmDeleteCategory,
    cancelDeleteCategory
  }
}
