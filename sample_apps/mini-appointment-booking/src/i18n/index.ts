import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart Clinic & Spa Booking',
    guestUser: 'PATIENT GUEST',
    selectService: 'Select Treatment',
    appointmentDate: 'Booking Date',
    timeSlot: 'Select Time Slot',
    depositNote: 'Deposit required to lock slot',
    reviewAndPay: 'Book & Pay Deposit',
    pay: 'Pay Deposit Now',
    checkoutTitle: 'Appointment Checkout',
    exitTitle: 'Exit Booking App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Appointment Confirmed!',
    paymentReceived: 'Your clinic booking is secured. Show QR upon arrival!',
    appointmentCode: 'Booking Code',
    myPasses: 'My Appointments',
    total: 'Service Total',
    deposit: 'Deposit to Pay',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'ការកក់ណាត់ជួបវេជ្ជបណ្ឌិត & ស្ប៉ា',
    guestUser: 'អតិថិជន',
    selectService: 'ជ្រើសរើសសេវាកម្ម',
    appointmentDate: 'កាលបរិច្ឆេទណាត់ជួប',
    timeSlot: 'ជ្រើសរើសម៉ោង',
    depositNote: 'កក់ប្រាក់កក់ដើម្បីរក្សាម៉ោងណាត់',
    reviewAndPay: 'កក់ & បង់ប្រាក់កក់',
    pay: 'បង់ប្រាក់កក់ឥឡូវនេះ',
    checkoutTitle: 'ការទូទាត់ប្រាក់កក់',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ការកក់ទទួលបានជោគជ័យ!',
    paymentReceived: 'ម៉ោងណាត់ជួបរបស់អ្នកត្រូវបានធានា!',
    appointmentCode: 'លេខកូដណាត់ជួប',
    myPasses: 'ការណាត់ជួបរបស់ខ្ញុំ',
    total: 'តម្លៃសេវាសរុប',
    deposit: 'ប្រាក់កក់ត្រូវបង់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 클리닉 & 스파 예약',
    guestUser: '예약 고객',
    selectService: '진료 / 시술 선택',
    appointmentDate: '예약일 선택',
    timeSlot: '예약 시간 선택',
    depositNote: '예약 확정을 위한 예약금 결제',
    reviewAndPay: '예약 확인 및 예약금 결제',
    pay: '예약금 결제하기',
    checkoutTitle: '진료 예약 결제',
    exitTitle: '예약 앱 종료',
    exitMessage: '예약을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '예약 확정 완료!',
    paymentReceived: '예약이 성공적으로 확정되었습니다!',
    appointmentCode: '예약 번호',
    myPasses: '내 예약 내역',
    total: '총 진료비',
    deposit: '결제 예약금',
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
    try { localStorage.setItem('apt_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('apt_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
