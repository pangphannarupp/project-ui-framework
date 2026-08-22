import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'CinePass Cinema',
    guestUser: 'MOVIE PASS GUEST',
    searchPlaceholder: 'Search movies, genres, cast...',
    nowShowing: 'Now Showing',
    comingSoon: 'Coming Soon',
    selectSeats: 'Select Seats',
    reviewAndPay: 'Review & Pay',
    checkoutTitle: 'Cinema Ticket Checkout',
    exitTitle: 'Exit CinePass',
    exitMessage: 'Are you sure you want to exit cinema booking?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Movie Tickets Confirmed!',
    paymentReceived: 'Digital E-Ticket Issued!',
    bookingCode: 'Booking Code',
    newBooking: 'Book Another Movie',
    myPasses: 'My Movie Passes',
    seats: 'Seats',
    screen: 'CINEMA SCREEN',
    available: 'Available',
    selected: 'Selected',
    booked: 'Booked',
    snacks: 'Popcorn & Drinks Combos',
    total: 'Total',
    subtotal: 'Subtotal',
    vatTax: 'Service Tax (5%)',
    grandTotal: 'Grand Total',
    pay: 'Pay Now',
    today: 'Today',
    tomorrow: 'Tomorrow',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'រោងភាពយន្ត CinePass',
    guestUser: 'ភ្ញៀវភាពយន្ត',
    searchPlaceholder: 'ស្វែងរកភាពយន្ត ឬតួសម្តែង...',
    nowShowing: 'កំពុងចាក់បញ្ចាំង',
    comingSoon: 'ឆាប់ៗនេះ',
    selectSeats: 'ជ្រើសរើសកៅអី',
    reviewAndPay: 'ពិនិត្យ & បង់ប្រាក់',
    checkoutTitle: 'ការទូទាត់សំបុត្រកុន',
    exitTitle: 'ចាកចេញពី CinePass',
    exitMessage: 'តើអ្នកចង់ចាកចេញពីការកក់សំបុត្រកុនមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ការកក់សំបុត្រកុនជោគជ័យ!',
    paymentReceived: 'សំបុត្រឌីជីថលត្រូវបានចេញ!',
    bookingCode: 'លេខកូដកក់',
    newBooking: 'កក់រឿងថ្មី',
    myPasses: 'សំបុត្រកុនរបស់ខ្ញុំ',
    seats: 'កៅអី',
    screen: 'អេក្រង់បញ្ចាំងភាពយន្ត',
    available: 'ទំនេរ',
    selected: 'បានជ្រើសរើស',
    booked: 'មានអ្នកកក់ហើយ',
    snacks: 'ពោតលីង & ភេសជ្ជៈ',
    total: 'សរុប',
    subtotal: 'សរុបរង',
    vatTax: 'ពន្ធសេវាកម្ម (5%)',
    grandTotal: 'ទឹកប្រាក់សរុប',
    pay: 'បង់ប្រាក់ឥឡូវនេះ',
    today: 'ថ្ងៃនេះ',
    tomorrow: 'ថ្ងៃស្អែក',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '시네패스 영화관',
    guestUser: '영화 관람 게스트',
    searchPlaceholder: '영화, 장르, 배우 검색...',
    nowShowing: '현재 상영작',
    comingSoon: '개봉 예정작',
    selectSeats: '좌석 선택',
    reviewAndPay: '예매 확인 및 결제',
    checkoutTitle: '영화 예매 결제',
    exitTitle: '시네패스 종료',
    exitMessage: '영화 예매를 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '영화 예매 완료!',
    paymentReceived: '모바일 티켓이 발권되었습니다!',
    bookingCode: '예매 번호',
    newBooking: '다른 영화 예매하기',
    myPasses: '내 영화 티켓',
    seats: '좌석',
    screen: '스크린',
    available: '예매가능',
    selected: '선택좌석',
    booked: '예매완료',
    snacks: '팝콘 & 음료 콤보',
    total: '합계',
    subtotal: '소계',
    vatTax: '서비스 세금 (5%)',
    grandTotal: '총 결제금액',
    pay: '결제하기',
    today: '오늘',
    tomorrow: '내일',
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
    try { localStorage.setItem('cine_lang', lang) } catch (e) {}
  }

  try {
    const s = localStorage.getItem('cine_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
