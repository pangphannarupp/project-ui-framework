import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Ultra Gloss Express Car Wash',
    guestUser: 'CAR DRIVER',
    selectTier: 'Wash Programs & Polish Tiers',
    vehicleDetails: 'Vehicle Identification',
    licensePlate: 'License Plate Number',
    carModel: 'Vehicle Make / Model',
    reviewAndPay: 'Authorize & Queue Vehicle',
    pay: 'Pay & Enter Conveyor Bay',
    checkoutTitle: 'Car Wash Order Summary',
    exitTitle: 'Exit Car Wash App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Bay Gate Unlocked!',
    paymentReceived: 'Conveyor slot confirmed! Drive up to Bay 01 scanner.',
    ticketCode: 'Wash Kiosk Pass',
    statusTitle: 'Live Conveyor Telemetry',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'លាងរថយន្តស្វ័យប្រវត្តិកម្រិតខ្ពស់',
    guestUser: 'អ្នកបើកបរ',
    selectTier: 'កញ្ចប់សេវាលាងសម្អាត & ប៉ូលា',
    vehicleDetails: 'ព័ត៌មានរថយន្ត',
    licensePlate: 'ស្លាកលេខរថយន្ត',
    carModel: 'ម៉ាករថយន្ត / ម៉ូដែល',
    reviewAndPay: 'អនុញ្ញាត & ចូលជួរលាង',
    pay: 'បង់ប្រាក់ & បើកទ្វារបន្ទប់លាង',
    checkoutTitle: 'សង្ខេបការទូទាត់លាងរថយន្ត',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ទ្វារបន្ទប់លាងបានបើក!',
    paymentReceived: 'កន្លែងលាងរបស់អ្នកបានរួចរាល់! សូមបើកចូលបន្ទប់លាងលេខ 01។',
    ticketCode: 'សំបុត្រស្កេនលាងរថយន្ត',
    statusTitle: 'ស្ថានភាពលាងរថយន្តផ្ទាល់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '울트라 글로스 노터치 자동세차',
    guestUser: '운전자 회원',
    selectTier: '세차 코스 & 광택 프로그램',
    vehicleDetails: '차량 정보 입력',
    licensePlate: '차량 번호',
    carModel: '차종 / 모델명',
    reviewAndPay: '결제 및 진입 대기',
    pay: '결제 및 세차 베이 진입',
    checkoutTitle: '세차 코스 결제',
    exitTitle: '세차 앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '세차 베이 진입 승인!',
    paymentReceived: '세차 베이 1번 차단기가 열립니다. 천천히 진입해 주세요!',
    ticketCode: '세차 키오스크 바코드',
    statusTitle: '실시간 세차 진행 현황',
    selectLanguage: '언어를 선택해 주세요',
    languageSubtitle: '영어, 한국어, 크메르어 중 선택'
  }
}

export const supportedLanguages = [
  { code: 'en' as LanguageCode, name: 'English', subname: 'English (US)', flag: '🇺🇸' },
  { code: 'km' as LanguageCode, name: 'ភាសាខ្មែរ', subname: 'Khmer', flag: '🇰🇭' },
  { code: 'ko' as LanguageCode, name: '한국어', subname: 'Korean', flag: '🇰🇷' }
]

const currentLanguage = ref<LanguageCode>('en')

export function useI18n() {
  const setLanguage = (lang: LanguageCode) => {
    currentLanguage.value = lang
    try { localStorage.setItem('wash_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('wash_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
