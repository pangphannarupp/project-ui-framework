import { reactive, computed } from 'vue'
import type { DoctorProfile, MedicalIntake, TelehealthAppointment } from '../types/clinic'
import { DOCTORS_LIST } from '../data/clinicData'

interface ClinicState {
  selectedDoctor: DoctorProfile
  intake: MedicalIntake
  appointments: TelehealthAppointment[]
  latestAppointment: TelehealthAppointment | null
  patientName: string
  patientPhone: string
}

const state = reactive<ClinicState>({
  selectedDoctor: DOCTORS_LIST[0],
  intake: {
    symptomNotes: 'Persistent migraine with light sensitivity for 2 days.',
    bodyZone: 'HEAD',
    urgencyLevel: 'NORMAL',
    selectedDate: '2026-08-25',
    selectedTimeSlot: '10:30 AM'
  },
  appointments: [],
  latestAppointment: null,
  patientName: 'Alex Morgan',
  patientPhone: '+855 12 345 678'
})

export function useClinicStore() {
  const totalCost = computed(() => {
    let fee = state.selectedDoctor.consultFee
    if (state.intake.urgencyLevel === 'URGENT') fee += 15.00
    return fee
  })

  const confirmBooking = () => {
    const appt: TelehealthAppointment = {
      id: 'appt-' + Date.now(),
      orderNumber: 'RX-' + Math.floor(100000 + Math.random() * 900000),
      doctor: state.selectedDoctor,
      intake: { ...state.intake },
      totalFee: totalCost.value,
      status: 'CONFIRMED',
      createdAt: new Date().toISOString(),
      roomLink: 'https://telehealth.swissclinic.ch/room/' + Math.random().toString(36).substring(7),
      prescriptionNotes: 'Pending live doctor diagnosis during call'
    }
    state.appointments.unshift(appt)
    state.latestAppointment = appt
    return appt
  }

  return { state, totalCost, confirmBooking }
}
