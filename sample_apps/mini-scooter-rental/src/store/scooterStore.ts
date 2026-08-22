import { reactive, computed } from 'vue'
import type { ScooterUnit, RideTrip } from '../types/scooter'
import { NEARBY_SCOOTERS } from '../data/scooterData'

interface ScooterState {
  selectedScooter: ScooterUnit
  trips: RideTrip[]
  activeTrip: RideTrip | null
  depositAmount: number
}

const state = reactive<ScooterState>({
  selectedScooter: NEARBY_SCOOTERS[0],
  trips: [],
  activeTrip: null,
  depositAmount: 5.00
})

export function useScooterStore() {
  const initialCost = computed(() => {
    return state.selectedScooter.unlockFee + state.depositAmount
  })

  const startRide = () => {
    const trip: RideTrip = {
      id: 'trip-' + Date.now(),
      tripCode: 'VLT-' + Math.floor(10000 + Math.random() * 90000),
      scooter: state.selectedScooter,
      startTime: new Date().toLocaleTimeString(),
      durationMinutes: 14,
      totalCost: state.selectedScooter.unlockFee + (14 * state.selectedScooter.pricePerMinute),
      distanceKm: 2.8,
      carbonSavedKg: 0.42,
      status: 'ACTIVE'
    }
    state.trips.unshift(trip)
    state.activeTrip = trip
    return trip
  }

  return { state, initialCost, startRide }
}
