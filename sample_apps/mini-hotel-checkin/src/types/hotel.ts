export interface HotelSuite {
  id: string
  name: Record<string, string>
  tier: string
  pricePerNight: number
  imageUrl: string
  sqm: number
  bedType: string
  amenities: string[]
  description: string
}

export interface HotelBookingRecord {
  id: string
  reservationNumber: string
  guestName: string
  suite: HotelSuite
  checkInDate: string
  checkOutDate: string
  nights: number
  totalPaid: number
  status: 'CONFIRMED' | 'CHECKED_IN'
  roomNumber: string
  digitalKeyQr: string
}
