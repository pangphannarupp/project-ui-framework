import { reactive } from 'vue'
import { ClinicService, AppointmentRecord } from '../types/appointment'
import { CLINIC_SERVICES, TIME_SLOTS } from '../data/appointmentData'

const STORAGE_KEY = 'mini_appointments_v1'

function loadAppointments(): AppointmentRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveAppointments(list: AppointmentRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedService: CLINIC_SERVICES[0] as ClinicService,
  selectedDate: new Date().toISOString().split('T')[0],
  selectedSlot: TIME_SLOTS[1],
  patientName: 'Sokheng Kong',
  patientPhone: '012 888 999',
  appointments: loadAppointments(),
  currentAppointment: null as AppointmentRecord | null
})

export function useAppointmentStore() {
  const createAppointment = () => {
    const id = 'APT-' + Math.floor(100 + Math.random() * 900)
    const apt: AppointmentRecord = {
      id,
      appointmentCode: 'CLINIC-' + Math.floor(100000 + Math.random() * 900000),
      service: state.selectedService,
      patientName: state.patientName,
      patientPhone: state.patientPhone,
      appointmentDate: state.selectedDate,
      timeSlot: state.selectedSlot,
      depositPaid: state.selectedService.deposit,
      status: 'CONFIRMED',
      qrValue: `${id}|${state.patientName}|${state.selectedService.name}|${state.selectedDate}_${state.selectedSlot}`
    }
    state.appointments.unshift(apt)
    state.currentAppointment = apt
    saveAppointments(state.appointments)
    return apt
  }

  return {
    state,
    createAppointment
  }
}
