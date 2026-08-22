export interface DoctorProfile {
  id: string
  name: { en: string; km: string; ko: string }
  specialty: { en: string; km: string; ko: string }
  avatarUrl: string
  rating: number
  reviewsCount: number
  consultFee: number
  nextAvailableTime: string
  hospital: string
  bio: string
  focusBodyZone: 'HEAD' | 'CHEST' | 'JOINTS' | 'SKIN'
}

export interface MedicalIntake {
  symptomNotes: string
  bodyZone: 'HEAD' | 'CHEST' | 'JOINTS' | 'SKIN'
  urgencyLevel: 'LOW' | 'NORMAL' | 'URGENT'
  selectedDate: string
  selectedTimeSlot: string
}

export interface TelehealthAppointment {
  id: string
  orderNumber: string
  doctor: DoctorProfile
  intake: MedicalIntake
  totalFee: number
  status: 'CONFIRMED' | 'IN_ROOM' | 'COMPLETED'
  createdAt: string
  roomLink: string
  prescriptionNotes: string
}
