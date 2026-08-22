export const translations = {
  en: {
    appName: 'AUGUSTA LINKS GOLF CLUB',
    slogan: 'Championship 18-Hole Course & Master Caddie Booking',
    selectLanguage: 'Select Language',
    myPasses: 'My Tee-Times & Passes',
    noPasses: 'No active tee-time reservations',
    bookFirst: 'Book 18-Hole Round',
    exitTitle: 'Exit Golf Club?',
    exitMessage: 'Your selected tee-time will be released.',
    yesExit: 'Exit',
    stay: 'Stay in Club',
    courseTopography: 'Interactive 18-Hole Topography',
    bookTeeTime: 'Reserve Tee-Time ⛳',
    roundSummary: 'Tee-Time Reservation Summary',
    confirmAndPay: 'Authorize & Lock Tee-Time',
    paymentSuccess: 'Tee-Time Confirmed & Caddie Assigned',
    livePass: 'Clubhouse Check-In Pass',
    bookingCode: 'Tee-Time Reservation #'
  },
  km: {
    appName: 'ក្លឹបវាយកូនហ្គោលលំដាប់ពិភពលោក',
    slogan: 'កក់ម៉ោងវាយកូនហ្គោល ១៨ រន្ធ និងអ្នកជួយកាន់កាតាប',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'ម៉ោងវាយកូនហ្គោលរបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានការកក់ម៉ោងនៅឡើយទេ',
    bookFirst: 'កក់ម៉ោងវាយកូនហ្គោល',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ម៉ោងដែលបានជ្រើសរើសនឹងត្រូវបោះបង់។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    courseTopography: 'ប្លង់ទីលានកូនហ្គោល ១៨ រន្ធ',
    bookTeeTime: 'កក់ម៉ោងវាយកូនហ្គោល ⛳',
    roundSummary: 'សង្ខេបការកក់ម៉ោង',
    confirmAndPay: 'ទូទាត់ និងចាក់សោរម៉ោង',
    paymentSuccess: 'ការកក់ទទួលបានជោគជ័យ',
    livePass: 'សំបុត្រចូលទីលានវាយកូនហ្គោល',
    bookingCode: 'លេខសម្គាល់ការកក់'
  },
  ko: {
    appName: '오거스타 링크스 골프 클럽',
    slogan: '챔피언십 18홀 코스 및 마스터 캐디 예약',
    selectLanguage: '언어 선택',
    myPasses: '내 티타임 예약 내역',
    noPasses: '예약된 티타임이 없습니다',
    bookFirst: '18홀 라운드 예약하기',
    exitTitle: '골프 클럽을 종료하시겠습니까?',
    exitMessage: '선택하신 티타임 예약이 취소됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    courseTopography: '18홀 인터랙티브 코스 지형도',
    bookTeeTime: '티타임 예약하기 ⛳',
    roundSummary: '티타임 예약 요약',
    confirmAndPay: '결제 및 티타임 확정',
    paymentSuccess: '티타임 확정 및 캐디 배정 완료',
    livePass: '클럽하우스 체크인 스마트 패스',
    bookingCode: '티타임 예약 번호'
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
