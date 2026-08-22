import { reactive, computed } from 'vue'
import { ParkingSession } from '../types/parking'
import { DEMO_SESSIONS, SEASON_PLANS } from '../data/parkingData'

const state = reactive({
  plateInput: '2BK-8899',
  activeSession: DEMO_SESSIONS[0] as ParkingSession | null,
  history: [] as ParkingSession[],
  paidSession: null as ParkingSession | null
})

export function useParkingStore() {
  const searchPlate = (plate: string) => {
    const p = plate.trim().toUpperCase()
    const found = DEMO_SESSIONS.find(s => s.plateNumber.toUpperCase().includes(p))
    if (found) {
      state.activeSession = found
      return true
    } else {
      state.activeSession = {
        id: 'PARK-' + Math.floor(1000 + Math.random() * 9000),
        ticketNumber: 'TKT-' + Math.floor(100000 + Math.random() * 900000),
        plateNumber: p || '1AA-0001',
        entryTime: '02:30 PM',
        entryDate: new Date().toISOString().split('T')[0],
        location: 'Aeon Mall Sen Sok (P1)',
        vehicleType: 'Car',
        hourlyRate: 1.00,
        durationHours: 1.5,
        totalFee: 1.50,
        status: 'UNPAID',
        qrValue: `PARK-NEW|${p}|1.50USD`
      }
      return true
    }
  }

  const markPaid = () => {
    if (state.activeSession) {
      state.activeSession.status = 'PAID'
      state.activeSession.qrValue = `${state.activeSession.id}|${state.activeSession.plateNumber}|PAID_OPEN_BARRIER`
      state.paidSession = { ...state.activeSession }
      state.history.unshift(state.paidSession)
    }
  }

  return {
    state,
    searchPlate,
    markPaid
  }
}
