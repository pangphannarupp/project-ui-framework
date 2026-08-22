export interface OmakaseSeat {
  seatNumber: number
  position: 'CHEF_CENTER' | 'CORNER_LEFT' | 'CORNER_RIGHT' | 'PRIVATE_TATAMI'
  isReserved: boolean
}

export interface TastingCourse {
  courseNumber: number
  name: { en: string; km: string; ko: string }
  ingredient: string
  sakePairing: string
}

export interface OmakaseBooking {
  id: string
  invitationCode: string
  experienceName: string
  seat: OmakaseSeat
  seatingTime: string
  selectedDate: string
  sakePairingIncluded: boolean
  guestCount: number
  totalPrice: number
  status: 'CONFIRMED'
}
