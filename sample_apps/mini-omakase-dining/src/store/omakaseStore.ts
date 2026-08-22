import { reactive, computed } from 'vue'
import type { OmakaseSeat, OmakaseBooking } from '../types/omakase'
import { OMAKASE_SEATS } from '../data/omakaseData'

interface OmakaseState {
  selectedSeat: OmakaseSeat
  guestCount: number
  selectedDate: string
  selectedSeatingTime: string
  sakePairingIncluded: boolean
  bookings: OmakaseBooking[]
  latestBooking: OmakaseBooking | null
}

const state = reactive<OmakaseState>({
  selectedSeat: OMAKASE_SEATS[1], // Chef Center
  guestCount: 2,
  selectedDate: '2026-08-28',
  selectedSeatingTime: '07:30 PM (Second Seating)',
  sakePairingIncluded: true,
  bookings: [],
  latestBooking: null
})

export function useOmakaseStore() {
  const baseTastingPrice = 180.00
  const sakePairingPrice = 65.00

  const totalCost = computed(() => {
    let cost = baseTastingPrice * state.guestCount
    if (state.sakePairingIncluded) cost += (sakePairingPrice * state.guestCount)
    return cost
  })

  const confirmReservation = () => {
    const b: OmakaseBooking = {
      id: 'omakase-' + Date.now(),
      invitationCode: 'HINOKI-' + Math.floor(10000 + Math.random() * 90000),
      experienceName: 'Grand 12-Course Omakase Experience',
      seat: state.selectedSeat,
      seatingTime: state.selectedSeatingTime,
      selectedDate: state.selectedDate,
      sakePairingIncluded: state.sakePairingIncluded,
      guestCount: state.guestCount,
      totalPrice: totalCost.value,
      status: 'CONFIRMED'
    }
    state.bookings.unshift(b)
    state.latestBooking = b
    return b
  }

  return { state, totalCost, confirmReservation }
}
