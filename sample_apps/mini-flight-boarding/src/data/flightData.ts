import type { FlightLeg } from '../types/flight'

export const ACTIVE_FLIGHT: FlightLeg = {
  id: 'fl-sq318',
  flightNumber: 'SQ-318',
  airline: 'Singapore Airlines First Class',
  originCode: 'SIN',
  originCity: 'Singapore Changi (T3)',
  destCode: 'LHR',
  destCity: 'London Heathrow (T2)',
  departureTime: '11:45 PM',
  arrivalTime: '05:55 AM (+1)',
  gate: 'B04',
  terminal: 'T3',
  boardingGroup: 'ZONE 1 (SUITES)',
  aircraft: 'Airbus A380-800 SkySuite',
  seats: [
    { seatNumber: '1A', cabinClass: 'FIRST', type: 'WINDOW', price: 420.00, isOccupied: false, extraLegroom: true },
    { seatNumber: '1K', cabinClass: 'FIRST', type: 'WINDOW', price: 420.00, isOccupied: true, extraLegroom: true },
    { seatNumber: '2A', cabinClass: 'FIRST', type: 'WINDOW', price: 380.00, isOccupied: false, extraLegroom: true },
    { seatNumber: '2F', cabinClass: 'BUSINESS', type: 'AISLE', price: 210.00, isOccupied: false, extraLegroom: true },
    { seatNumber: '3A', cabinClass: 'BUSINESS', type: 'WINDOW', price: 210.00, isOccupied: false, extraLegroom: false },
    { seatNumber: '3K', cabinClass: 'BUSINESS', type: 'WINDOW', price: 210.00, isOccupied: true, extraLegroom: false }
  ]
}
