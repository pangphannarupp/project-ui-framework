import type { ScooterUnit } from '../types/scooter'

export const NEARBY_SCOOTERS: ScooterUnit[] = [
  {
    id: 'sc-volt-01',
    code: 'VOLT-8821',
    model: 'Segway Ninebot Max Pro',
    batteryPercent: 94,
    rangeKm: 42,
    distanceMeters: 45,
    pricePerMinute: 0.25,
    unlockFee: 1.00,
    status: 'AVAILABLE',
    latOffset: 20,
    lngOffset: -15
  },
  {
    id: 'sc-volt-02',
    code: 'VOLT-5510',
    model: 'Segway Ninebot Max Pro',
    batteryPercent: 78,
    rangeKm: 34,
    distanceMeters: 120,
    pricePerMinute: 0.25,
    unlockFee: 1.00,
    status: 'AVAILABLE',
    latOffset: -30,
    lngOffset: 40
  },
  {
    id: 'sc-volt-03',
    code: 'VOLT-3392',
    model: 'Apex Dual-Motor Turbo',
    batteryPercent: 88,
    rangeKm: 38,
    distanceMeters: 210,
    pricePerMinute: 0.30,
    unlockFee: 1.00,
    status: 'AVAILABLE',
    latOffset: 45,
    lngOffset: 35
  }
]
