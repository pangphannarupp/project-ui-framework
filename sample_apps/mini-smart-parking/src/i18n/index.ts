import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart Parking Pass',
    guestUser: 'DRIVER GUEST',
    plateSearch: 'Enter License Plate (e.g. 2BK-8899)',
    search: 'Search Plate',
    activeParking: 'Active Parking Session',
    duration: 'Duration',
    hourlyRate: 'Rate',
    location: 'Lot Location',
    reviewAndPay: 'Pay & Exit Gate',
    pay: 'Pay Parking Fee',
    checkoutTitle: 'Parking Fee Settlement',
    exitTitle: 'Exit Parking App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Parking Fee Settled!',
    paymentReceived: 'Barrier gate will open automatically on exit!',
    barrierPass: 'Barrier Exit Pass',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'ចំណតរថយន្តឆ្លាតវៃ',
    guestUser: 'អ្នកបើកបរ',
    plateSearch: 'បញ្ចូលស្លាកលេខរថយន្ត (ឧ. 2BK-8899)',
    search: 'ស្វែងរកស្លាកលេខ',
    activeParking: 'ព័ត៌មានចំណតបច្ចុប្បន្ន',
    duration: 'រយៈពេលចត',
    hourlyRate: 'តម្លៃក្នុង១ម៉ោង',
    location: 'ទីតាំងចំណត',
    reviewAndPay: 'បង់ប្រាក់ & បើកទ្វារចេញ',
    pay: 'បង់ថ្លៃចំណត',
    checkoutTitle: 'ការទូទាត់ថ្លៃចំណត',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'បានទូទាត់ថ្លៃចំណតរួចរាល់!',
    paymentReceived: 'របាំងទ្វារនឹងបើកដោយស្វ័យប្រវត្តពេលចេញ!',
    barrierPass: 'សំបុត្រចេញទ្វាររបាំង',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 주차 패스',
    guestUser: '운전자 게스트',
    plateSearch: '차량 번호 입력 (예: 2BK-8899)',
    search: '차량 조회',
    activeParking: '현재 주차 정보',
    duration: '주차 시간',
    hourlyRate: '시간당 요금',
    location: '주차장 위치',
    reviewAndPay: '정산 및 출차',
    pay: '주차 요금 정산',
    checkoutTitle: '주차비 결제',
    exitTitle: '주차 앱 종료',
    exitMessage: '정산을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '주차 요금 정산 완료!',
    paymentReceived: '출차 시 차단기가 자동으로 열립니다!',
    barrierPass: '출차 바코드 패스',
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
    try { localStorage.setItem('park_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('park_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
