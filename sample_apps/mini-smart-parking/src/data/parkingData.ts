import { ParkingSession, SeasonPassPlan } from '../types/parking'

export const DEMO_SESSIONS: ParkingSession[] = [
  {
    id: 'PARK-7712',
    ticketNumber: 'TKT-884910',
    plateNumber: '2BK-8899',
    entryTime: '01:15 PM',
    entryDate: new Date().toISOString().split('T')[0],
    location: 'Chip Mong Mega Mall (B1-Zone A)',
    vehicleType: 'Car',
    hourlyRate: 1.00,
    durationHours: 2.5,
    totalFee: 2.50,
    status: 'UNPAID',
    qrValue: 'PARK-7712|2BK-8899|2.50USD|UNPAID'
  },
  {
    id: 'PARK-7713',
    ticketNumber: 'TKT-884911',
    plateNumber: '1AZ-3344',
    entryTime: '02:00 PM',
    entryDate: new Date().toISOString().split('T')[0],
    location: 'Eden Garden Smart Lot (Ground Floor)',
    vehicleType: 'Car',
    hourlyRate: 1.00,
    durationHours: 1.0,
    totalFee: 1.00,
    status: 'UNPAID',
    qrValue: 'PARK-7713|1AZ-3344|1.00USD|UNPAID'
  }
]

export const SEASON_PLANS: SeasonPassPlan[] = [
  {
    id: 'pass-monthly-car',
    name: 'Unlimited Monthly Car Pass',
    price: 35.00,
    period: '30 Days',
    vehicleType: 'Car',
    features: ['Auto License Plate Gate Open', 'Guaranteed reserved bay', '24/7 Security CCTV monitoring']
  },
  {
    id: 'pass-monthly-moto',
    name: 'Motorcycle Monthly Pass',
    price: 10.00,
    period: '30 Days',
    vehicleType: 'Motorcycle',
    features: ['Contactless NFC/QR Entry', 'Covered parking zone']
  }
]
