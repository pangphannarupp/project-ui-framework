import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export interface TranslationDictionary {
  appName: string
  visitorGuest: string
  searchPlaceholder: string
  items: string
  total: string
  subtotal: string
  vatTax: string
  grandTotal: string
  reviewAndPay: string
  pay: string
  orderItems: string
  clearAll: string
  emptyCart: string
  browseTickets: string
  checkoutTitle: string
  exitTitle: string
  exitMessage: string
  yesExit: string
  stay: string
  paymentSuccessTitle: string
  paymentFailedTitle: string
  paymentReceived: string
  orderTotal: string
  bookingCode: string
  newBooking: string
  tryAgain: string
  close: string
  selectLanguage: string
  languageSubtitle: string
  today: string
  tomorrow: string
  weekend: string
  visitDate: string
  timeSlot: string
  specialAddons: string
  myPasses: string
  zooMap: string
  featuredAnimals: string
  feedingShowTimes: string
  allTickets: string
  myTickets: string
  gateQrCode: string
  scanInstructions: string
  categories: {
    All: string
    Standard: string
    Combo: string
    VIP: string
    Night: string
  }
}

export const translations: Record<LanguageCode, TranslationDictionary> = {
  en: {
    appName: 'WildSafari Mini Zoo',
    visitorGuest: 'VISITOR GUEST',
    searchPlaceholder: 'Search tickets, animals, shows...',
    items: 'tickets',
    total: 'Total',
    subtotal: 'Subtotal',
    vatTax: 'VAT Tax (10%)',
    grandTotal: 'Grand Total',
    reviewAndPay: 'Review & Pay',
    pay: 'Pay',
    orderItems: 'Selected Tickets & Add-ons',
    clearAll: 'Clear all',
    emptyCart: 'No tickets selected. Please choose tickets first.',
    browseTickets: 'Browse Tickets',
    checkoutTitle: 'Ticket Checkout',
    exitTitle: 'Exit Mini Zoo App',
    exitMessage: 'Are you sure you want to exit the app?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Booking Confirmed!',
    paymentFailedTitle: 'Payment Failed',
    paymentReceived: 'E-Ticket Issued Successfully!',
    orderTotal: 'Total Paid',
    bookingCode: 'Booking Code',
    newBooking: 'New Booking',
    tryAgain: 'Try Again',
    close: 'Close',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean to use in WildSafari',
    today: 'Today',
    tomorrow: 'Tomorrow',
    weekend: 'This Weekend',
    visitDate: 'Visit Date',
    timeSlot: 'Entry Time Slot',
    specialAddons: 'Special Add-ons',
    myPasses: 'My Passes',
    zooMap: 'Park Map & Attractions',
    featuredAnimals: 'Featured Wildlife',
    feedingShowTimes: 'Feeding Shows & Presentations',
    allTickets: 'All Tickets',
    myTickets: 'My Passes Wallet',
    gateQrCode: 'Turnstile Gate QR',
    scanInstructions: 'Present this QR code at the main park turnstile for instant admission.',
    categories: {
      All: 'All Passes',
      Standard: 'Standard',
      Combo: 'Combos & Family',
      VIP: 'VIP Safari',
      Night: 'Night Safari'
    }
  },
  km: {
    appName: 'សួនសត្វ WildSafari',
    visitorGuest: 'ភ្ញៀវទេសចរ',
    searchPlaceholder: 'ស្វែងរកសំបុត្រ សត្វ ឬកម្មវិធីសម្តែង...',
    items: 'សំបុត្រ',
    total: 'សរុប',
    subtotal: 'សរុបរង',
    vatTax: 'អាករលើតម្លៃបន្ថែម (10%)',
    grandTotal: 'ទឹកប្រាក់សរុប',
    reviewAndPay: 'ពិនិត្យ & បង់ប្រាក់',
    pay: 'បង់ប្រាក់',
    orderItems: 'សំបុត្រ & សេវាកម្មដែលបានជ្រើសរើស',
    clearAll: 'លុបទាំងអស់',
    emptyCart: 'មិនទាន់មានសំបុត្រត្រូវបានជ្រើសរើសទេ។ សូមជ្រើសរើសសំបុត្រមុនសិន។',
    browseTickets: 'មើលសំបុត្រ',
    checkoutTitle: 'ការទូទាត់សំបុត្រ',
    exitTitle: 'ចាកចេញពីកម្មវិធី Mini Zoo',
    exitMessage: 'តើអ្នកប្រាកដជាចង់ចាកចេញពីកម្មវិធីនេះមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ការកក់ទទួលបានជោគជ័យ!',
    paymentFailedTitle: 'ការទូទាត់មិនជោគជ័យ',
    paymentReceived: 'សំបុត្រឌីជីថលត្រូវបានចេញរួចរាល់!',
    orderTotal: 'ទឹកប្រាក់បានបង់សរុប',
    bookingCode: 'លេខកូដកក់',
    newBooking: 'កក់សំបុត្រថ្មី',
    tryAgain: 'ព្យាយាមម្តងទៀត',
    close: 'បិទ',
    selectLanguage: 'សូមជ្រើសរើសភាសារបស់អ្នក',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ ដើម្បីប្រើប្រាស់ក្នុងកម្មវិធី',
    today: 'ថ្ងៃនេះ',
    tomorrow: 'ថ្ងៃស្អែក',
    weekend: 'ចុងសប្តាហ៍នេះ',
    visitDate: 'កាលបរិច្ឆេទមកទស្សនា',
    timeSlot: 'ពេលវេលាចូលទស្សនា',
    specialAddons: 'សេវាកម្មបន្ថែម',
    myPasses: 'សំបុត្ររបស់ខ្ញុំ',
    zooMap: 'ផែនទីសួន & កន្លែងកម្សាន្ត',
    featuredAnimals: 'សត្វពិសេសៗ',
    feedingShowTimes: 'ម៉ោងផ្តល់ចំណី & ការសម្តែង',
    allTickets: 'សំបុត្រទាំងអស់',
    myTickets: 'កាបូបសំបុត្ររបស់ខ្ញុំ',
    gateQrCode: 'QR Code សម្រាប់ស្កេនចូលទ្វារ',
    scanInstructions: 'សូមបង្ហាញ QR Code នេះនៅច្រកទ្វារធំដើម្បីចូលទស្សនាភ្លាមៗ។',
    categories: {
      All: 'សំបុត្រទាំងអស់',
      Standard: 'ធម្មតា',
      Combo: 'កញ្ចប់គ្រួសារ',
      VIP: 'VIP សាហ្វារី',
      Night: 'សាហ្វារីរាត្រី'
    }
  },
  ko: {
    appName: '와일드 사파리 미니 동물원',
    visitorGuest: '방문객 게스트',
    searchPlaceholder: '입장권, 동물, 쇼 검색...',
    items: '개',
    total: '합계',
    subtotal: '소계',
    vatTax: '부가가치세 (10%)',
    grandTotal: '총 결제금액',
    reviewAndPay: '주문 확인 및 결제',
    pay: '결제하기',
    orderItems: '선택한 티켓 및 패키지',
    clearAll: '전체 삭제',
    emptyCart: '선택된 티켓이 없습니다. 티켓을 먼저 선택해 주세요.',
    browseTickets: '티켓 둘러보기',
    checkoutTitle: '티켓 결제',
    exitTitle: '미니 사파리 앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '예약이 완료되었습니다!',
    paymentFailedTitle: '결제 실패',
    paymentReceived: '디지털 모바일 패스가 발권되었습니다!',
    orderTotal: '결제 금액',
    bookingCode: '예약 코드',
    newBooking: '새 예약',
    tryAgain: '다시 시도',
    close: '닫기',
    selectLanguage: '언어를 선택해 주세요',
    languageSubtitle: '미니 동물원 앱에서 사용할 언어를 선택하세요',
    today: '오늘',
    tomorrow: '내일',
    weekend: '이번 주말',
    visitDate: '방문 날짜',
    timeSlot: '입장 시간대',
    specialAddons: '스페셜 체험 추가',
    myPasses: '내 티켓함',
    zooMap: '동물원 지도 및 시설',
    featuredAnimals: '주요 야생동물',
    feedingShowTimes: '먹이주기 쇼 & 프레젠테이션',
    allTickets: '모든 티켓',
    myTickets: '내 모바일 패스',
    gateQrCode: '게이트 QR 코드',
    scanInstructions: '공원 정문 개찰구에서 이 QR 코드를 스캔하여 바로 입장하세요.',
    categories: {
      All: '전체 티켓',
      Standard: '일반 입장권',
      Combo: '가족 콤보',
      VIP: 'VIP 사파리',
      Night: '나이트 사파리'
    }
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
    try {
      localStorage.setItem('mini_zoo_lang', lang)
    } catch (e) { }
  }

  // Load persisted
  try {
    const saved = localStorage.getItem('mini_zoo_lang') as LanguageCode
    if (saved && ['en', 'km', 'ko'].includes(saved)) {
      currentLanguage.value = saved
    }
  } catch (e) { }

  const t = computed(() => translations[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return {
    currentLanguage,
    supportedLanguages,
    setLanguage,
    t,
    currentLangObj
  }
}
