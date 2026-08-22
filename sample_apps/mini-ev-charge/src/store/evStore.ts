import { reactive, computed } from 'vue'
import { EVStation, EVChargeSession } from '../types/ev'
import { EV_STATIONS } from '../data/evData'

const STORAGE_KEY = 'mini_ev_sessions_v1'

function loadSessions(): EVChargeSession[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveSessions(list: EVChargeSession[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedStation: EV_STATIONS[0] as EVStation,
  selectedPort: 'Connector A (120kW)',
  targetPercent: 80,
  initialPercent: 24,
  sessions: loadSessions(),
  currentSession: null as EVChargeSession | null
})

export function useEVStore() {
  const energyEstimatedKwh = computed(() => {
    const deltaPercent = Math.max(0, state.targetPercent - state.initialPercent)
    // assume a 70 kWh pack
    return Number(((deltaPercent / 100) * 70).toFixed(1))
  })

  const estimatedCost = computed(() => {
    return Number((energyEstimatedKwh.value * state.selectedStation.pricePerKwh).toFixed(2))
  })

  const startSession = () => {
    const id = 'EV-CHG-' + Math.floor(100 + Math.random() * 900)
    const session: EVChargeSession = {
      id,
      sessionCode: `JUICE-${Math.floor(100000 + Math.random() * 900000)}`,
      station: state.selectedStation,
      portId: state.selectedPort,
      targetPercent: state.targetPercent,
      currentPercent: state.initialPercent + 12,
      energyDeliveredKwh: energyEstimatedKwh.value,
      ratePerKwh: state.selectedStation.pricePerKwh,
      totalAmount: estimatedCost.value,
      chargingPowerKw: state.selectedStation.speedKw,
      status: 'CHARGING',
      qrValue: `${id}|${state.selectedStation.name}|${estimatedCost.value}USD|POWER_${state.selectedStation.speedKw}KW`
    }
    state.sessions.unshift(session)
    state.currentSession = session
    saveSessions(state.sessions)
    return session
  }

  return {
    state,
    energyEstimatedKwh,
    estimatedCost,
    startSession
  }
}
