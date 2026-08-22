import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'The Grand Champagne Boutique Hotel',
    guestUser: 'DISTINGUISHED GUEST',
    suites: 'Boutique Suites & Villas',
    bookSuite: 'Reserve Stay',
    checkInDate: 'Check-In Date',
    checkOutDate: 'Check-Out Date',
    reviewAndPay: 'Guarantee Reservation & Digital Key',
    pay: 'Pay & Issue Mobile Key',
    checkoutTitle: 'Suite Booking Summary',
    exitTitle: 'Exit Hotel App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Keyless Check-In Ready!',
    paymentReceived: 'Your digital room key has been activated for Mobile Door Unlock!',
    roomNumber: 'Assigned Suite',
    myBookings: 'My Stays & Mobile Key',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'សណ្ឋាគារ ហ្គ្រេន សំប៉ាញ ប៊ូទិក',
    guestUser: 'ភ្ញៀវកិត្តិយស',
    suites: 'បន្ទប់ស្នាក់នៅប្រណិត',
    bookSuite: 'កក់បន្ទប់',
    checkInDate: 'ថ្ងៃចូលស្នាក់នៅ',
    checkOutDate: 'ថ្ងៃចាកចេញ',
    reviewAndPay: 'ធានាការកក់ & ទទួលសោរទូរស័ព្ទ',
    pay: 'បង់ប្រាក់ & បើកសោរបន្ទប់',
    checkoutTitle: 'សង្ខេបការកក់បន្ទប់',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'សោរឌីជីថលរួចរាល់!',
    paymentReceived: 'សោរបន្ទប់តាមទូរស័ព្ទបានបើកដំណើរការរួចរាល់!',
    roomNumber: 'លេខបន្ទប់',
    myBookings: 'ប្រវត្តិកក់ & សោរបន្ទប់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '더 그랜드 샴페인 부티크 호텔',
    guestUser: '귀빈 고객님',
    suites: '부티크 스위트 & 객실',
    bookSuite: '객실 예약하기',
    checkInDate: '체크인 날짜',
    checkOutDate: '체크아웃 날짜',
    reviewAndPay: '예약 확정 및 모바일 키 발권',
    pay: '결제 및 스마트키 발급',
    checkoutTitle: '객실 예약 결제',
    exitTitle: '앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '모바일 키 발권 완료!',
    paymentReceived: '스마트 도어락을 열 수 있는 모바일 객실 키가 활성화되었습니다!',
    roomNumber: '배정 객실',
    myBookings: '내 예약 및 모바일 키',
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
    try { localStorage.setItem('hotel_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('hotel_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
