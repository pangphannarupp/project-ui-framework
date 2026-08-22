import { GymPass, GymClassSession } from '../types/gym'

export const GYM_PASSES: GymPass[] = [
  {
    id: 'pass-day',
    title: 'Single Day Club Pass',
    subtitle: 'Full facility access for 24h',
    price: 8.00,
    validity: '1 Day',
    accessType: 'Weights, Cardio & Sauna',
    features: ['Locker + Towel service', 'Cold plunge & Finnish sauna', 'Unlimited gym floor access'],
    badge: 'Popular'
  },
  {
    id: 'pass-week',
    title: '7-Day Unlimited Pass',
    subtitle: 'Hit peak performance all week',
    price: 32.00,
    validity: '7 Days',
    accessType: 'All Classes + Recovery Zone',
    features: ['All HIIT & Spin classes included', 'Smart biometric locker sync', 'Recovery shake voucher'],
    badge: 'Best Value'
  },
  {
    id: 'pass-month',
    title: 'Black Diamond Monthly',
    subtitle: 'VIP Unlimited Fitness & Spa',
    price: 75.00,
    validity: '30 Days',
    accessType: 'All-Inclusive 24/7 Access',
    features: ['1x PT Personal Coaching session', 'Guest pass included (2x)', 'Priority studio reservations'],
    badge: 'VIP Tier'
  }
]

export const TODAY_CLASSES: GymClassSession[] = [
  {
    id: 'cls-1',
    name: 'HYROX Strength & Engine',
    instructor: 'Coach Alex V.',
    time: '07:00 AM',
    duration: '50 mins',
    intensity: 'EXTREME',
    spotsLeft: 4,
    totalSpots: 16,
    room: 'Studio A (Main Turf)'
  },
  {
    id: 'cls-2',
    name: 'Neon Rhythm Cycle & Sprint',
    instructor: 'Trainer Maya',
    time: '12:15 PM',
    duration: '45 mins',
    intensity: 'HIGH',
    spotsLeft: 8,
    totalSpots: 20,
    room: 'Studio C (Sound Stage)'
  },
  {
    id: 'cls-3',
    name: 'Breathwork & Ice Plunge',
    instructor: 'Dr. Sean Miller',
    time: '06:00 PM',
    duration: '40 mins',
    intensity: 'MEDIUM',
    spotsLeft: 2,
    totalSpots: 12,
    room: 'Recovery Oasis'
  }
]
