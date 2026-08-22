import { reactive } from 'vue'
import { GymPass, GymMembershipRecord } from '../types/gym'
import { GYM_PASSES } from '../data/gymData'

const STORAGE_KEY = 'mini_gym_passes_v1'

function loadPasses(): GymMembershipRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function savePasses(list: GymMembershipRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedPass: GYM_PASSES[0] as GymPass,
  passes: loadPasses(),
  currentPass: null as GymMembershipRecord | null
})

export function useGymStore() {
  const purchasePass = () => {
    const id = 'GYM-' + Math.floor(100 + Math.random() * 900)
    const rec: GymMembershipRecord = {
      id,
      passCode: `FIT-${Math.floor(100000 + Math.random() * 900000)}`,
      memberId: `MBR-${Math.floor(1000 + Math.random() * 9000)}`,
      planName: state.selectedPass.title,
      validUntil: 'Valid for ' + state.selectedPass.validity,
      totalPaid: state.selectedPass.price,
      status: 'ACTIVE',
      turnstileQr: `${id}|${state.selectedPass.title}|ACTIVE_TURNSTILE_OPEN`
    }
    state.passes.unshift(rec)
    state.currentPass = rec
    savePasses(state.passes)
    return rec
  }

  return {
    state,
    purchasePass
  }
}
