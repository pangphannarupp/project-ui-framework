export interface WashTier {
  id: string
  name: Record<string, string>
  price: number
  durationMins: number
  badge: string
  features: string[]
}

export interface CarWashRecord {
  id: string
  washTicket: string
  vehiclePlate: string
  vehicleModel: string
  tier: WashTier
  bayAssigned: string
  totalPaid: number
  status: 'QUEUED' | 'IN_WASH_BAY' | 'COMPLETED'
  qrValue: string
  createdAt: string
}
