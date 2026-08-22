export interface ParcelLocker {
  id: string
  bayNumber: string
  size: 'SMALL' | 'MEDIUM' | 'LARGE'
  maxWeightKg: number
  price: number
  status: 'AVAILABLE' | 'OCCUPIED'
  dimensions: string
}

export interface ParcelActionRecord {
  id: string
  pinCode: string
  lockerBay: string
  size: string
  actionType: 'DROP_OFF' | 'PICK_UP'
  senderPhone: string
  recipientPhone: string
  totalPaid: number
  createdAt: string
  doorStatus: 'LOCKED' | 'UNLOCKED'
  qrValue: string
}
