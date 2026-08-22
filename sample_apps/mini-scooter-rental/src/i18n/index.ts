export const translations = {
  en: {
    appName: 'VOLT URBAN SCOOTERS',
    slogan: 'Instant Micro-Mobility & Zero-Emission e-Bikes',
    selectLanguage: 'Select Language',
    myPasses: 'My Rides & Trips',
    noPasses: 'No active scooter trips found',
    bookFirst: 'Find Scooter on Radar',
    exitTitle: 'Exit Volt Scooter?',
    exitMessage: 'Your selected scooter reservation will be released.',
    yesExit: 'Exit',
    stay: 'Stay in App',
    radarProximity: 'GPS Urban Proximity Radar',
    unlockScooter: 'Slide to Unlock & Ride',
    tripSummary: 'Trip & Rental Summary',
    confirmAndPay: 'Authorize & Pop Throttle',
    paymentSuccess: 'Scooter Unlocked & Throttle Active',
    activeTrip: 'Live Speedometer & Trip HUD',
    endRide: 'Lock & End Ride ⚡',
    tripCode: 'Trip Tracking #'
  },
  km: {
    appName: 'ស្កូតទ័រអគ្គិសនី VOLT',
    slogan: 'សេវាកម្មជួលស្កូតទ័រអគ្គិសនីមិនបំពុលបរិស្ថាន',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'ប្រវត្តិធ្វើដំណើររបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានការធ្វើដំណើរនៅឡើយទេ',
    bookFirst: 'ស្វែងរកស្កូតទ័រលើរ៉ាដា',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ការកក់ស្កូតទ័ររបស់អ្នកនឹងត្រូវបោះបង់។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    radarProximity: 'រ៉ាដាទីតាំងស្កូតទ័រជិតបំផុត',
    unlockScooter: 'អូសដើម្បីដោះសោរបើកបរ',
    tripSummary: 'សង្ខេបការជួលស្កូតទ័រ',
    confirmAndPay: 'ទូទាត់ និងដោះសោរបើកបរ',
    paymentSuccess: 'ស្កូតទ័រត្រូវបានដោះសោរជោគជ័យ',
    activeTrip: 'ផ្ទាំងបង្ហាញល្បឿន និងចម្ងាយ',
    endRide: 'ចាក់សោរបញ្ចប់ដំណើរ ⚡',
    tripCode: 'លេខសម្គាល់ការធ្វើដំណើរ'
  },
  ko: {
    appName: '볼트 전동 킥보드',
    slogan: '친환경 스마트 마이크로 모빌리티 렌탈',
    selectLanguage: '언어 선택',
    myPasses: '내 라이딩 기록',
    noPasses: '진행 중인 라이딩이 없습니다',
    bookFirst: '레이더에서 킥보드 찾기',
    exitTitle: '앱을 종료하시겠습니까?',
    exitMessage: '선택한 킥보드 예약이 취소됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    radarProximity: '실시간 GPS 주변 레이더',
    unlockScooter: '슬라이드하여 잠금 해제',
    tripSummary: '대여 및 요금 요약',
    confirmAndPay: '결제 및 가속 레버 활성화',
    paymentSuccess: '잠금 해제 완료 및 주행 준비 완료',
    activeTrip: '실시간 주행 속도계 HUD',
    endRide: '반납 및 주행 종료 ⚡',
    tripCode: '주행 트래킹 번호'
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
