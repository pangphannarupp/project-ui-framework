export interface MiniApp {
  id: string
  name: string
  slug: string
  category: 'Food & Beverage' | 'Entertainment' | 'Services' | 'Mobility' | 'Finance'
  icon: string
  version: string
  packageType: 'zip' | 'web_url' | 'native_aar'
  packageUrl?: string
  fileName?: string
  fileSize?: string
  androidPackageName?: string
  androidActivityClass?: string
  iosViewControllerClass?: string
  status: 'active' | 'staging' | 'maintenance' | 'deprecated'
  usersCount: number
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

export const mockMiniApps: MiniApp[] = [
  {
    id: 'app-1',
    name: 'Coffee Pickup',
    slug: 'mini-coffee-pickup',
    category: 'Food & Beverage',
    icon: 'cafe-outline',
    version: 'v2.4.1',
    packageType: 'zip',
    fileName: 'coffee-pickup-v2.4.1.zip',
    fileSize: '4.8 MB',
    status: 'active',
    usersCount: 24500,
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
    icon: 'apps-outline',
    version: 'v3.0.0',
    packageType: 'web_url',
    packageUrl: 'https://cdn.miniportal.io/apps/smart-hub/index.html',
    status: 'active',
    usersCount: 88400,
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
    icon: 'film-outline',
    version: 'v1.8.2',
    packageType: 'zip',
    fileName: 'cinema-booking-prod.zip',
    fileSize: '6.2 MB',
    status: 'active',
    usersCount: 15300,
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
    icon: 'flash-outline',
    version: 'v2.1.0',
    packageType: 'native_aar',
    fileName: 'ev-charge-sdk-release.aar',
    fileSize: '12.4 MB',
    status: 'active',
    usersCount: 9200,
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
    icon: 'flower-outline',
    version: 'v1.5.0',
    packageType: 'zip',
    fileName: 'spa-wellness-bundle.zip',
    fileSize: '3.9 MB',
    status: 'staging',
    usersCount: 4200,
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
    icon: 'card-outline',
    version: 'v2.0.4',
    packageType: 'native_aar',
    fileName: 'mini-pos-engine-v2.0.4.aar',
    fileSize: '8.7 MB',
    status: 'active',
    usersCount: 31000,
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
