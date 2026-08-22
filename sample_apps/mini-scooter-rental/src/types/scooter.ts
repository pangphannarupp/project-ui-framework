export interface ScooterUnit {
  id: string
  code: string
  model: string
  batteryPercent: number
  rangeKm: number
  distanceMeters: number
  pricePerMinute: number
  unlockFee: number
  status: 'AVAILABLE' | 'IN_USE' | 'LOW_BATTERY'
  latOffset: number
  lngOffset: number
}

export interface RideTrip {
  id: string
  tripCode: string
  scooter: ScooterUnit
  startTime: string
  durationMinutes: number
  totalCost: number
  distanceKm: number
  carbonSavedKg: number
  status: 'ACTIVE' | 'COMPLETED'
}
