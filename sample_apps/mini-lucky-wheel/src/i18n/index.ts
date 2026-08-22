import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Lucky Wheel & Rewards',
    guestUser: 'LUCKY PLAYER GUEST',
    spinsRemaining: 'Spins Left',
    spinNow: 'SPIN WHEEL NOW',
    buySpins: 'Buy Extra Spins',
    spinPackTitle: 'Lucky Spin Token Packs',
    reviewAndPay: 'Purchase Spin Tokens',
    pay: 'Pay Now',
    checkoutTitle: 'Lucky Spins Checkout',
    exitTitle: 'Exit Lucky Wheel',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Spins Credited!',
    paymentReceived: 'Tokens added! Good luck spinning the wheel!',
    congratsTitle: '🎉 Congratulations!',
    prizesWon: 'My Reward Vouchers',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'កងបង្វិលសំណាង & រង្វាន់',
    guestUser: 'អ្នកលេងសំណាង',
    spinsRemaining: 'ចំនួនបង្វិលដែលនៅសល់',
    spinNow: 'បង្វិលឥឡូវនេះ',
    buySpins: 'ទិញកាក់បង្វិលបន្ថែម',
    spinPackTitle: 'កញ្ចប់កាក់បង្វិលសំណាង',
    reviewAndPay: 'ទិញកាក់បង្វិល',
    pay: 'បង់ប្រាក់ឥឡូវនេះ',
    checkoutTitle: 'ការទូទាត់ទិញកាក់',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'បានបញ្ចូលកាក់ជោគជ័យ!',
    paymentReceived: 'កាក់បង្វិលត្រូវបានបញ្ចូល! សូមសំណាងល្អ!',
    congratsTitle: '🎉 អបអរសាទរ!',
    prizesWon: 'ប័ណ្ណរង្វាន់របស់ខ្ញុំ',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '럭키 룰렛 & 리워드',
    guestUser: '행운의 플레이어',
    spinsRemaining: '남은 스핀 횟수',
    spinNow: '룰렛 돌리기',
    buySpins: '스핀 코인 충전',
    spinPackTitle: '럭키 스핀 코인 팩',
    reviewAndPay: '스핀 코인 구매',
    pay: '결제하기',
    checkoutTitle: '스핀 코인 결제',
    exitTitle: '룰렛 앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '스핀 코인 충전 완료!',
    paymentReceived: '코인이 충전되었습니다! 행운을 빕니다!',
    congratsTitle: '🎉 축하합니다 당첨!',
    prizesWon: '내 당첨 쿠폰함',
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
    try { localStorage.setItem('wheel_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('wheel_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
