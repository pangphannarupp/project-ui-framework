import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart Parcel Locker Hub',
    guestUser: 'PARCEL SENDER',
    dropoff: 'Drop Off Parcel',
    pickup: 'Pick Up Parcel',
    selectSize: 'Select Compartment Size',
    senderPhone: 'Sender Mobile Phone',
    recipientPhone: 'Recipient Mobile Phone',
    reviewAndPay: 'Authorize & Open Locker Door',
    pay: 'Pay Locker Fee & Pop Open',
    checkoutTitle: 'Locker Rental Checkout',
    enterOtpTitle: 'Enter Pickup PIN Code',
    exitTitle: 'Exit Locker Hub',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Locker Door Opened!',
    paymentReceived: 'Compartment door popped open! Place parcel and shut door firmly.',
    pinCode: 'Compartment PIN Code',
    myPasses: 'My Active Lockers',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'ទូរផ្ញើ & ទទួលទំនិញឆ្លាតវៃ',
    guestUser: 'អ្នកផ្ញើទំនិញ',
    dropoff: 'ផ្ញើទំនិញក្នុងទូ',
    pickup: 'មកយកទំនិញ',
    selectSize: 'ជ្រើសរើសទំហំថតទូ',
    senderPhone: 'លេខទូរស័ព្ទអ្នកផ្ញើ',
    recipientPhone: 'លេខទូរស័ព្ទអ្នកទទួល',
    reviewAndPay: 'អនុញ្ញាត & បើកទ្វារទូ',
    pay: 'បង់ប្រាក់ & បើកទ្វារ',
    checkoutTitle: 'ការជួលថតទូផ្ញើឥវ៉ាន់',
    enterOtpTitle: 'បញ្ចូលលេខកូដសម្ងាត់យកទំនិញ',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ទ្វារទូបានរបើក!',
    paymentReceived: 'ទ្វារថតទូបានរបើក! សូមដាក់ទំនិញចូល ហើយរុញបិទទ្វារឱ្យជិត។',
    pinCode: 'លេខកូដបើកទូ',
    myPasses: 'ប្រវត្តិប្រើប្រាស់ទូ',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 무인 택배함',
    guestUser: '발송 회원',
    dropoff: '택배 보관/발송',
    pickup: '택배 수령/찾기',
    selectSize: '보관함 크기 선택',
    senderPhone: '보내는 분 휴대폰',
    recipientPhone: '받는 분 휴대폰',
    reviewAndPay: '결제 및 보관함 열기',
    pay: '결제 및 도어 오픈',
    checkoutTitle: '보관함 이용 결제',
    enterOtpTitle: '수령 비밀번호(PIN) 입력',
    exitTitle: '앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '보관함 도어가 열렸습니다!',
    paymentReceived: '해당 칸의 문이 열렸습니다. 물품을 넣고 문을 꼭 닫아주세요.',
    pinCode: '보관함 비밀번호',
    myPasses: '내 보관함 이용내역',
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
    try { localStorage.setItem('parcel_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('parcel_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
