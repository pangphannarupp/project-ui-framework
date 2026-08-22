export interface GymPass {
  id: string
  title: string
  subtitle: string
  price: number
  validity: string
  accessType: string
  features: string[]
  badge: string
}

export interface GymClassSession {
  id: string
  name: string
  instructor: string
  time: string
  duration: string
  intensity: 'HIGH' | 'MEDIUM' | 'EXTREME'
  spotsLeft: number
  totalSpots: number
  room: string
}

export interface GymMembershipRecord {
  id: string
  passCode: string
  memberId: string
  planName: string
  validUntil: string
  totalPaid: number
  status: 'ACTIVE' | 'EXPIRED'
  turnstileQr: string
}
