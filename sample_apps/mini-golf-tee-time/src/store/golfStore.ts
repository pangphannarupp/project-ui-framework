import { reactive, computed } from 'vue'
import type { GolfHole, CaddieProfile, TeeTimeBooking } from '../types/golf'
import { GOLF_HOLES, CADDIES } from '../data/golfData'

interface GolfState {
  selectedHole: GolfHole
  holesCount: 9 | 18
  playersCount: number
  selectedDate: string
  selectedTeeTime: string
  selectedCaddie: CaddieProfile | null
  cartIncluded: boolean
  bookings: TeeTimeBooking[]
  latestBooking: TeeTimeBooking | null
}

const state = reactive<GolfState>({
  selectedHole: GOLF_HOLES[0],
  holesCount: 18,
  playersCount: 2,
  selectedDate: '2026-08-26',
  selectedTeeTime: '07:30 AM (Sunrise Tee)',
  selectedCaddie: CADDIES[0],
  cartIncluded: true,
  bookings: [],
  latestBooking: null
})

export function useGolfStore() {
  const baseGreenFee = computed(() => {
    const feePerPlayer = state.holesCount === 18 ? 95.00 : 55.00
    let total = feePerPlayer * state.playersCount
    if (state.selectedCaddie) total += state.selectedCaddie.fee
    if (state.cartIncluded) total += 30.00
    return total
  })

  const confirmTeeTime = () => {
    const b: TeeTimeBooking = {
      id: 'golf-' + Date.now(),
      bookingCode: 'AUG-' + Math.floor(10000 + Math.random() * 90000),
      courseName: 'Augusta Championship 18-Hole',
      holesCount: state.holesCount,
      playersCount: state.playersCount,
      teeTime: state.selectedTeeTime,
      selectedDate: state.selectedDate,
      caddie: state.selectedCaddie,
      cartIncluded: state.cartIncluded,
      totalFee: baseGreenFee.value,
      status: 'CONFIRMED'
    }
    state.bookings.unshift(b)
    state.latestBooking = b
    return b
  }

  return { state, baseGreenFee, confirmTeeTime }
}
