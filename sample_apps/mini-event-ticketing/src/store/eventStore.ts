import { reactive } from 'vue'
import { ConcertEvent, EventZoneTier, ConcertPassRecord } from '../types/event'
import { CONCERT_EVENTS } from '../data/eventData'

const STORAGE_KEY = 'mini_concert_passes_v1'

function loadPasses(): ConcertPassRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function savePasses(list: ConcertPassRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  currentEvent: CONCERT_EVENTS[0] as ConcertEvent,
  selectedZone: CONCERT_EVENTS[0].zones[0] as EventZoneTier,
  passes: loadPasses(),
  currentPass: null as ConcertPassRecord | null
})

export function useEventStore() {
  const purchaseTicket = () => {
    const id = 'CONCERT-' + Math.floor(100 + Math.random() * 900)
    const tNum = `ARENA-${Math.floor(100000 + Math.random() * 900000)}`
    const sCode = state.selectedZone.id === 'z-vip' ? 'GOLDEN-A-042' : state.selectedZone.id === 'z-standing' ? 'FLOOR-GA-88' : 'SEC-204-ROW-F'
    const rec: ConcertPassRecord = {
      id,
      ticketNumber: tNum,
      event: state.currentEvent,
      zone: state.selectedZone,
      seatCode: sCode,
      totalPaid: state.selectedZone.price,
      status: 'VALID',
      entryGate: state.selectedZone.id === 'z-vip' ? 'VIP Gate 1' : 'Gate 3 (South Entrance)',
      qrValue: `${id}|${tNum}|${state.currentEvent.title}|${state.selectedZone.name.en}|VALID_PASS`,
      issuedAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    }
    state.passes.unshift(rec)
    state.currentPass = rec
    savePasses(state.passes)
    return rec
  }

  return {
    state,
    purchaseTicket
  }
}
