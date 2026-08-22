export interface SpaRitual {
  id: string
  name: { en: string; km: string; ko: string }
  durationMins: number
  price: number
  steps: string[]
  essentialOil: 'LAVENDER' | 'EUCALYPTUS' | 'SANDALWOOD' | 'ROSE_LOTUS'
}

export interface SpaReservation {
  id: string
  sanctuaryPassCode: string
  ritual: SpaRitual
  oilChoice: string
  selectedDate: string
  selectedTime: string
  lockerNumber: number
  robeSize: 'S' | 'M' | 'L' | 'XL'
  totalPrice: number
  status: 'CONFIRMED'
}
