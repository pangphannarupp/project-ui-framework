import { BusRoute } from '../types/bus'

export const BUS_ROUTES: BusRoute[] = [
  {
    id: 'r-1',
    operator: 'Giant Ibis Transport',
    origin: 'Phnom Penh',
    destination: 'Siem Reap (Angkor)',
    departureTime: '08:30 AM',
    arrivalTime: '02:30 PM',
    duration: '6h 00m',
    busType: 'VIP Night Sleeper / WiFi',
    price: 15.00,
    availableSeats: 14,
    icon: '🚌'
  },
  {
    id: 'r-2',
    operator: 'VET Express (Vireak Buntham)',
    origin: 'Phnom Penh',
    destination: 'Sihanoukville (Expressway)',
    departureTime: '09:15 AM',
    arrivalTime: '11:45 AM',
    duration: '2h 30m',
    busType: 'Luxury Hotel Bus',
    price: 13.50,
    availableSeats: 8,
    icon: '🚐'
  },
  {
    id: 'r-3',
    operator: 'Mey Hong Express',
    origin: 'Phnom Penh',
    destination: 'Battambang',
    departureTime: '01:00 PM',
    arrivalTime: '06:00 PM',
    duration: '5h 00m',
    busType: 'Air-Con Modern Coach',
    price: 11.00,
    availableSeats: 18,
    icon: '🚌'
  },
  {
    id: 'r-4',
    operator: 'Buva Sea Ferry Express',
    origin: 'Sihanoukville Port',
    destination: 'Koh Rong Sanloem Island',
    departureTime: '10:00 AM',
    arrivalTime: '10:45 AM',
    duration: '45m',
    busType: 'High-Speed Catamaran',
    price: 14.00,
    availableSeats: 22,
    icon: '🛥️'
  }
]

export const CITIES_LIST = ['Phnom Penh', 'Siem Reap (Angkor)', 'Sihanoukville', 'Battambang', 'Kampot', 'Koh Rong']
