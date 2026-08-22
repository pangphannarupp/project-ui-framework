import { ClinicService } from '../types/appointment'

export const CLINIC_SERVICES: ClinicService[] = [
  {
    id: 'srv-1',
    name: 'Teeth Scaling & Deep Clean Laser',
    category: 'Dental',
    specialist: 'Dr. Chantrea Ly (DDS)',
    clinicName: 'Prestige Dental & Implant Center',
    duration: '45 mins',
    price: 35.00,
    deposit: 10.00,
    rating: 4.9,
    avatar: '🦷',
    description: 'Painless ultrasonic plaque scaling followed by fluoride enamel polish.'
  },
  {
    id: 'srv-2',
    name: 'Hydra-Glow Facial Rejuvenation',
    category: 'Aesthetic / Spa',
    specialist: 'Therapist Sopheap',
    clinicName: 'Aura Skin & Laser Clinic',
    duration: '60 mins',
    price: 50.00,
    deposit: 15.00,
    rating: 4.8,
    avatar: '💆‍♀️',
    description: 'Deep pore vacuum suction, AHA/BHA exfoliation, and cold-hammer peptide infusion.'
  },
  {
    id: 'srv-3',
    name: 'General Health & Blood Chemistry Checkup',
    category: 'Medical',
    specialist: 'Dr. Vatanak Sam',
    clinicName: 'Royal Phnom Penh Polyclinic',
    duration: '30 mins',
    price: 60.00,
    deposit: 20.00,
    rating: 4.9,
    avatar: '🩺',
    description: 'Complete blood count, glucose, liver/kidney profiles and consultation.'
  }
]

export const TIME_SLOTS = ['09:00 AM', '10:30 AM', '01:30 PM', '03:00 PM', '04:30 PM', '06:00 PM']
