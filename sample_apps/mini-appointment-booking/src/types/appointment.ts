export interface ClinicService {
  id: string
  name: string
  category: string
  specialist: string
  clinicName: string
  duration: string
  price: number
  deposit: number
  rating: number
  avatar: string
  description: string
}

export interface AppointmentRecord {
  id: string
  appointmentCode: string
  service: ClinicService
  patientName: string
  patientPhone: string
  appointmentDate: string
  timeSlot: string
  depositPaid: number
  status: 'CONFIRMED' | 'COMPLETED' | 'CANCELLED'
  qrValue: string
}
