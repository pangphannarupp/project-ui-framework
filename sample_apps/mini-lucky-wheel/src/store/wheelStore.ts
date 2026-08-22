import { reactive } from 'vue'
import { WheelPrize, SpinTicketRecord } from '../types/wheel'
import { WHEEL_PRIZES } from '../data/wheelData'

export interface SpinPack {
  id: string
  spins: number
  price: number
  bonus: string
}

export const SPIN_PACKS: SpinPack[] = [
  { id: 'pack-3', spins: 3, price: 1.00, bonus: 'Popular Starter' },
  { id: 'pack-10', spins: 10, price: 3.00, bonus: '+2 Bonus Spins Free' },
  { id: 'pack-25', spins: 25, price: 6.00, bonus: 'Best Value (+5 Spins)' }
]

const STORAGE_KEY = 'mini_wheel_tickets_v1'

function loadHistory(): SpinTicketRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveHistory(list: SpinTicketRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  availableSpins: 3,
  selectedPack: SPIN_PACKS[0] as SpinPack,
  wonPrizes: [] as WheelPrize[],
  history: loadHistory(),
  isSpinning: false
})

export function useWheelStore() {
  const addSpins = (pack: SpinPack) => {
    state.availableSpins += pack.spins
    const id = 'WHEEL-' + Math.floor(100 + Math.random() * 900)
    const rec: SpinTicketRecord = {
      id,
      code: `SPIN-${Math.floor(100000 + Math.random() * 900000)}`,
      spinsBought: pack.spins,
      price: pack.price,
      prizesWon: [],
      status: 'AVAILABLE',
      qrValue: `${id}|${pack.spins}_SPINS|${pack.price}USD`,
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    }
    state.history.unshift(rec)
    saveHistory(state.history)
    return rec
  }

  const recordWin = (prize: WheelPrize) => {
    state.wonPrizes.unshift(prize)
    if (state.history.length > 0) {
      state.history[0].prizesWon.push(prize)
      saveHistory(state.history)
    }
  }

  return {
    state,
    addSpins,
    recordWin
  }
}
