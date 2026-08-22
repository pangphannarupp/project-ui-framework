import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart EV Charging',
    guestUser: 'EV DRIVER GUEST',
    stationSearch: 'Search EV Hubs & Superchargers...',
    availableHubs: 'Fast Charging Hubs',
    plugIn: 'Plug & Start Charge',
    targetSoc: 'Target Battery Level',
    energyCost: 'Electricity Rate',
    reviewAndPay: 'Authorize & Charge',
    pay: 'Pay & Unlock Charger',
    checkoutTitle: 'EV Charging Authorize',
    exitTitle: 'Exit EV Charge App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Charging Initiated!',
    paymentReceived: 'High-power DC juice is flowing into your EV battery!',
    liveGauge: 'Live Charging Telemetry',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'ស្ថានីយ៍សាករថយន្តអគ្គិសនី',
    guestUser: 'អ្នកបើកបរ EV',
    stationSearch: 'ស្វែងរកទីតាំងសាកថ្មល្បឿនលឿន...',
    availableHubs: 'ស្ថានីយ៍សាកល្បឿនលឿន',
    plugIn: 'ដោតឌុយ & ចាប់ផ្តើមសាក',
    targetSoc: 'កម្រិតថ្មគោលដៅ',
    energyCost: 'តម្លៃអគ្គិសនី',
    reviewAndPay: 'អនុញ្ញាត & សាកថ្ម',
    pay: 'បង់ប្រាក់ & បើកក្បាលសាក',
    checkoutTitle: 'ការទូទាត់សាកថ្ម EV',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ការសាកថ្មបានចាប់ផ្តើម!',
    paymentReceived: 'ចរន្តអគ្គិសនីល្បឿនលឿនកំពុងបញ្ចូលទៅក្នុងរថយន្តរបស់អ្នក!',
    liveGauge: 'ទិន្នន័យសាកថ្មផ្ទាល់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 전기차 충전',
    guestUser: 'EV 운전자 게스트',
    stationSearch: '초고속 충전소 검색...',
    availableHubs: '급속 충전소 목록',
    plugIn: '커넥터 연결 및 충전 시작',
    targetSoc: '목표 배터리 잔량',
    energyCost: '전력 단가 (kWh)',
    reviewAndPay: '결제 및 충전 시작',
    pay: '선결제 및 충전 승인',
    checkoutTitle: 'EV 충전 결제',
    exitTitle: '충전 앱 종료',
    exitMessage: '충전 앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '전기차 충전이 시작되었습니다!',
    paymentReceived: '초급속 DC 전력이 차량으로 공급 중입니다!',
    liveGauge: '실시간 충전 게이지',
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
    try { localStorage.setItem('ev_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('ev_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
