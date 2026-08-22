export const translations = {
  en: {
    appName: 'LOTUS ZEN SANCTUARY',
    slogan: 'Thermal Onsen Rituals & Essential Aromatherapy Sanctuary',
    selectLanguage: 'Select Language',
    myPasses: 'My Sanctuary Passes',
    noPasses: 'No active spa reservations found',
    bookFirst: 'Book Wellness Ritual',
    exitTitle: 'Exit Spa Sanctuary?',
    exitMessage: 'Your custom therapy ritual configuration will be reset.',
    yesExit: 'Exit',
    stay: 'Stay in Sanctuary',
    thermalPathway: 'Step-by-Step Therapy Ritual Pathway',
    aromaMixer: 'Essential Oil Aroma Customizer',
    confirmAndPay: 'Authorize Sanctuary Pass 🌿',
    paymentSuccess: 'Sanctuary Reservation Confirmed',
    livePass: 'Digital Sanctuary Key & Locker Pass',
    passCode: 'Sanctuary Access #'
  },
  km: {
    appName: 'ស្ប៉ាបែបធម្មជាតិ LOTUS ZEN',
    slogan: 'ត្រាំទឹកក្ដៅធម្មជាតិ និងម៉ាស្សាក្លិនក្រអូបបន្ធូរអារម្មណ៍',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'សំបុត្រស្ប៉ារបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានការកក់ស្ប៉ានៅឡើយទេ',
    bookFirst: 'កក់សេវាកម្មស្ប៉ា',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ការជ្រើសរើសសេវាកម្មរបស់អ្នកនឹងត្រូវកំណត់ឡើងវិញ។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    thermalPathway: 'ជំហាននៃការព្យាបាល និងស្ប៉ា',
    aromaMixer: 'ជ្រើសរើសប្រេងក្រអូបធម្មជាតិ',
    confirmAndPay: 'ទូទាត់កក់កន្លែងស្ប៉ា 🌿',
    paymentSuccess: 'ការកក់ស្ប៉ាទទួលបានជោគជ័យ',
    livePass: 'សំបុត្រឌីជីថលចូលស្ប៉ា និងទូដាក់ឥវ៉ាន់',
    passCode: 'លេខសម្គាល់សំបុត្រស្ប៉ា'
  },
  ko: {
    appName: '로터스 젠 웰니스 스파',
    slogan: '프리미엄 천연 온천 리추얼 & 아로마 테라피 생츄어리',
    selectLanguage: '언어 선택',
    myPasses: '내 스파 예약 패스',
    noPasses: '예약된 스파 이용권이 없습니다',
    bookFirst: '웰니스 리추얼 예약하기',
    exitTitle: '스파 예약을 종료하시겠습니까?',
    exitMessage: '선택하신 테라피 설정이 초기화됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    thermalPathway: '단계별 힐링 테라피 리추얼 코스',
    aromaMixer: '천연 에센셜 오일 아로마 믹서',
    confirmAndPay: '스파 패스 결제 및 확정 🌿',
    paymentSuccess: '스파 생츄어리 예약 완료',
    livePass: '디지털 락커 스마트 패스',
    passCode: '스파 입장 코드'
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
