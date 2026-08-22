import { reactive, computed } from 'vue'
import type { FlightLeg, SeatNode, BoardingPass } from '../types/flight'
import { ACTIVE_FLIGHT } from '../data/flightData'

interface FlightState {
  flight: FlightLeg
  selectedSeat: SeatNode
  loungeAccess: boolean
  mealOption: string
  passengerName: string
  boardingPasses: BoardingPass[]
  latestPass: BoardingPass | null
}

const state = reactive<FlightState>({
  flight: ACTIVE_FLIGHT,
  selectedSeat: ACTIVE_FLIGHT.seats[0],
  loungeAccess: true,
  mealOption: 'Book the Cook: Lobster Thermidor',
  passengerName: 'MR. ALEXANDER MORGAN',
  boardingPasses: [],
  latestPass: null
})

export function useFlightStore() {
  const totalCost = computed(() => {
    let cost = state.selectedSeat.price
    if (state.loungeAccess) cost += 45.00
    return cost
  })

  const issueBoardingPass = () => {
    const pass: BoardingPass = {
      id: 'pass-' + Date.now(),
      eticketNumber: 'ETKT-618-' + Math.floor(1000000 + Math.random() * 9000000),
      passengerName: state.passengerName,
      flight: state.flight,
      seat: state.selectedSeat,
      loungeAccess: state.loungeAccess,
      mealPreference: state.mealOption,
      totalPrice: totalCost.value,
      status: 'ISSUED',
      boardingBarcode: `M1MORGAN/ALEXANDER ${state.flight.flightNumber} ${state.flight.originCode}${state.flight.destCode}SQ ${state.selectedSeat.seatNumber}`
    }
    state.boardingPasses.unshift(pass)
    state.latestPass = pass
    return pass
  }

  return { state, totalCost, issueBoardingPass }
}
