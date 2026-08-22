export interface GolfHole {
  holeNumber: number
  par: number
  distanceYards: number
  handicapIndex: number
  fairwayType: 'DOGLEG_LEFT' | 'STRAIGHT' | 'ISLAND_GREEN' | 'WATER_HAZARD'
  stimpMeterSpeed: number
}

export interface CaddieProfile {
  id: string
  name: string
  experienceYears: number
  rating: number
  fee: number
  specialty: string
}

export interface TeeTimeBooking {
  id: string
  bookingCode: string
  courseName: string
  holesCount: 9 | 18
  playersCount: number
  teeTime: string
  selectedDate: string
  caddie: CaddieProfile | null
  cartIncluded: boolean
  totalFee: number
  status: 'CONFIRMED'
}
