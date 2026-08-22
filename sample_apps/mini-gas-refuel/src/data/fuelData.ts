import type { FuelGrade, FuelPump } from '../types/fuel'

export const FUEL_GRADES: FuelGrade[] = [
  { id: 'g-92', name: 'Regular Unleaded', octane: 92, pricePerLiter: 1.15, badgeColor: '#3b82f6' },
  { id: 'g-95', name: 'Super Premium Nitro', octane: 95, pricePerLiter: 1.35, badgeColor: '#ef4444' },
  { id: 'g-diesel', name: 'Ultra-Clean BioDiesel', octane: 50, pricePerLiter: 1.05, badgeColor: '#10b981' }
]

export const FUEL_PUMPS: FuelPump[] = [
  { id: 'p-1', pumpNumber: 1, status: 'AVAILABLE', supportedGrades: FUEL_GRADES },
  { id: 'p-2', pumpNumber: 2, status: 'OCCUPIED', supportedGrades: FUEL_GRADES },
  { id: 'p-3', pumpNumber: 3, status: 'AVAILABLE', supportedGrades: FUEL_GRADES },
  { id: 'p-4', pumpNumber: 4, status: 'AVAILABLE', supportedGrades: FUEL_GRADES }
]
