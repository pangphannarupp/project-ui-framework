import { reactive, computed } from 'vue'
import type { FuelPump, FuelGrade, FuelTransaction } from '../types/fuel'
import { FUEL_PUMPS, FUEL_GRADES } from '../data/fuelData'

interface FuelState {
  selectedPump: FuelPump
  selectedGrade: FuelGrade
  fuelPresetDollars: number
  transactions: FuelTransaction[]
  latestTransaction: FuelTransaction | null
}

const state = reactive<FuelState>({
  selectedPump: FUEL_PUMPS[0],
  selectedGrade: FUEL_GRADES[1], // Super Premium Nitro
  fuelPresetDollars: 30.00,
  transactions: [],
  latestTransaction: null
})

export function useFuelStore() {
  const calculatedLiters = computed(() => {
    return state.fuelPresetDollars / state.selectedGrade.pricePerLiter
  })

  const dispenseFuel = () => {
    const tx: FuelTransaction = {
      id: 'fuel-' + Date.now(),
      receiptNumber: 'NITRO-' + Math.floor(100000 + Math.random() * 900000),
      pumpNumber: state.selectedPump.pumpNumber,
      fuelGrade: state.selectedGrade,
      volumeLiters: parseFloat(calculatedLiters.value.toFixed(2)),
      totalAmount: state.fuelPresetDollars,
      timestamp: new Date().toLocaleTimeString(),
      status: 'COMPLETED'
    }
    state.transactions.unshift(tx)
    state.latestTransaction = tx
    return tx
  }

  return { state, calculatedLiters, dispenseFuel }
}
