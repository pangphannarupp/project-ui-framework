import { ParcelLocker } from '../types/parcel'

export const PARCEL_LOCKERS: ParcelLocker[] = [
  { id: 'l-s1', bayNumber: 'Locker 01-A', size: 'SMALL', maxWeightKg: 5, price: 1.50, status: 'AVAILABLE', dimensions: '10 x 40 x 45 cm' },
  { id: 'l-s2', bayNumber: 'Locker 01-B', size: 'SMALL', maxWeightKg: 5, price: 1.50, status: 'AVAILABLE', dimensions: '10 x 40 x 45 cm' },
  { id: 'l-m1', bayNumber: 'Locker 02-A', size: 'MEDIUM', maxWeightKg: 15, price: 2.50, status: 'AVAILABLE', dimensions: '25 x 40 x 45 cm' },
  { id: 'l-m2', bayNumber: 'Locker 02-B', size: 'MEDIUM', maxWeightKg: 15, price: 2.50, status: 'OCCUPIED', dimensions: '25 x 40 x 45 cm' },
  { id: 'l-l1', bayNumber: 'Locker 03-A', size: 'LARGE', maxWeightKg: 30, price: 4.00, status: 'AVAILABLE', dimensions: '45 x 40 x 45 cm' }
]
