export interface EVStation {
  id: string
  name: string
  network: string
  address: string
  availablePorts: number
  totalPorts: number
  speedKw: number
  pricePerKwh: number
  connectorTypes: string[]
  status: 'AVAILABLE' | 'OCCUPIED' | 'MAINTENANCE'
}

export interface EVChargeSession {
  id: string
  sessionCode: string
  station: EVStation
  portId: string
  targetPercent: number
  currentPercent: number
  energyDeliveredKwh: number
  ratePerKwh: number
  totalAmount: number
  chargingPowerKw: number
  status: 'CHARGING' | 'COMPLETED' | 'CANCELLED'
  qrValue: string
}
