import { ref, computed, onMounted } from 'vue'
import { mockMiniApps, type MiniApp, type ApiAuthType, type MiniAppApiEndpoint } from '../data/mockData'

export function useMiniAppsViewModel() {
  const apps = ref<MiniApp[]>([])
  const isLoading = ref(true)
  const selectedCategory = ref('All')
  const searchQuery = ref('')
  const viewMode = ref<'grid' | 'table'>('grid')
  const isReorderMode = ref(false)
  const showCreateModal = ref(false)

  onMounted(() => {
    isLoading.value = true
    setTimeout(() => {
      apps.value = [...mockMiniApps]
      isLoading.value = false
    }, 450)
  })

  const categories = [
    'All',
    'Food & Beverage',
    'Services',
    'Entertainment',
    'Mobility',
    'Lifestyle',
    'Finance'
  ]

  const newApp = ref({
    name: '',
    slug: '',
    category: 'Services',
    description: '',
    version: 'v1.0.0',
    icon: '',
    banner: '',
    tags: [] as string[],
    order: 1,
    packageType: 'zip' as 'zip' | 'web_url' | 'native_aar' | 'api',
    packageUrl: '',
    uploadedFileName: '',
    uploadedFileSize: '',
    androidPackageName: '',
    androidActivityClass: '',
    iosViewControllerClass: '',
    // Multi-API & Advanced Auth Configuration
    apiBaseUrl: 'https://api.partner.com/v1',
    apiTimeoutMs: 5000,
    apiAuth: {
      authType: 'apiKey' as ApiAuthType,
      apiKey: '',
      apiSecret: '',
      headerName: 'X-API-Key',
      bearerToken: '',
      username: '',
      password: '',
      tokenUrl: 'https://auth.partner.com/oauth/token',
      clientId: '',
      clientSecret: '',
      scope: 'read write',
      signatureSecret: '',
      privateKeyPem: ''
    },
    apiEndpoints: [
      {
        id: 'ep-1',
        name: 'Product Catalog API',
        path: '/product',
        httpMethod: 'GET' as const,
        contentType: 'application/json',
        queryParams: 'category=Signature Coffee&limit=10',
        uiTemplate: 'Template 1 (Catalog & Product Cards)',
        targetFormatJson: `[\n  {\n    "id": "cof_01",\n    "name": "Iced Salted Cream Caramel Latte",\n    "description": "Double espresso, organic whole milk, salted vanilla foam & amber caramel drizzle",\n    "price": 3.5,\n    "currency": "USD",\n    "category": "Signature Coffee",\n    "badge": "POPULAR",\n    "imageUrl": "https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500&auto=format&fit=crop&q=80"\n  }\n]`,
        partnerMatchesFormat: false,
        requestHeaders: '{\n  "Accept": "application/json"\n}',
        requestPayloadSchema: '',
        fieldMappings: [
          { targetField: 'id', sourceJsonPath: '$[*].id', defaultValue: '' },
          { targetField: 'name', sourceJsonPath: '$[*].title', defaultValue: '' },
          { targetField: 'description', sourceJsonPath: '$[*].description', defaultValue: '' },
          {
            targetField: 'price',
            sourceJsonPath: '$[*].price',
            defaultValue: '',
            showTransform: true,
            transform: { type: 'addSuffix', param: '$.items[0].currency' }
          },
          { targetField: 'currency', sourceJsonPath: '', defaultValue: 'USD' },
          { targetField: 'category', sourceJsonPath: '$[*].category', defaultValue: '' },
          { targetField: 'badge', sourceJsonPath: '', defaultValue: 'POPULAR' },
          { targetField: 'imageUrl', sourceJsonPath: '$[*].image', defaultValue: '' }
        ]
      }
    ] as MiniAppApiEndpoint[]
  })

  const currentPage = ref(1)
  const pageSize = ref(6)

  const filteredApps = computed(() => {
    return apps.value.filter(app => {
      const matchCat = selectedCategory.value === 'All' || app.category === selectedCategory.value
      const query = searchQuery.value.toLowerCase()
      const matchSearch = app.name.toLowerCase().includes(query) ||
                          app.slug.toLowerCase().includes(query) ||
                          (app.tags && app.tags.some(t => t.toLowerCase().includes(query)))
      return matchCat && matchSearch
    })
  })

  const totalFilteredApps = computed(() => filteredApps.value.length)

  const paginatedApps = computed(() => {
    // In reorder mode, show all filtered apps so they can be arranged freely
    if (isReorderMode.value) {
      return filteredApps.value
    }
    const start = (currentPage.value - 1) * pageSize.value
    return filteredApps.value.slice(start, start + pageSize.value)
  })

  const handleIconSelect = (e: Event) => {
    const target = e.target as HTMLInputElement
    if (target.files && target.files[0]) {
      const file = target.files[0]
      const reader = new FileReader()
      reader.onload = (uploadEvent) => {
        newApp.value.icon = uploadEvent.target?.result as string
      }
      reader.readAsDataURL(file)
    }
  }

  const handleBannerSelect = (e: Event) => {
    const target = e.target as HTMLInputElement
    if (target.files && target.files[0]) {
      const file = target.files[0]
      const reader = new FileReader()
      reader.onload = (uploadEvent) => {
        newApp.value.banner = uploadEvent.target?.result as string
      }
      reader.readAsDataURL(file)
    }
  }

  const handlePackageFileSelect = (e: Event) => {
    const target = e.target as HTMLInputElement
    if (target.files && target.files[0]) {
      const file = target.files[0]
      newApp.value.uploadedFileName = file.name
      newApp.value.uploadedFileSize = (file.size / (1024 * 1024)).toFixed(2) + ' MB'
    }
  }

  const handleCreateApp = () => {
    const appPayload: MiniApp = {
      id: `app-${Date.now()}`,
      name: newApp.value.name,
      slug: newApp.value.slug,
      category: newApp.value.category,
      description: newApp.value.description,
      version: newApp.value.version,
      icon: newApp.value.icon || 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=128&auto=format&fit=crop&q=80',
      banner: newApp.value.banner || 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600&auto=format&fit=crop&q=80',
      tags: [...newApp.value.tags],
      order: newApp.value.order,
      packageType: newApp.value.packageType,
      packageUrl: newApp.value.packageUrl,
      fileName: newApp.value.packageType === 'zip' ? newApp.value.uploadedFileName : undefined,
      fileSize: newApp.value.packageType === 'zip' ? newApp.value.uploadedFileSize : undefined,
      androidPackageName: newApp.value.packageType === 'native_aar' ? newApp.value.androidPackageName : undefined,
      iosViewControllerClass: newApp.value.packageType === 'native_aar' ? newApp.value.iosViewControllerClass : undefined,
      apiConfig: newApp.value.packageType === 'api' ? {
        baseUrl: newApp.value.apiBaseUrl,
        timeoutMs: newApp.value.apiTimeoutMs,
        auth: { ...newApp.value.apiAuth },
        endpoints: JSON.parse(JSON.stringify(newApp.value.apiEndpoints))
      } : undefined,
      status: 'active',
      usersCount: 1,
      viewCount: 1,
      rating: 5.0,
      path: `/#/miniapps/${newApp.value.slug}`,
      updatedAt: 'Just now'
    }

    apps.value.unshift(appPayload)
    showCreateModal.value = false
    resetForm()
  }

  const toggleAppStatus = (app: MiniApp) => {
    app.status = app.status === 'active' ? 'staging' : 'active'
  }

  const moveAppOrder = (index: number, direction: 'up' | 'down') => {
    const currentFiltered = filteredApps.value
    const targetIdx = direction === 'up' ? index - 1 : index + 1
    if (targetIdx < 0 || targetIdx >= currentFiltered.length) return

    const itemA = currentFiltered[index]
    const itemB = currentFiltered[targetIdx]

    const mainIdxA = apps.value.findIndex(a => a.id === itemA.id)
    const mainIdxB = apps.value.findIndex(a => a.id === itemB.id)

    if (mainIdxA !== -1 && mainIdxB !== -1) {
      const tempOrder = apps.value[mainIdxA].order || (mainIdxA + 1)
      apps.value[mainIdxA].order = apps.value[mainIdxB].order || (mainIdxB + 1)
      apps.value[mainIdxB].order = tempOrder

      const temp = apps.value[mainIdxA]
      apps.value[mainIdxA] = apps.value[mainIdxB]
      apps.value[mainIdxB] = temp
    }
  }

  const addApiEndpoint = () => {
    newApp.value.apiEndpoints.push({
      id: `ep-${Date.now()}`,
      name: 'New API Endpoint',
      path: '/api/v1/resource',
      httpMethod: 'GET',
      uiTemplate: 'Template 1 (Catalog & Product Cards)',
      targetFormatJson: `[\n  {\n    "id": "item_01",\n    "name": "Resource Name",\n    "price": 10.0\n  }\n]`,
      partnerMatchesFormat: false,
      requestHeaders: '{\n  "Accept": "application/json"\n}',
      requestPayloadSchema: '',
      fieldMappings: [
        { targetField: 'id', sourceJsonPath: '$[*].id', defaultValue: '' },
        { targetField: 'name', sourceJsonPath: '$[*].name', defaultValue: '' },
        { targetField: 'price', sourceJsonPath: '$[*].price', defaultValue: '' }
      ]
    })
  }

  const removeApiEndpoint = (index: number) => {
    if (newApp.value.apiEndpoints.length > 1) {
      newApp.value.apiEndpoints.splice(index, 1)
    }
  }

  const addFieldMapping = (endpointIndex: number) => {
    newApp.value.apiEndpoints[endpointIndex].fieldMappings.push({
      targetField: '',
      sourceJsonPath: '',
      defaultValue: '',
      showTransform: false
    })
  }

  const removeFieldMapping = (endpointIndex: number, mappingIndex: number) => {
    newApp.value.apiEndpoints[endpointIndex].fieldMappings.splice(mappingIndex, 1)
  }

  const toggleTransform = (endpointIndex: number, mappingIndex: number) => {
    const item = newApp.value.apiEndpoints[endpointIndex].fieldMappings[mappingIndex]
    item.showTransform = !item.showTransform
    if (item.showTransform && !item.transform) {
      item.transform = { type: 'addSuffix', param: '' }
    }
  }

  const resetForm = () => {
    newApp.value = {
      name: '',
      slug: '',
      category: 'Services',
      description: '',
      version: 'v1.0.0',
      icon: '',
      banner: '',
      tags: [] as string[],
      order: 1,
      packageType: 'zip',
      packageUrl: '',
      uploadedFileName: '',
      uploadedFileSize: '',
      androidPackageName: '',
      androidActivityClass: '',
      iosViewControllerClass: '',
      apiBaseUrl: 'https://api.partner.com/v1',
      apiTimeoutMs: 5000,
      apiAuth: {
        authType: 'apiKey',
        apiKey: '',
        apiSecret: '',
        headerName: 'X-API-Key',
        bearerToken: '',
        username: '',
        password: '',
        tokenUrl: 'https://auth.partner.com/oauth/token',
        clientId: '',
        clientSecret: '',
        scope: 'read write',
        signatureSecret: '',
        privateKeyPem: ''
      },
      apiEndpoints: [
        {
          id: 'ep-1',
          name: 'Product Catalog API',
          path: '/product',
          httpMethod: 'GET',
          uiTemplate: 'Template 1 (Catalog & Product Cards)',
          targetFormatJson: `[\n  {\n    "id": "cof_01",\n    "name": "Iced Salted Cream Caramel Latte",\n    "description": "Double espresso, organic whole milk, salted vanilla foam & amber caramel drizzle",\n    "price": 3.5,\n    "currency": "USD",\n    "category": "Signature Coffee",\n    "badge": "POPULAR",\n    "imageUrl": "https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500&auto=format&fit=crop&q=80"\n  }\n]`,
          partnerMatchesFormat: false,
          requestHeaders: '{\n  "Accept": "application/json"\n}',
          requestPayloadSchema: '',
          fieldMappings: [
            { targetField: 'id', sourceJsonPath: '$[*].id', defaultValue: '' },
            { targetField: 'name', sourceJsonPath: '$[*].title', defaultValue: '' },
            { targetField: 'description', sourceJsonPath: '$[*].description', defaultValue: '' },
            {
              targetField: 'price',
              sourceJsonPath: '$[*].price',
              defaultValue: '',
              showTransform: true,
              transform: { type: 'addSuffix', param: '$.items[0].currency' }
            },
            { targetField: 'currency', sourceJsonPath: '', defaultValue: 'USD' },
            { targetField: 'category', sourceJsonPath: '$[*].category', defaultValue: '' },
            { targetField: 'badge', sourceJsonPath: '', defaultValue: 'POPULAR' },
            { targetField: 'imageUrl', sourceJsonPath: '$[*].image', defaultValue: '' }
          ]
        }
      ]
    }
  }

  return {
    apps,
    isLoading,
    categories,
    selectedCategory,
    searchQuery,
    viewMode,
    isReorderMode,
    showCreateModal,
    newApp,
    currentPage,
    pageSize,
    totalFilteredApps,
    filteredApps,
    paginatedApps,
    handleIconSelect,
    handleBannerSelect,
    handlePackageFileSelect,
    handleCreateApp,
    toggleAppStatus,
    moveAppOrder,
    addApiEndpoint,
    removeApiEndpoint,
    addFieldMapping,
    removeFieldMapping,
    toggleTransform,
    resetForm
  }
}
