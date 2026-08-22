import { reactive, computed } from 'vue'
import { LaundryMachine, LaundryCycleConfig, LaundrySessionRecord } from '../types/laundry'
import { LAUNDRY_MACHINES } from '../data/laundryData'

const STORAGE_KEY = 'mini_laundry_sessions_v1'

function loadSessions(): LaundrySessionRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveSessions(list: LaundrySessionRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedMachine: LAUNDRY_MACHINES[0] as LaundryMachine,
  config: {
    waterTemp: 'Warm 40°C',
    spinSpeed: 'Standard (1000 RPM)',
    extraRinse: true,
    scentBooster: true
  } as LaundryCycleConfig,
  sessions: loadSessions(),
  currentSession: null as LaundrySessionRecord | null
})

export function useLaundryStore() {
  const totalCost = computed(() => {
    let cost = state.selectedMachine.pricePerCycle
    if (state.config.extraRinse) cost += 0.50
    if (state.config.scentBooster) cost += 0.50
    return Number(cost.toFixed(2))
  })

  const startCycle = () => {
    const id = 'LAUNDRY-' + Math.floor(100 + Math.random() * 900)
    const rec: LaundrySessionRecord = {
      id,
      sessionToken: `WASH-${Math.floor(100000 + Math.random() * 900000)}`,
      machine: state.selectedMachine,
      config: { ...state.config },
      totalPaid: totalCost.value,
      startTime: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      durationMins: state.selectedMachine.type === 'WASHER' ? 32 : 45,
      status: 'RUNNING',
      qrValue: `${id}|${state.selectedMachine.number}|DOOR_UNLOCKED|${totalCost.value}USD`
    }
    state.sessions.unshift(rec)
    state.currentSession = rec
    saveSessions(state.sessions)
    return rec
  }

  return {
    state,
    totalCost,
    startCycle
  }
}
