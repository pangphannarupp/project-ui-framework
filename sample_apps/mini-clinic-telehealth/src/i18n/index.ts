export const translations = {
  en: {
    appName: 'SWISS TELEHEALTH CLINIC',
    slogan: 'Instant Video Medical Consultations & e-Prescription',
    searchPlaceholder: 'Search doctor, symptoms, or hospital...',
    selectLanguage: 'Select Language',
    myPasses: 'My Appointments & e-Rx',
    noPasses: 'No active medical consultations found',
    bookFirst: 'Consult a Doctor Now',
    exitTitle: 'Exit Telehealth Clinic?',
    exitMessage: 'Your selected intake details will be preserved.',
    yesExit: 'Exit',
    stay: 'Stay in Clinic',
    bodyZoneTriage: 'Interactive Anatomy Triage',
    consultNow: 'Schedule Video Consult',
    bookingSummary: 'Consultation Summary',
    patientIntake: 'Patient Health Intake',
    totalPayable: 'Consultation Fee Total',
    confirmAndPay: 'Pay & Enter Waiting Room',
    paymentSuccess: 'Appointment Confirmed & Room Ready',
    roomReady: 'Secure Video Room Initialized',
    enterRoom: 'Join Video Consultation 🩺',
    orderNumber: 'Intake Reference #'
  },
  km: {
    appName: 'គ្លីនិកសុខភាពតាមទូរស័ព្ទ',
    slogan: 'ពិគ្រោះយោបល់ជំងឺតាមវីដេអូ និងវេជ្ជបញ្ជាឌីជីថល',
    searchPlaceholder: 'ស្វែងរកវេជ្ជបណ្ឌិត ឬរោគសញ្ញា...',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'ការណាត់ជួប និងវេជ្ជបញ្ជា',
    noPasses: 'មិនទាន់មានការណាត់ជួបនៅឡើយទេ',
    bookFirst: 'កក់ការពិគ្រោះឥឡូវនេះ',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ព័ត៌មានរោគសញ្ញារបស់អ្នកនឹងត្រូវបានរក្សាទុក។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    bodyZoneTriage: 'រោគសញ្ញាតាមកាយវិភាគវិទ្យា',
    consultNow: 'កក់ការពិគ្រោះជំងឺ',
    bookingSummary: 'សង្ខេបការណាត់ជួប',
    patientIntake: 'ព័ត៌មានរោគសញ្ញាអ្នកជំងឺ',
    totalPayable: 'តម្លៃសេវាពិគ្រោះសរុប',
    confirmAndPay: 'ទូទាត់ និងចូលបន្ទប់រង់ចាំ',
    paymentSuccess: 'ការកក់ទទួលបានជោគជ័យ',
    roomReady: 'បន្ទប់វីដេអូមានសុវត្ថិភាពរួចរាល់',
    enterRoom: 'ចូលរួមការពិគ្រោះតាមវីដេអូ 🩺',
    orderNumber: 'លេខសម្គាល់ការកក់'
  },
  ko: {
    appName: '스위스 원격 진료 클리닉',
    slogan: '실시간 영상 진료 및 모바일 전자 처방전',
    searchPlaceholder: '의사, 증상 또는 병원 검색...',
    selectLanguage: '언어 선택',
    myPasses: '내 진료 예약 및 처방전',
    noPasses: '진행 중인 진료 내역이 없습니다',
    bookFirst: '전문의 진료 예약하기',
    exitTitle: '클리닉을 종료하시겠습니까?',
    exitMessage: '작성 중인 문진표 정보가 보존됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    bodyZoneTriage: '스마트 신체 부위별 문진',
    consultNow: '영상 진료 예약하기',
    bookingSummary: '진료 예약 요약',
    patientIntake: '환자 사전 문진표',
    totalPayable: '진료비 총 결제액',
    confirmAndPay: '결제 및 대기실 입장',
    paymentSuccess: '예약 완료 및 대기실 준비 완료',
    roomReady: '보안 영상 진료실 접속 준비 완료',
    enterRoom: '영상 진료실 입장하기 🩺',
    orderNumber: '문진 접수 번호'
  }
}

import { ref, computed } from 'vue'

export type Language = 'en' | 'km' | 'ko'
const currentLanguage = ref<Language>('en')

export function useI18n() {
  const t = computed(() => translations[currentLanguage.value])
  const setLanguage = (lang: Language) => {
    currentLanguage.value = lang
  }
  const supportedLanguages = [
    { code: 'en' as Language, name: 'English', flag: '🇺🇸' },
    { code: 'km' as Language, name: 'ភាសាខ្មែរ', flag: '🇰🇭' },
    { code: 'ko' as Language, name: '한국어', flag: '🇰🇷' }
  ]
  const currentLangObj = computed(() => {
    return supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0]
  })
  return { t, currentLanguage, setLanguage, supportedLanguages, currentLangObj }
}
