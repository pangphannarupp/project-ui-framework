import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Live Concerts & Arena Passes',
    guestUser: 'CONCERT FAN',
    zonesTitle: 'Select Stage Zone & Seating Tier',
    lineup: 'Artist Lineup & Timetable',
    reviewAndPay: 'Guarantee Tickets & Issue Pass',
    pay: 'Pay & Issue Security Pass',
    checkoutTitle: 'Concert Ticket Checkout',
    exitTitle: 'Exit Event App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Ticket Confirmed!',
    paymentReceived: 'Your anti-screenshot rotating QR arena pass is ready!',
    ticketNumber: 'Arena Pass Number',
    statusTitle: 'Digital Arena Gate Pass',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'សំបុត្រការប្រគំតន្ត្រីផ្ទាល់',
    guestUser: 'ទស្សនិកជន',
    zonesTitle: 'ជ្រើសរើសតំបន់ឆាក & កៅអី',
    lineup: 'តារាងកម្មវិធី & សិល្បករ',
    reviewAndPay: 'ធានាសំបុត្រ & ទទួលសំបុត្រអេឡិចត្រូនិច',
    pay: 'បង់ប្រាក់ & ទទួលសំបុត្រស្កេន',
    checkoutTitle: 'ការទូទាត់សំបុត្រការប្រគំតន្ត្រី',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'សំបុត្រត្រូវបានបញ្ជាក់!',
    paymentReceived: 'សំបុត្រស្កេន QR ឆ្លាតវៃសម្រាប់ចូលទស្សនាបានរួចរាល់!',
    ticketNumber: 'លេខសំបុត្រចូលទស្សនា',
    statusTitle: 'សំបុត្រចូលទ្វារការប្រគំតន្ត្រី',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '라이브 콘서트 & 아레나 티켓',
    guestUser: '콘서트 관객',
    zonesTitle: '공연 구역 및 좌석 등급 선택',
    lineup: '아티스트 라인업 및 타임테이블',
    reviewAndPay: '예매 확정 및 모바일 티켓 발권',
    pay: '결제 및 입장 바코드 발급',
    checkoutTitle: '콘서트 티켓 결제',
    exitTitle: '앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '예매가 확정되었습니다!',
    paymentReceived: '캡처 방지 보안 QR 모바일 티켓이 발권되었습니다!',
    ticketNumber: '티켓 번호',
    statusTitle: '모바일 아레나 입장권',
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
    try { localStorage.setItem('event_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('event_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
