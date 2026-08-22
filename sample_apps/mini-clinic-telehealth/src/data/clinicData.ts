import type { DoctorProfile } from '../types/clinic'

export const DOCTORS_LIST: DoctorProfile[] = [
  {
    id: 'doc-sarah',
    name: { en: 'Dr. Sarah Chen, MD', km: 'វេជ្ជបណ្ឌិត សារ៉ា ឆេន', ko: '사라 첸 박사' },
    specialty: { en: 'Neurology & Headache Specialist', km: 'ឯកទេសប្រព័ន្ធប្រសាទ និងឈឺក្បាល', ko: '신경과 및 두통 전문의' },
    avatarUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&auto=format&fit=crop&q=80',
    rating: 4.9,
    reviewsCount: 142,
    consultFee: 35.00,
    nextAvailableTime: 'Today 10:30 AM',
    hospital: 'St. Jude Telehealth Pavilion',
    bio: 'Specialist in migraine management, cognitive fatigue, and neuro-teleconsultation.',
    focusBodyZone: 'HEAD'
  },
  {
    id: 'doc-marcus',
    name: { en: 'Dr. Marcus Vance, MD', km: 'វេជ្ជបណ្ឌិត ម៉ាកូស វ៉ាន', ko: '마커스 밴스 박사' },
    specialty: { en: 'Cardiology & Respiratory Medicine', km: 'ឯកទេសបេះដូង និងផ្លូវដង្ហើម', ko: '심장내과 및 호흡기 전문의' },
    avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&auto=format&fit=crop&q=80',
    rating: 4.8,
    reviewsCount: 98,
    consultFee: 45.00,
    nextAvailableTime: 'Today 11:15 AM',
    hospital: 'Apex Cardio Care Network',
    bio: 'Pioneer in remote blood pressure monitoring and heart rhythm diagnostics.',
    focusBodyZone: 'CHEST'
  },
  {
    id: 'doc-elena',
    name: { en: 'Dr. Elena Rostova, MD', km: 'វេជ្ជបណ្ឌិត អេលេណា រ៉ូស្តូវ៉ា', ko: '엘레나 로스토바 박사' },
    specialty: { en: 'Dermatology & Skin Barrier Care', km: 'ឯកទេសសើស្បែក និងកែសម្ផស្ស', ko: '피부과 및 피부 장벽 전문의' },
    avatarUrl: 'https://images.unsplash.com/photo-1594824813591-678c430b809a?w=400&auto=format&fit=crop&q=80',
    rating: 5.0,
    reviewsCount: 210,
    consultFee: 30.00,
    nextAvailableTime: 'Today 01:00 PM',
    hospital: 'PureDerm Aesthetic Clinic',
    bio: 'Expert in clinical teledermatology, eczema triggers, and acne management.',
    focusBodyZone: 'SKIN'
  },
  {
    id: 'doc-kenji',
    name: { en: 'Dr. Kenji Sato, PT/MD', km: 'វេជ្ជបណ្ឌិត ខេនជី សាតូ', ko: '사토 켄지 박사' },
    specialty: { en: 'Orthopedics & Joint Recovery', km: 'ឯកទេសឆ្អឹង និងសន្លាក់', ko: '정형외과 및 관절 재활 전문의' },
    avatarUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400&auto=format&fit=crop&q=80',
    rating: 4.9,
    reviewsCount: 84,
    consultFee: 40.00,
    nextAvailableTime: 'Tomorrow 09:00 AM',
    hospital: 'Kyoto Sports Medical Center',
    bio: 'Specialist in biomechanics, spine ergonomics, and sports injury rehabilitation.',
    focusBodyZone: 'JOINTS'
  }
]
