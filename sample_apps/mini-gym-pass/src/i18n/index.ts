import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Cyber Fitness & Club Pass',
    guestUser: 'ATHLETE GUEST',
    choosePass: 'Membership & Day Passes',
    todayClasses: 'Live Studio Schedule',
    bookClass: 'Reserve Spot',
    reviewAndPay: 'Purchase & Get Turnstile Pass',
    pay: 'Pay Now',
    checkoutTitle: 'Gym Membership Checkout',
    exitTitle: 'Exit Gym App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Pass Activated!',
    paymentReceived: 'Turnstile QR is ready! Step up to the scanner.',
    passCode: 'Member ID',
    myPasses: 'My Active Passes',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'ក្លឹបហាត់ប្រាណ & សំបុត្រចូល',
    guestUser: 'អត្តពលិក',
    choosePass: 'កញ្ចប់សមាជិកភាព & សំបុត្រប្រចាំថ្ងៃ',
    todayClasses: 'កាលវិភាគថ្នាក់ហាត់ប្រាណ',
    bookClass: 'កក់កន្លែង',
    reviewAndPay: 'ទិញ & ទទួលកូដស្កេនទ្វារ',
    pay: 'បង់ប្រាក់ឥឡូវនេះ',
    checkoutTitle: 'ការទូទាត់សមាជិកភាព',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'កាតសមាជិកដំណើរការ!',
    paymentReceived: 'កូដ QR សម្រាប់ស្កេនទ្វារចេញចូលបានរួចរាល់!',
    passCode: 'លេខកូដសមាជិក',
    myPasses: 'កាតសមាជិករបស់ខ្ញុំ',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '사이버 피트니스 & 패스',
    guestUser: '피트니스 멤버',
    choosePass: '이용권 및 일일 패스',
    todayClasses: '스튜디오 라이브 클래스',
    bookClass: '예약하기',
    reviewAndPay: '결제 및 입장권 발권',
    pay: '결제하기',
    checkoutTitle: '이용권 결제',
    exitTitle: '앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '이용권 활성화 완료!',
    paymentReceived: '입장 게이트 바코드가 발급되었습니다!',
    passCode: '회원 번호',
    myPasses: '내 이용권',
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
    try { localStorage.setItem('gym_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('gym_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
