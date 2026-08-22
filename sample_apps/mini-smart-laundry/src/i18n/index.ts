import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart Laundromat & Dryer',
    guestUser: 'LAUNDRY GUEST',
    washers: 'Washers',
    dryers: 'Dryers',
    startCycle: 'Configure & Start Cycle',
    waterTemp: 'Water Temperature',
    spinSpeed: 'Spin Extraction Speed',
    extraRinse: 'Add Extra Hygiene Rinse (+$0.50)',
    scentBooster: 'Add Floral Scent Booster (+$0.50)',
    reviewAndPay: 'Authorize & Start Machine',
    pay: 'Pay & Unlock Drum',
    checkoutTitle: 'Laundry Cycle Setup',
    exitTitle: 'Exit Laundromat App',
    exitMessage: 'Are you sure you want to exit?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Cycle Started!',
    paymentReceived: 'Drum locked & water cycle engaged. You can track progress live!',
    orderCode: 'Machine Token',
    orderStatus: 'Live Drum Telemetry',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'បោកអ៊ុតឆ្លាតវៃ & ម៉ាស៊ីនសម្ងួត',
    guestUser: 'អតិថិជនបោកគក់',
    washers: 'ម៉ាស៊ីនបោក',
    dryers: 'ម៉ាស៊ីនសម្ងួត',
    startCycle: 'កំណត់ & ចាប់ផ្តើមបោក',
    waterTemp: 'កម្តៅទឹក',
    spinSpeed: 'ល្បឿនបង្វិលស្ងួត',
    extraRinse: 'បន្ថែមទឹកជម្រះអនាម័យ (+$0.50)',
    scentBooster: 'បន្ថែមទឹកក្រអូបផ្កា (+$0.50)',
    reviewAndPay: 'អនុញ្ញាត & បើកម៉ាស៊ីន',
    pay: 'បង់ប្រាក់ & ចាប់ផ្តើម',
    checkoutTitle: 'កំណត់ជម្រើសបោកគក់',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ម៉ាស៊ីនចាប់ផ្តើមដំណើរការ!',
    paymentReceived: 'ទ្វារបានចាក់សោរ និង ទឹកបានបង្ហូរចូលរួចរាល់!',
    orderCode: 'លេខកូដម៉ាស៊ីន',
    orderStatus: 'ស្ថានភាពម៉ាស៊ីនផ្ទាល់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 빨래방 & 건조기',
    guestUser: '세탁 고객',
    washers: '세탁기',
    dryers: '건조기',
    startCycle: '세탁 코스 설정 및 시작',
    waterTemp: '세탁 수온',
    spinSpeed: '탈수 강도',
    extraRinse: '안심 헹굼 추가 (+$0.50)',
    scentBooster: '플로럴 섬유유연제 추가 (+$0.50)',
    reviewAndPay: '결제 및 세탁 시작',
    pay: '결제 및 도어락 해제',
    checkoutTitle: '세탁 코스 결제',
    exitTitle: '빨래방 앱 종료',
    exitMessage: '앱을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '세탁 코스 시작!',
    paymentReceived: '도어가 잠기고 세탁수가 공급됩니다. 실시간 현황을 확인하세요!',
    orderCode: '세탁기 토큰',
    orderStatus: '실시간 세탁 진행 현황',
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
    try { localStorage.setItem('laundry_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('laundry_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
