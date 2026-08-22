export interface ParkingSession {
  id: string
  ticketNumber: string
  plateNumber: string
  entryTime: string
  entryDate: string
  location: string
  vehicleType: 'Car' | 'Motorcycle' | 'EV / Van'
  hourlyRate: number
  durationHours: number
  totalFee: number
  status: 'UNPAID' | 'PAID' | 'EXITED'
  qrValue: string
}

export interface SeasonPassPlan {
  id: string
  name: string
  price: number
  period: string
  vehicleType: string
  features: string[]
}
