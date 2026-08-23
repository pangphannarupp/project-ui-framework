export interface MiniAppCategory {
  id: string
  name: string
  slug: string
  icon: string
  description: string
  color: string
  appCount: number
  status: 'active' | 'inactive'
  order: number
  createdAt: string
}

export type ApiAuthType = 
  | 'none' 
  | 'bearer' 
  | 'apiKey' 
  | 'basic' 
  | 'oauth2_client_credentials' 
  | 'oauth2_auth_code' 
  | 'hmac_sha256' 
  | 'mtls' 
  | 'aws_sigv4' 
  | 'jwt_signed'

export interface ApiAuthConfiguration {
  authType: ApiAuthType
  apiKey?: string
  apiSecret?: string
  headerName?: string // e.g. "X-API-Key" or "Authorization"
  bearerToken?: string
  username?: string
  password?: string
  tokenUrl?: string
  clientId?: string
  clientSecret?: string
  scope?: string
  signatureSecret?: string // for HMAC-SHA256
  privateKeyPem?: string // for JWT signed or mTLS client cert
}

export type TransformFunctionType =
  | 'addSuffix'
  | 'addPrefix'
  | 'replace'
  | 'trim'
  | 'toUpperCase'
  | 'toLowerCase'
  | 'capitalize'
  | 'currencyFormat'
  | 'numberFormat'
  | 'round'
  | 'mathMultiply'
  | 'mathDivide'
  | 'dateFormat'
  | 'timestampToDate'
  | 'relativeTime'
  | 'toBoolean'
  | 'booleanInvert'
  | 'coalesce'
  | 'split'
  | 'join'
  | 'arrayMap'
  | 'arrayFilter'
  | 'arraySlice'
  | 'arraySum'
  | 'arrayCount'
  | 'valueLookup'
  | 'maskSensitive'
  | 'template'
  | 'customScript'

export interface FieldTransformConfig {
  type: TransformFunctionType
  param?: string // e.g. "$.items[0].currency", " USD", "YYYY-MM-DD", "0.01", "active:Active, inactive:Inactive", etc.
}

export interface FieldMappingItem {
  targetField: string // e.g. "id", "name", "description", "price", "currency", "category", "badge", "imageUrl"
  sourceJsonPath: string // e.g. "$[*].id" or "$[*].title" or "$.data.items[*].price"
  defaultValue?: string // e.g. "USD" or "N/A"
  transform?: FieldTransformConfig
  showTransform?: boolean
}

export type ApiContentType =
  | 'application/json'
  | 'application/x-www-form-urlencoded'
  | 'multipart/form-data'
  | 'text/plain'
  | 'application/xml'

export interface MiniAppApiEndpoint {
  id: string
  name: string // e.g. "Product Catalog", "Order Checkout"
  path: string // Source URL e.g. "/product"
  httpMethod: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH'
  contentType?: ApiContentType
  queryParams?: string // e.g. "page=1&limit=20&category=coffee"
  requestHeaders?: string
  requestPayloadSchema?: string // Request body content
  uiTemplate?: string // e.g. "Template 1 (Product List & Card)", "Template 2 (Order Detail)"
  targetFormatJson: string // JSON representation of target format schema
  partnerMatchesFormat?: boolean // Toggle "Partner response already matches this format"
  fieldMappings: FieldMappingItem[]
}

export interface MiniAppApiConfig {
  baseUrl: string
  auth: ApiAuthConfiguration
  endpoints: MiniAppApiEndpoint[]
  timeoutMs: number
}

export interface MiniApp {
  id: string
  name: string
  slug: string
  category: string
  icon: string // URL or base64 data url for app icon
  banner?: string // URL or base64 data url for app banner
  version: string
  packageType: 'zip' | 'web_url' | 'native_aar' | 'api'
  packageUrl?: string
  fileName?: string
  fileSize?: string
  androidPackageName?: string
  androidActivityClass?: string
  iosViewControllerClass?: string
  apiConfig?: MiniAppApiConfig
  status: 'active' | 'staging' | 'maintenance' | 'deprecated'
  usersCount: number
  viewCount: number // Total impressions / views count
  tags?: string[] // Discoverability tags e.g. ["Coffee", "Popular", "Fast Delivery"]
  order?: number // Display ranking order
  rating: number
  path: string
  updatedAt: string
  description: string
}

export interface PortalUser {
  id: string
  name: string
  email: string
  role: 'Super Admin' | 'Operator' | 'Developer' | 'Auditor'
  status: 'active' | 'suspended' | 'invited'
  avatar: string
  lastLogin: string
  assignedApps: number
}

export interface Customer {
  id: string
  name: string
  phone: string
  email: string
  kycStatus: 'Verified' | 'Pending' | 'Rejected'
  tier: 'Gold' | 'Platinum' | 'Silver' | 'Standard'
  joinedDate: string
  totalSpent: string
  usedAppsCount: number
}

export interface AuditLog {
  id: string
  timestamp: string
  action: string
  actor: string
  target: string
  level: 'info' | 'warn' | 'error' | 'success'
  details: string
  ip: string
}

export interface PushCampaign {
  id: string
  title: string
  message: string
  targetAudience: string
  targetApp: string
  sentAt: string
  sentCount: number
  openRate: string
  status: 'Sent' | 'Scheduled' | 'Draft'
}

export interface MiniAppTag {
  id: string
  name: string
  slug: string
  color: string
  icon?: string
  description?: string
  appCount: number
  isFeatured: boolean
  createdAt: string
}

export const mockTags: MiniAppTag[] = [
  { id: 'tag-1', name: 'Bakong KHQR', slug: 'bakong-khqr', color: '#ef4444', icon: 'qr-code', description: 'National standardized QR payment supported apps', appCount: 4, isFeatured: true, createdAt: '2025-01-05' },
  { id: 'tag-2', name: 'Barista', slug: 'barista', color: '#f59e0b', icon: 'coffee', description: 'Handcrafted drinks and gourmet espresso ordering', appCount: 3, isFeatured: true, createdAt: '2025-01-10' },
  { id: 'tag-3', name: 'Express Pickup', slug: 'express-pickup', color: '#10b981', icon: 'flash', description: 'Zero-wait in-store counter pickup orders', appCount: 5, isFeatured: true, createdAt: '2025-01-12' },
  { id: 'tag-4', name: 'Smart Hub', slug: 'smart-hub', color: '#3b82f6', icon: 'cube', description: 'Central gateway services and utility bills', appCount: 6, isFeatured: true, createdAt: '2025-01-15' },
  { id: 'tag-5', name: '3D Cinema', slug: '3d-cinema', color: '#8b5cf6', icon: 'film', description: 'Movie booking, IMAX seats & trailer streaming', appCount: 2, isFeatured: false, createdAt: '2025-02-01' },
  { id: 'tag-6', name: 'EV Charger', slug: 'ev-charger', color: '#06b6d4', icon: 'battery-charging', description: 'Electric vehicle charging pole IoT reservations', appCount: 2, isFeatured: true, createdAt: '2025-02-10' },
  { id: 'tag-7', name: 'Massage', slug: 'massage', color: '#ec4899', icon: 'sparkles', description: 'Spa relaxation, aromatherapy and wellness treatments', appCount: 3, isFeatured: false, createdAt: '2025-02-15' },
  { id: 'tag-8', name: 'POS Terminal', slug: 'pos-terminal', color: '#14b8a6', icon: 'card', description: 'Merchant point-of-sale and terminal checkout', appCount: 4, isFeatured: true, createdAt: '2025-02-20' }
]

export const mockCategories: MiniAppCategory[] = [
  {
    id: 'cat-1',
    name: 'Food & Beverage',
    slug: 'food-beverage',
    icon: '🍔',
    description: 'Restaurants, coffee shops, food delivery & table reservations',
    color: '#f59e0b',
    appCount: 8,
    status: 'active',
    order: 1,
    createdAt: '2025-01-10'
  },
  {
    id: 'cat-2',
    name: 'Entertainment',
    slug: 'entertainment',
    icon: '🎬',
    description: 'Cinema tickets, gaming events, streaming media & concert passes',
    color: '#8b5cf6',
    appCount: 6,
    status: 'active',
    order: 2,
    createdAt: '2025-01-15'
  },
  {
    id: 'cat-3',
    name: 'Services',
    slug: 'services',
    icon: '🛠️',
    description: 'Beauty & spa, home cleaning, professional services & utility bill hubs',
    color: '#3b82f6',
    appCount: 7,
    status: 'active',
    order: 3,
    createdAt: '2025-02-01'
  },
  {
    id: 'cat-4',
    name: 'Mobility',
    slug: 'mobility',
    icon: '🚗',
    description: 'EV charging stations, ride hailing, parking & smart transit',
    color: '#10b981',
    appCount: 4,
    status: 'active',
    order: 4,
    createdAt: '2025-02-18'
  },
  {
    id: 'cat-5',
    name: 'Finance',
    slug: 'finance',
    icon: '💳',
    description: 'KHQR payments, micro-loans, insurance, POS terminals & wallets',
    color: '#ec4899',
    appCount: 5,
    status: 'active',
    order: 5,
    createdAt: '2025-03-01'
  },
  {
    id: 'cat-6',
    name: 'Healthcare',
    slug: 'healthcare',
    icon: '🏥',
    description: 'Doctor appointments, tele-health consultations & pharmacy deliveries',
    color: '#06b6d4',
    appCount: 2,
    status: 'active',
    order: 6,
    createdAt: '2025-05-12'
  }
]

export const mockMiniApps: MiniApp[] = [
  {
    id: 'app-1',
    name: 'Coffee Pickup',
    slug: 'mini-coffee-pickup',
    category: 'Food & Beverage',
    icon: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=160&h=160&fit=crop&crop=faces',
    banner: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&h=300&fit=crop',
    version: 'v2.4.1',
    packageType: 'zip',
    fileName: 'coffee-pickup-v2.4.1.zip',
    fileSize: '4.8 MB',
    status: 'active',
    usersCount: 24500,
    viewCount: 142800,
    tags: ['Barista', 'Beverages', 'Express Pickup', 'Bakong KHQR'],
    order: 1,
    rating: 4.9,
    path: '/sample-apps/mini-coffee-pickup/',
    updatedAt: '2026-08-20',
    description: 'Instant espresso ordering & barista pickup tracking mini app.'
  },
  {
    id: 'app-2',
    name: 'Smart Mini App Hub',
    slug: 'smart-mini-app',
    category: 'Services',
    icon: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=160&h=160&fit=crop',
    banner: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&h=300&fit=crop',
    version: 'v3.0.0',
    packageType: 'web_url',
    packageUrl: 'https://cdn.miniportal.io/apps/smart-hub/index.html',
    status: 'active',
    usersCount: 88400,
    viewCount: 495000,
    tags: ['Lifestyle', 'Utilities', 'Digital ID', 'Smart Hub'],
    order: 2,
    rating: 4.8,
    path: '/sample-apps/smart-mini-app/',
    updatedAt: '2026-08-22',
    description: 'All-in-one smart lifestyle portal for utility bills and digital cards.'
  },
  {
    id: 'app-3',
    name: 'Cinema Ticket Booking',
    slug: 'mini-cinema',
    category: 'Entertainment',
    icon: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=160&h=160&fit=crop',
    banner: 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=800&h=300&fit=crop',
    version: 'v1.8.2',
    packageType: 'zip',
    fileName: 'cinema-booking-prod.zip',
    fileSize: '6.2 MB',
    status: 'active',
    usersCount: 15300,
    viewCount: 98600,
    tags: ['Movies', 'Tickets', '3D Cinema', 'Popcorn Combo'],
    order: 3,
    rating: 4.7,
    path: '/sample-apps/mini-cinema/',
    updatedAt: '2026-08-19',
    description: 'Seat selection, 3D trailers, and popcorn combo pre-orders.'
  },
  {
    id: 'app-4',
    name: 'EV Charge Station',
    slug: 'mini-ev-charge',
    category: 'Mobility',
    icon: 'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=160&h=160&fit=crop',
    banner: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=800&h=300&fit=crop',
    version: 'v2.1.0',
    packageType: 'native_aar',
    fileName: 'ev-charge-sdk-release.aar',
    fileSize: '12.4 MB',
    status: 'active',
    usersCount: 9200,
    viewCount: 61400,
    tags: ['EV Charger', 'Green Energy', 'Fast Charging', 'IoT Pole'],
    order: 4,
    rating: 4.9,
    path: '/sample-apps/mini-ev-charge/',
    updatedAt: '2026-08-21',
    description: 'Real-time charging pole reservations and battery stats.'
  },
  {
    id: 'app-5',
    name: 'Spa & Wellness',
    slug: 'spa_app',
    category: 'Services',
    icon: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=160&h=160&fit=crop',
    banner: 'https://images.unsplash.com/photo-1600334089648-b0d9d3028eb2?w=800&h=300&fit=crop',
    version: 'v1.5.0',
    packageType: 'zip',
    fileName: 'spa-wellness-bundle.zip',
    fileSize: '3.9 MB',
    status: 'staging',
    usersCount: 4200,
    viewCount: 22800,
    tags: ['Massage', 'Aromatherapy', 'Beauty', 'VIP Room'],
    order: 5,
    rating: 4.6,
    path: '/sample-apps/spa_app/',
    updatedAt: '2026-08-18',
    description: 'Therapist booking, aroma packages, and VIP room check-ins.'
  },
  {
    id: 'app-6',
    name: 'Mini POS Merchant',
    slug: 'mini-pos',
    category: 'Finance',
    icon: 'https://images.unsplash.com/photo-1556742049-0a67e55722c0?w=160&h=160&fit=crop',
    banner: 'https://images.unsplash.com/photo-1556742044-3c52d6e88c62?w=800&h=300&fit=crop',
    version: 'v2.0.4',
    packageType: 'native_aar',
    fileName: 'mini-pos-engine-v2.0.4.aar',
    fileSize: '8.7 MB',
    status: 'active',
    usersCount: 31000,
    viewCount: 215000,
    tags: ['Merchant', 'KHQR Scan', 'POS Terminal', 'Audio Chime'],
    order: 6,
    rating: 4.95,
    path: '/sample-apps/mini-pos/',
    updatedAt: '2026-08-22',
    description: 'Instant KHQR terminal generation with audio payment chime.'
  }
]

export const mockUsers: PortalUser[] = [
  {
    id: 'usr-1',
    name: 'Phanna Pang',
    email: 'pangphanna@example.com',
    role: 'Super Admin',
    status: 'active',
    avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=faces',
    lastLogin: 'Just now',
    assignedApps: 30
  },
  {
    id: 'usr-2',
    name: 'Dara Sovan',
    email: 'dara.sovan@example.com',
    role: 'Operator',
    status: 'active',
    avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=faces',
    lastLogin: '25 mins ago',
    assignedApps: 12
  },
  {
    id: 'usr-3',
    name: 'Sokha Chan',
    email: 'sokha.chan@example.com',
    role: 'Developer',
    status: 'active',
    avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop&crop=faces',
    lastLogin: '2 hours ago',
    assignedApps: 8
  },
  {
    id: 'usr-4',
    name: 'Vannak Lim',
    email: 'vannak.lim@example.com',
    role: 'Auditor',
    status: 'suspended',
    avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop&crop=faces',
    lastLogin: '4 days ago',
    assignedApps: 0
  }
]

export const mockCustomers: Customer[] = [
  {
    id: 'cust-101',
    name: 'Bopha Vong',
    phone: '+855 12 889 900',
    email: 'bopha.vong@gmail.com',
    kycStatus: 'Verified',
    tier: 'Platinum',
    joinedDate: '2025-01-14',
    totalSpent: '$4,520.00',
    usedAppsCount: 14
  },
  {
    id: 'cust-102',
    name: 'Rithy Seng',
    phone: '+855 98 445 123',
    email: 'rithy.seng@tech.kh',
    kycStatus: 'Verified',
    tier: 'Gold',
    joinedDate: '2025-03-22',
    totalSpent: '$2,190.50',
    usedAppsCount: 9
  },
  {
    id: 'cust-103',
    name: 'Kunthea Meas',
    phone: '+855 77 332 110',
    email: 'kunthea.m@outlook.com',
    kycStatus: 'Pending',
    tier: 'Silver',
    joinedDate: '2026-06-05',
    totalSpent: '$640.00',
    usedAppsCount: 3
  },
  {
    id: 'cust-104',
    name: 'Vireak Chea',
    phone: '+855 10 990 011',
    email: 'vireak.chea@gmail.com',
    kycStatus: 'Rejected',
    tier: 'Standard',
    joinedDate: '2026-08-01',
    totalSpent: '$45.00',
    usedAppsCount: 1
  }
]

export const mockLogs: AuditLog[] = [
  {
    id: 'log-9921',
    timestamp: '2026-08-22 21:04:12',
    action: 'MINIAPP_DEPLOY',
    actor: 'Phanna Pang',
    target: 'mini-pos (v2.0.4)',
    level: 'success',
    details: 'Deployed production build to edge CDN in 1.4s',
    ip: '192.168.1.45'
  },
  {
    id: 'log-9920',
    timestamp: '2026-08-22 20:58:30',
    action: 'PAYMENT_CONFIG_UPDATE',
    actor: 'Dara Sovan',
    target: 'Bakong KHQR Gateway',
    level: 'info',
    details: 'Updated settlement merchant webhook URL to prod endpoint',
    ip: '110.74.210.12'
  },
  {
    id: 'log-9919',
    timestamp: '2026-08-22 20:45:00',
    action: 'PUSH_DISPATCH',
    actor: 'SYSTEM_CRON',
    target: 'mini-coffee-pickup (24,500 users)',
    level: 'info',
    details: 'Morning Happy Hour discount broadcast successfully pushed',
    ip: '10.0.4.12'
  },
  {
    id: 'log-9918',
    timestamp: '2026-08-22 20:12:44',
    action: 'AUTH_FAILED',
    actor: 'Unknown',
    target: 'Portal Login API',
    level: 'warn',
    details: 'Multiple invalid OTP attempts on account: admin@test.com',
    ip: '45.112.89.201'
  }
]

export const mockPushCampaigns: PushCampaign[] = [
  {
    id: 'push-1',
    title: '☕ 50% Off Morning Espresso',
    message: 'Grab your morning coffee with instant pickup at all branches!',
    targetAudience: 'Active in last 7 days',
    targetApp: 'Coffee Pickup',
    sentAt: '2026-08-22 08:00 AM',
    sentCount: 18450,
    openRate: '34.2%',
    status: 'Sent'
  },
  {
    id: 'push-2',
    title: '🍿 Weekend Blockbuster Premiere',
    message: 'Reserve the best IMAX seats before tickets sell out.',
    targetAudience: 'All Cinema Users',
    targetApp: 'Cinema Ticket Booking',
    sentAt: '2026-08-21 06:30 PM',
    sentCount: 14200,
    openRate: '28.7%',
    status: 'Sent'
  },
  {
    id: 'push-3',
    title: '⚡ EV Charging Flash Deal',
    message: 'Charge during off-peak hours today and earn 2x reward points.',
    targetAudience: 'EV Drivers Tier >= Gold',
    targetApp: 'EV Charge Station',
    sentAt: '2026-08-23 10:00 AM',
    sentCount: 3200,
    openRate: '0.0%',
    status: 'Scheduled'
  }
]

export interface ConsentPolicy {
  id: string
  title: string
  category: 'Terms of Service' | 'Privacy Policy' | 'Location Access' | 'Push Alerts' | 'Camera & Media' | 'Payment Authorization' | 'Data Sharing'
  scopeApp: string // e.g. "Global (All Mini Apps)" or specific app
  version: string
  content: string
  status: 'Active' | 'Draft' | 'Deprecated'
  isRequired: boolean
  requireReconsentOnUpdate: boolean
  consentedUsersCount: number
  lastUpdated: string
}

export interface UserConsentRecord {
  id: string
  customerId: string
  customerName: string
  customerPhone: string
  policyId: string
  policyTitle: string
  appScope: string
  consentStatus: 'Granted' | 'Revoked' | 'Pending'
  consentedVersion: string
  consentedAt: string
  ipAddress: string
  userAgent: string
}

export const mockConsentPolicies: ConsentPolicy[] = [
  {
    id: 'pol-1',
    title: 'General Mini-App Platform Terms of Service',
    category: 'Terms of Service',
    scopeApp: 'Global (All Mini Apps)',
    version: 'v2.1.0',
    content: 'By accessing and running any mini application hosted within the MCNC Mini App Portal, you agree to comply with system acceptable usage policies, transaction processing standards, and rate limiting guidelines.',
    status: 'Active',
    isRequired: true,
    requireReconsentOnUpdate: true,
    consentedUsersCount: 148200,
    lastUpdated: '2026-08-10'
  },
  {
    id: 'pol-2',
    title: 'Customer Data Privacy & Profile Telemetry',
    category: 'Privacy Policy',
    scopeApp: 'Global (All Mini Apps)',
    version: 'v1.4.0',
    content: 'We collect masked device identifiers, aggregated analytics, and session duration to ensure uninterrupted runtime stability and prevent fraudulent transaction exploits.',
    status: 'Active',
    isRequired: true,
    requireReconsentOnUpdate: false,
    consentedUsersCount: 142100,
    lastUpdated: '2026-07-28'
  },
  {
    id: 'pol-3',
    title: 'Precise GPS & Nearby Store Discovery',
    category: 'Location Access',
    scopeApp: 'Coffee Pickup, EV Charge Station',
    version: 'v1.2.0',
    content: 'Grants continuous foreground GPS geolocation to calculate driving distances to pickup counters and reserve available EV charging poles.',
    status: 'Active',
    isRequired: false,
    requireReconsentOnUpdate: false,
    consentedUsersCount: 89450,
    lastUpdated: '2026-06-15'
  },
  {
    id: 'pol-4',
    title: 'Bakong KHQR Instant Auto-Debit Mandate',
    category: 'Payment Authorization',
    scopeApp: 'Bakong KHQR Hub, Cinema Ticket Booking',
    version: 'v1.0.0',
    content: 'Enables single-tap biometric checkouts up to $100 per transaction without requiring secondary PIN validation.',
    status: 'Active',
    isRequired: false,
    requireReconsentOnUpdate: true,
    consentedUsersCount: 65200,
    lastUpdated: '2026-08-01'
  },
  {
    id: 'pol-5',
    title: 'Partner Targeted Promotional Push Campaigns',
    category: 'Push Alerts',
    scopeApp: 'Global (All Mini Apps)',
    version: 'v1.1.0',
    content: 'Allows registered partner merchants to deliver personalized flash sales, ticket discounts, and coupon reminders.',
    status: 'Draft',
    isRequired: false,
    requireReconsentOnUpdate: false,
    consentedUsersCount: 0,
    lastUpdated: '2026-08-20'
  }
]

export const mockUserConsentRecords: UserConsentRecord[] = [
  {
    id: 'uc-101',
    customerId: 'CUST-8821',
    customerName: 'Sokha Meng',
    customerPhone: '+855 12 345 678',
    policyId: 'pol-1',
    policyTitle: 'General Mini-App Platform Terms of Service',
    appScope: 'Global (All Mini Apps)',
    consentStatus: 'Granted',
    consentedVersion: 'v2.1.0',
    consentedAt: '2026-08-23 09:14:22',
    ipAddress: '110.74.210.45',
    userAgent: 'iOS 18.2 / MCNC-Portal-App v4.2.0'
  },
  {
    id: 'uc-102',
    customerId: 'CUST-8821',
    customerName: 'Sokha Meng',
    customerPhone: '+855 12 345 678',
    policyId: 'pol-3',
    policyTitle: 'Precise GPS & Nearby Store Discovery',
    appScope: 'Coffee Pickup',
    consentStatus: 'Granted',
    consentedVersion: 'v1.2.0',
    consentedAt: '2026-08-23 09:15:02',
    ipAddress: '110.74.210.45',
    userAgent: 'iOS 18.2 / MCNC-Portal-App v4.2.0'
  },
  {
    id: 'uc-103',
    customerId: 'CUST-5510',
    customerName: 'Vanna Roth',
    customerPhone: '+855 98 765 432',
    policyId: 'pol-4',
    policyTitle: 'Bakong KHQR Instant Auto-Debit Mandate',
    appScope: 'Cinema Ticket Booking',
    consentStatus: 'Revoked',
    consentedVersion: 'v1.0.0',
    consentedAt: '2026-08-22 14:30:10',
    ipAddress: '203.144.144.10',
    userAgent: 'Android 15 / MCNC-Portal-App v4.2.0'
  },
  {
    id: 'uc-104',
    customerId: 'CUST-3319',
    customerName: 'Dara Chan',
    customerPhone: '+855 77 889 900',
    policyId: 'pol-1',
    policyTitle: 'General Mini-App Platform Terms of Service',
    appScope: 'Global (All Mini Apps)',
    consentStatus: 'Granted',
    consentedVersion: 'v2.1.0',
    consentedAt: '2026-08-21 18:22:45',
    ipAddress: '103.216.50.88',
    userAgent: 'Android 14 / Chrome Mobile 128'
  },
  {
    id: 'uc-105',
    customerId: 'CUST-9902',
    customerName: 'Bopha Pich',
    customerPhone: '+855 85 112 233',
    policyId: 'pol-2',
    policyTitle: 'Customer Data Privacy & Profile Telemetry',
    appScope: 'Global (All Mini Apps)',
    consentStatus: 'Pending',
    consentedVersion: 'v1.4.0',
    consentedAt: '2026-08-23 11:05:12',
    ipAddress: '110.74.195.12',
    userAgent: 'iOS 17.6 / Safari 17.6'
  }
]

