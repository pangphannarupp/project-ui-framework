import { LaundryMachine } from '../types/laundry'

export const LAUNDRY_MACHINES: LaundryMachine[] = [
  { id: 'm-w1', number: 'Washer 01', type: 'WASHER', capacityKg: 14, pricePerCycle: 2.50, rpmSpeed: 1400, status: 'AVAILABLE' },
  { id: 'm-w2', number: 'Washer 02 (Jumbo)', type: 'WASHER', capacityKg: 20, pricePerCycle: 3.50, rpmSpeed: 1400, status: 'AVAILABLE' },
  { id: 'm-w3', number: 'Washer 03', type: 'WASHER', capacityKg: 14, pricePerCycle: 2.50, rpmSpeed: 1400, status: 'RUNNING', remainingMinutes: 18 },
  { id: 'm-d1', number: 'Dryer 01 (Turbo Heat)', type: 'DRYER', capacityKg: 16, pricePerCycle: 2.00, rpmSpeed: 800, status: 'AVAILABLE' },
  { id: 'm-d2', number: 'Dryer 02 (Sanitize)', type: 'DRYER', capacityKg: 20, pricePerCycle: 3.00, rpmSpeed: 800, status: 'AVAILABLE' }
]
