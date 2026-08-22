export const translations = {
  en: {
    appName: 'FIRST SUITE BOARDING PASS',
    slogan: 'Singapore Airlines First & Business Lounge Concierge',
    selectLanguage: 'Select Language',
    myPasses: 'My Boarding Passes',
    noPasses: 'No active flight boarding passes',
    bookFirst: 'Choose Cabin Seat',
    exitTitle: 'Exit Flight Concierge?',
    exitMessage: 'Your selected seat will be held for 10 minutes.',
    yesExit: 'Exit',
    stay: 'Stay in Lounge',
    cabinFuselageMap: 'Fuselage Seat Cross-Section',
    confirmSeat: 'Confirm Seat & Issue Pass',
    flightSummary: 'Flight & Boarding Summary',
    confirmAndPay: 'Authorize & Issue Pass',
    paymentSuccess: 'Boarding Pass Issued & Gate Open',
    liveBoardingPass: 'Live Mobile Boarding Pass',
    eticketNo: 'e-Ticket Reference #'
  },
  km: {
    appName: 'សំបុត្រឡើងយន្តហោះលំដាប់ខ្ពស់',
    slogan: 'សេវាកម្មកក់កៅអី និងបន្ទប់រង់ចាំពិសេស',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'សំបុត្រយន្តហោះរបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានសំបុត្រឡើងយន្តហោះនៅឡើយទេ',
    bookFirst: 'ជ្រើសរើសកៅអីយន្តហោះ',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'កៅអីដែលបានជ្រើសរើសនឹងត្រូវរក្សាទុក ១០ នាទី។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    cabinFuselageMap: 'ប្លង់កៅអីក្នុងកាប៊ីនយន្តហោះ',
    confirmSeat: 'បញ្ជាក់កៅអី និងចេញសំបុត្រ',
    flightSummary: 'សង្ខេបជើងហោះហើរ',
    confirmAndPay: 'ទូទាត់ និងចេញសំបុត្រ',
    paymentSuccess: 'សំបុត្រឡើងយន្តហោះរួចរាល់',
    liveBoardingPass: 'សំបុត្រយន្តហោះឌីជីថលផ្ទាល់',
    eticketNo: 'លេខសម្គាល់សំបុត្រ e-Ticket'
  },
  ko: {
    appName: '퍼스트 스위트 탑승권',
    slogan: '싱가포르 항공 퍼스트 & 비즈니스 라운지 컨시어지',
    selectLanguage: '언어 선택',
    myPasses: '내 탑승권 보관함',
    noPasses: '발급된 탑승권이 없습니다',
    bookFirst: '기내 좌석 선택하기',
    exitTitle: '컨시어지를 종료하시겠습니까?',
    exitMessage: '선택하신 좌석이 10분간 임시 배정됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    cabinFuselageMap: 'A380 기내 좌석 배치도',
    confirmSeat: '좌석 확정 및 탑승권 발급',
    flightSummary: '항공편 및 탑승 요약',
    confirmAndPay: '결제 및 모바일 탑승권 발급',
    paymentSuccess: '모바일 탑승권 발급 완료',
    liveBoardingPass: '실시간 모바일 스마트 탑승권',
    eticketNo: '전자 항공권 번호'
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
