import { reactive } from 'vue'
import { WashTier, CarWashRecord } from '../types/wash'
import { WASH_TIERS } from '../data/washData'

const STORAGE_KEY = 'mini_car_wash_records_v1'

function loadRecords(): CarWashRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveRecords(list: CarWashRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedTier: WASH_TIERS[1] as WashTier,
  plateNumber: '2BB-8899',
  vehicleModel: 'Porsche Taycan 4S',
  records: loadRecords(),
  currentRecord: null as CarWashRecord | null
})

export function useWashStore() {
  const startWashOrder = () => {
    const id = 'WASH-' + Math.floor(100 + Math.random() * 900)
    const rec: CarWashRecord = {
      id,
      washTicket: `BAY01-${Math.floor(1000 + Math.random() * 9000)}`,
      vehiclePlate: state.plateNumber,
      vehicleModel: state.vehicleModel,
      tier: state.selectedTier,
      bayAssigned: 'Express Bay 01',
      totalPaid: state.selectedTier.price,
      status: 'IN_WASH_BAY',
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      qrValue: `${id}|${state.plateNumber}|BAY01_GATE_OPEN|${state.selectedTier.price}USD`
    }
    state.records.unshift(rec)
    state.currentRecord = rec
    saveRecords(state.records)
    return rec
  }

  return {
    state,
    startWashOrder
  }
}
