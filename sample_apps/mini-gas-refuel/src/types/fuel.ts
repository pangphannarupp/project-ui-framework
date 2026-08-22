export interface FuelPump {
  id: string
  pumpNumber: number
  status: 'AVAILABLE' | 'OCCUPIED' | 'DISPENSING'
  supportedGrades: FuelGrade[]
}

export interface FuelGrade {
  id: string
  name: string
  octane: number
  pricePerLiter: number
  badgeColor: string
}

export interface FuelTransaction {
  id: string
  receiptNumber: string
  pumpNumber: number
  fuelGrade: FuelGrade
  volumeLiters: number
  totalAmount: number
  timestamp: string
  status: 'COMPLETED'
}
