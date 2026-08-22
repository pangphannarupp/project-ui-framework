import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Express Bus & Ferry',
    guestUser: 'PASSENGER GUEST',
    fromCity: 'From',
    toCity: 'To',
    travelDate: 'Date',
    selectSeats: 'Choose Bunk / Seat',
    reviewAndPay: 'Review & Pay',
    checkoutTitle: 'Bus Ticket Checkout',
    exitTitle: 'Exit Bus App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Boarding Pass Issued!',
    paymentReceived: 'Your transit pass is ready for boarding!',
    ticketCode: 'Ticket Ref',
    myPasses: 'My Boarding Passes',
    seats: 'Seats',
    deckLower: 'Lower Deck',
    deckUpper: 'Upper Deck',
    total: 'Total',
    subtotal: 'Subtotal',
    vatTax: 'Insurance & Tax',
    grandTotal: 'Grand Total',
    pay: 'Pay Now',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'សំបុត្ររថយន្តក្រុង & ទូកល្បឿនលឿន',
    guestUser: 'អ្នកដំណើរ',
    fromCity: 'ចេញពី',
    toCity: 'ទៅកាន់',
    travelDate: 'កាលបរិច្ឆេទ',
    selectSeats: 'ជ្រើសរើសកៅអី / គ្រែដេក',
    reviewAndPay: 'ពិនិត្យ & បង់ប្រាក់',
    checkoutTitle: 'ការទូទាត់សំបុត្ររថយន្ត',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'សំបុត្រជិះបានចេញរួចរាល់!',
    paymentReceived: 'សំបុត្រឌីជីថលរបស់អ្នករួចរាល់សម្រាប់ឡើងជិះ!',
    ticketCode: 'លេខសំបុត្រ',
    myPasses: 'សំបុត្រជិះរបស់ខ្ញុំ',
    seats: 'កៅអី',
    deckLower: 'ជាន់ក្រោម',
    deckUpper: 'ជាន់លើ',
    total: 'សរុប',
    subtotal: 'សរុបរង',
    vatTax: 'ធានារ៉ាប់រង & ពន្ធ',
    grandTotal: 'ទឹកប្រាក់សរុប',
    pay: 'បង់ប្រាក់ឥឡូវនេះ',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '익스프레스 버스 & 페리',
    guestUser: '승객 게스트',
    fromCity: '출발지',
    toCity: '도착지',
    travelDate: '탑승일',
    selectSeats: '좌석 / 침대칸 선택',
    reviewAndPay: '예약 확인 및 결제',
    checkoutTitle: '버스 티켓 결제',
    exitTitle: '버스 앱 종료',
    exitMessage: '예약을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '탑승권 발권 완료!',
    paymentReceived: '모바일 탑승권이 준비되었습니다!',
    ticketCode: '티켓 번호',
    myPasses: '내 탑승권',
    seats: '좌석',
    deckLower: '1층 하부덱',
    deckUpper: '2층 상부덱',
    total: '합계',
    subtotal: '소계',
    vatTax: '보험 및 세금',
    grandTotal: '총 결제금액',
    pay: '결제하기',
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
    try { localStorage.setItem('bus_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('bus_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
