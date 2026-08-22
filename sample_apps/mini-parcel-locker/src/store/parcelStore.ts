import { reactive } from 'vue'
import { ParcelLocker, ParcelActionRecord } from '../types/parcel'
import { PARCEL_LOCKERS } from '../data/parcelData'

const STORAGE_KEY = 'mini_parcel_lockers_v1'

function loadActions(): ParcelActionRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveActions(list: ParcelActionRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedLocker: PARCEL_LOCKERS[0] as ParcelLocker,
  senderPhone: '012 888 999',
  recipientPhone: '098 777 666',
  actions: loadActions(),
  currentAction: null as ParcelActionRecord | null
})

export function useParcelStore() {
  const rentLocker = () => {
    const id = 'LOCKER-' + Math.floor(100 + Math.random() * 900)
    const pin = String(Math.floor(1000 + Math.random() * 9000))
    const rec: ParcelActionRecord = {
      id,
      pinCode: pin,
      lockerBay: state.selectedLocker.bayNumber,
      size: state.selectedLocker.size,
      actionType: 'DROP_OFF',
      senderPhone: state.senderPhone,
      recipientPhone: state.recipientPhone,
      totalPaid: state.selectedLocker.price,
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      doorStatus: 'UNLOCKED',
      qrValue: `${id}|${state.selectedLocker.bayNumber}|PIN_${pin}|DOOR_UNLOCKED`
    }
    state.actions.unshift(rec)
    state.currentAction = rec
    saveActions(state.actions)
    return rec
  }

  return {
    state,
    rentLocker
  }
}
