export interface MovieItem {
  id: string
  title: string
  khmerTitle?: string
  genre: string
  duration: string
  rating: string
  poster: string
  banner: string
  description: string
  director: string
  cast: string[]
  formats: string[]
}

export interface ShowtimeSlot {
  id: string
  time: string
  hall: string
  format: '2D Digital' | '3D IMAX' | 'VIP Atmos'
  price: number
}

export interface CinemaSeat {
  id: string
  row: string
  number: number
  type: 'standard' | 'vip' | 'couple'
  price: number
  isBooked: boolean
}

export interface SnackItem {
  id: string
  name: string
  price: number
  description: string
  icon: string
}

export interface CinemaBookingRecord {
  id: string
  bookingCode: string
  movie: MovieItem
  showtime: ShowtimeSlot
  seats: string[]
  snacks: { snack: SnackItem; quantity: number }[]
  totalAmount: number
  visitDate: string
  cinemaBranch: string
  status: 'CONFIRMED' | 'USED' | 'CANCELLED'
  qrValue: string
}
