import { reactive, computed } from 'vue'
import type { SpaRitual, SpaReservation } from '../types/spa'
import { SPA_RITUALS } from '../data/spaData'

interface SpaState {
  selectedRitual: SpaRitual
  selectedOil: string
  selectedDate: string
  selectedTime: string
  robeSize: 'S' | 'M' | 'L' | 'XL'
  reservations: SpaReservation[]
  latestReservation: SpaReservation | null
}

const state = reactive<SpaState>({
  selectedRitual: SPA_RITUALS[0],
  selectedOil: 'French Lavender & Roman Chamomile',
  selectedDate: '2026-08-29',
  selectedTime: '03:00 PM (Afternoon Mist)',
  robeSize: 'M',
  reservations: [],
  latestReservation: null
})

export function useSpaStore() {
  const totalCost = computed(() => {
    return state.selectedRitual.price
  })

  const confirmReservation = () => {
    const res: SpaReservation = {
      id: 'spa-' + Date.now(),
      sanctuaryPassCode: 'ZEN-' + Math.floor(10000 + Math.random() * 90000),
      ritual: state.selectedRitual,
      oilChoice: state.selectedOil,
      selectedDate: state.selectedDate,
      selectedTime: state.selectedTime,
      lockerNumber: Math.floor(10 + Math.random() * 80),
      robeSize: state.robeSize,
      totalPrice: totalCost.value,
      status: 'CONFIRMED'
    }
    state.reservations.unshift(res)
    state.latestReservation = res
    return res
  }

  return { state, totalCost, confirmReservation }
}
