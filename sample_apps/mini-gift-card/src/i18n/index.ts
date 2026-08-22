import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Celebration Digital Gift Cards',
    guestUser: 'GIFT SENDER',
    chooseCard: 'Choose Card Design',
    selectAmount: 'Gift Value ($ USD)',
    recipientDetails: 'Personalize Your Gift',
    recipientName: 'Recipient Name',
    customMessage: 'Greeting Card Message',
    reviewAndPay: 'Review & Send Digital Gift',
    pay: 'Purchase & Send Gift Card',
    checkoutTitle: 'Gift Card Order Summary',
    exitTitle: 'Exit Gift Card App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Gift Card Sent!',
    paymentReceived: 'Digital Gift Voucher created & celebration confetti delivered!',
    voucherCode: 'Claim Voucher Code',
    statusTitle: 'Digital Gift Voucher',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'កាតកាដូឌីជីថល & សារជូនពរ',
    guestUser: 'អ្នកផ្ញើកាដូ',
    chooseCard: 'ជ្រើសរើសម៉ូតកាត',
    selectAmount: 'ទឹកប្រាក់កាដូ ($ USD)',
    recipientDetails: 'ព័ត៌មានអ្នកទទួល & សារជូនពរ',
    recipientName: 'ឈ្មោះអ្នកទទួល',
    customMessage: 'សារជូនពរផ្ទាល់ខ្លួន',
    reviewAndPay: 'ពិនិត្យ & ផ្ញើកាតកាដូ',
    pay: 'ទូទាត់ & ផ្ញើកាតកាដូ',
    checkoutTitle: 'សង្ខេបការទិញកាតកាដូ',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'កាតកាដូបានផ្ញើរួចរាល់!',
    paymentReceived: 'កាតកាដូឌីជីថលបានបង្កើត និង រួចរាល់សម្រាប់អ្នកទទួល!',
    voucherCode: 'លេខកូដទូទាត់កាដូ',
    statusTitle: 'ប័ណ្ណកាដូឌីជីថល',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '셀레브레이션 디지털 기프트카드',
    guestUser: '선물 회원',
    chooseCard: '카드 디자인 선택',
    selectAmount: '충전 금액 ($ USD)',
    recipientDetails: '받는 분 및 축하 메시지',
    recipientName: '받는 분 성함',
    customMessage: '감사/축하 메시지',
    reviewAndPay: '선물 확인 및 결제',
    pay: '결제 및 기프트카드 발송',
    checkoutTitle: '기프트카드 구매 결제',
    exitTitle: '앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '기프트카드 발송 완료!',
    paymentReceived: '디지털 상품권이 성공적으로 발급되었습니다!',
    voucherCode: '기프트 바우처 코드',
    statusTitle: '디지털 기프트카드 바우처',
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
    try { localStorage.setItem('gift_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('gift_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
