import { ref, computed, onMounted } from 'vue'
import { mockTags, type MiniAppTag } from '../data/mockData'

export function useTagsViewModel() {
  const tags = ref<MiniAppTag[]>([])
  const isLoading = ref(true)
  const searchQuery = ref('')
  const selectedFilter = ref<'All' | 'Featured' | 'Standard'>('All')
  const showModal = ref(false)
  const isEditing = ref(false)
  const editingId = ref<string | null>(null)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      tags.value = [...mockTags]
      isLoading.value = false
    }, 450)
  })

  const tagForm = ref({
    name: '',
    slug: '',
    color: '#3b82f6',
    icon: 'pricetag',
    description: '',
    isFeatured: false
  })

  const colorPalette = [
    '#3b82f6', '#10b981', '#f59e0b', '#ef4444',
    '#8b5cf6', '#ec4899', '#06b6d4', '#14b8a6',
    '#6366f1', '#64748b'
  ]

  const availableIcons = [
    { name: 'pricetag', label: 'Tag' },
    { name: 'flash', label: 'Express' },
    { name: 'coffee', label: 'Coffee' },
    { name: 'film', label: 'Cinema' },
    { name: 'battery-charging', label: 'EV/Energy' },
    { name: 'card', label: 'Payment' },
    { name: 'qr-code', label: 'QR Code' },
    { name: 'sparkles', label: 'Wellness' },
    { name: 'cube', label: 'Hub' },
    { name: 'star', label: 'Popular' },
    { name: 'gift', label: 'Offer' },
    { name: 'shield-checkmark', label: 'Verified' }
  ]

  const filteredTags = computed(() => {
    return tags.value.filter(t => {
      const matchFilter = selectedFilter.value === 'All' ||
        (selectedFilter.value === 'Featured' && t.isFeatured) ||
        (selectedFilter.value === 'Standard' && !t.isFeatured)
      const matchSearch = t.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        t.slug.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        (t.description && t.description.toLowerCase().includes(searchQuery.value.toLowerCase()))
      return matchFilter && matchSearch
    })
  })

  const totalTagsCount = computed(() => tags.value.length)
  const featuredTagsCount = computed(() => tags.value.filter(t => t.isFeatured).length)

  const openCreateModal = () => {
    isEditing.value = false
    editingId.value = null
    tagForm.value = {
      name: '',
      slug: '',
      color: '#3b82f6',
      icon: 'pricetag',
      description: '',
      isFeatured: false
    }
    showModal.value = true
  }

  const openEditModal = (t: MiniAppTag) => {
    isEditing.value = true
    editingId.value = t.id
    tagForm.value = {
      name: t.name,
      slug: t.slug,
      color: t.color,
      icon: t.icon || 'pricetag',
      description: t.description || '',
      isFeatured: t.isFeatured
    }
    showModal.value = true
  }

  const handleSaveTag = () => {
    if (!tagForm.value.name) return

    if (isEditing.value && editingId.value) {
      const idx = tags.value.findIndex(t => t.id === editingId.value)
      if (idx !== -1) {
        tags.value[idx] = {
          ...tags.value[idx],
          name: tagForm.value.name,
          slug: tagForm.value.slug || tagForm.value.name.toLowerCase().replace(/\s+/g, '-'),
          color: tagForm.value.color,
          icon: tagForm.value.icon,
          description: tagForm.value.description,
          isFeatured: tagForm.value.isFeatured
        }
      }
    } else {
      const newTagItem: MiniAppTag = {
        id: `tag-${Date.now()}`,
        name: tagForm.value.name,
        slug: tagForm.value.slug || tagForm.value.name.toLowerCase().replace(/\s+/g, '-'),
        color: tagForm.value.color,
        icon: tagForm.value.icon,
        description: tagForm.value.description,
        appCount: 0,
        isFeatured: tagForm.value.isFeatured,
        createdAt: new Date().toISOString().split('T')[0]
      }
      tags.value.unshift(newTagItem)
    }

    showModal.value = false
  }

  const showDeleteConfirm = ref(false)
  const tagToDelete = ref<string | null>(null)

  const requestDeleteTag = (id: string) => {
    tagToDelete.value = id
    showDeleteConfirm.value = true
  }

  const confirmDeleteTag = () => {
    if (tagToDelete.value) {
      tags.value = tags.value.filter(t => t.id !== tagToDelete.value)
      tagToDelete.value = null
    }
    showDeleteConfirm.value = false
  }

  const cancelDeleteTag = () => {
    tagToDelete.value = null
    showDeleteConfirm.value = false
  }

  const toggleFeatured = (t: MiniAppTag) => {
    t.isFeatured = !t.isFeatured
  }

  return {
    tags,
    isLoading,
    searchQuery,
    selectedFilter,
    showModal,
    isEditing,
    tagForm,
    colorPalette,
    availableIcons,
    filteredTags,
    totalTagsCount,
    featuredTagsCount,
    showDeleteConfirm,
    openCreateModal,
    openEditModal,
    handleSaveTag,
    requestDeleteTag,
    confirmDeleteTag,
    cancelDeleteTag,
    toggleFeatured
  }
}
