export interface LaundryMachine {
  id: string
  number: string
  type: 'WASHER' | 'DRYER'
  capacityKg: number
  pricePerCycle: number
  rpmSpeed: number
  status: 'AVAILABLE' | 'RUNNING' | 'MAINTENANCE'
  remainingMinutes?: number
}

export interface LaundryCycleConfig {
  waterTemp: 'Cold (Eco)' | 'Warm 40°C' | 'Hot 60°C (Sanitize)'
  spinSpeed: 'Delicate (600 RPM)' | 'Standard (1000 RPM)' | 'Turbo (1400 RPM)'
  extraRinse: boolean
  scentBooster: boolean
}

export interface LaundrySessionRecord {
  id: string
  sessionToken: string
  machine: LaundryMachine
  config: LaundryCycleConfig
  totalPaid: number
  startTime: string
  durationMins: number
  status: 'RUNNING' | 'COMPLETED'
  qrValue: string
}
