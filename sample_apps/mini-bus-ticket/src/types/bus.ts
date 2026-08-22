export interface BusRoute {
  id: string
  operator: string
  origin: string
  destination: string
  departureTime: string
  arrivalTime: string
  duration: string
  busType: string
  price: number
  availableSeats: number
  icon: string
}

export interface BusBookingRecord {
  id: string
  ticketCode: string
  route: BusRoute
  seats: string[]
  passengerName: string
  passengerPhone: string
  travelDate: string
  boardingPoint: string
  totalAmount: number
  status: 'CONFIRMED' | 'BOARDED' | 'CANCELLED'
  qrValue: string
}
