export const translations = {
  en: {
    appName: 'HARMONY PHOTO BOOTH',
    slogan: 'Instant 4-Cut Vintage Film Studio & Custom Sticker Prints',
    selectLanguage: 'Select Language',
    myPasses: 'My Digital Film Strips',
    noPasses: 'No printed film strips found',
    bookFirst: 'Shoot 4-Cut Strip',
    exitTitle: 'Exit Photo Booth?',
    exitMessage: 'Your custom sticker frame layout will be cleared.',
    yesExit: 'Exit',
    stay: 'Stay in Studio',
    filmStudioStage: 'Live 4-Cut Vertical Film Strip',
    chooseTheme: '1. Select Frame Color & Filter FX',
    chooseLayout: '2. Select Print Layout',
    confirmAndPay: 'Print 4-Cut Strip 📸',
    paymentSuccess: 'Film Strip Processed & Ready to Print',
    livePrintPass: 'Kiosk Instant Print Pass',
    printCode: 'Kiosk Print Dispatch #'
  },
  km: {
    appName: 'ទូថតរូបស្វ័យប្រវត្តិ HARMONY',
    slogan: 'ស្ទូឌីយោថតរូប ៤ ប្លង់ និងបិទស្ទីគ័របែបបុរាណ',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'ផ្ទាំងរូបថតរបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានប្រវត្តិថតរូបនៅឡើយទេ',
    bookFirst: 'ថតរូប ៤ ប្លង់ឥឡូវនេះ',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ស៊ុមរូបថតដែលបានកែសម្រួលនឹងត្រូវបោះបង់។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    filmStudioStage: 'ផ្ទាំងបង្ហាញរូបថត ៤ ប្លង់',
    chooseTheme: '១. ជ្រើសរើសពណ៌ស៊ុម និងបែបផែនពណ៌',
    chooseLayout: '២. ជ្រើសរើសទម្រង់ស៊ុមរូបថត',
    confirmAndPay: 'បោះពុម្ពរូបថត ៤ ប្លង់ 📸',
    paymentSuccess: 'រូបថតត្រូវបានដំណើរការជោគជ័យ',
    livePrintPass: 'សំបុត្រស្កេនបោះពុម្ពរូបថត',
    printCode: 'លេខកូដបោះពុម្ព'
  },
  ko: {
    appName: '하모니 포토 부스',
    slogan: '즉석 인생 4컷 빈티지 필름 스튜디오 & 스티커 인화',
    selectLanguage: '언어 선택',
    myPasses: '내 디지털 네컷 필름',
    noPasses: '인화된 네컷 사진이 없습니다',
    bookFirst: '인생 4컷 촬영하기',
    exitTitle: '포토 부스를 종료하시겠습니까?',
    exitMessage: '편집 중인 프레임 레이아웃이 초기화됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    filmStudioStage: '실시간 인생 4컷 세로 프레임 스튜디오',
    chooseTheme: '1. 프레임 테마 및 필터 FX 선택',
    chooseLayout: '2. 인화 레이아웃 선택',
    confirmAndPay: '4컷 필름 인화하기 📸',
    paymentSuccess: '네컷 사진 인화 준비 완료',
    livePrintPass: '키오스크 즉석 인화 바코드 패스',
    printCode: '키오스크 인화 번호'
  }
}

import { ref, computed } from 'vue'

export type Language = 'en' | 'km' | 'ko'
const currentLanguage = ref<Language>('en')

export function useI18n() {
  const t = computed(() => translations[currentLanguage.value])
  const setLanguage = (lang: Language) => {
    currentLanguage.value = lang
  }
  const supportedLanguages = [
    { code: 'en' as Language, name: 'English', flag: '🇺🇸' },
    { code: 'km' as Language, name: 'ភាសាខ្មែរ', flag: '🇰🇭' },
    { code: 'ko' as Language, name: '한국어', flag: '🇰🇷' }
  ]
  const currentLangObj = computed(() => {
    return supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0]
  })
  return { t, currentLanguage, setLanguage, supportedLanguages, currentLangObj }
}
