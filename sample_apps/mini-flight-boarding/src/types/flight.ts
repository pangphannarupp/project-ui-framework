export interface SeatNode {
  seatNumber: string
  cabinClass: 'FIRST' | 'BUSINESS' | 'ECONOMY_PLUS' | 'ECONOMY'
  type: 'WINDOW' | 'AISLE' | 'MIDDLE'
  price: number
  isOccupied: boolean
  extraLegroom: boolean
}

export interface FlightLeg {
  id: string
  flightNumber: string
  airline: string
  originCode: string
  originCity: string
  destCode: string
  destCity: string
  departureTime: string
  arrivalTime: string
  gate: string
  terminal: string
  boardingGroup: string
  aircraft: string
  seats: SeatNode[]
}

export interface BoardingPass {
  id: string
  eticketNumber: string
  passengerName: string
  flight: FlightLeg
  seat: SeatNode
  loungeAccess: boolean
  mealPreference: string
  totalPrice: number
  status: 'ISSUED' | 'BOARDED'
  boardingBarcode: string
}
