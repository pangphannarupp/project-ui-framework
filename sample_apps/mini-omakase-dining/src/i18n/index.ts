export const translations = {
  en: {
    appName: 'HINOKI OMAKASE TABLE',
    slogan: 'Master Chef 12-Course Tasting & Junmai Sake Pairing',
    selectLanguage: 'Select Language',
    myPasses: 'My Dining Invitations',
    noPasses: 'No active dining reservations',
    bookFirst: 'Reserve Omakase Counter',
    exitTitle: 'Exit Omakase Reservation?',
    exitMessage: 'Your selected sushi counter seat will be released.',
    yesExit: 'Exit',
    stay: 'Stay at Counter',
    counterSeatingMap: 'Circular Chef Counter Seating Chart',
    tastingMenuScroll: '12-Course Seasonal Tasting Menu',
    confirmAndPay: 'Authorize Invitation & Deposit',
    paymentSuccess: 'Invitation Confirmed & Seat Reserved',
    invitationPass: 'Master Chef VIP Invitation Pass',
    code: 'Reservation Invitation #'
  },
  km: {
    appName: 'ភោជនីយដ្ឋានជប៉ុន HINOKI OMAKASE',
    slogan: 'សេវាកម្មកក់តុម្ហូបជប៉ុនបែបអូម៉ាកាសេ ១២ មុខពិសេស',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'សំបុត្រអញ្ជើញទទួលទានអាហារ',
    noPasses: 'មិនទាន់មានការកក់តុនៅឡើយទេ',
    bookFirst: 'កក់កៅអីមុខចុងភៅ',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'កៅអីដែលបានជ្រើសរើសនឹងត្រូវបោះបង់។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    counterSeatingMap: 'ប្លង់កៅអីមុខចុងភៅ',
    tastingMenuScroll: 'មុខម្ហូបពិសេសទាំង ១២ មុខ',
    confirmAndPay: 'ទូទាត់ប្រាក់កក់កៅអី',
    paymentSuccess: 'ការកក់តុទទួលបានជោគជ័យ',
    invitationPass: 'សំបុត្រអញ្ជើញកិត្តិយស OMAKASE',
    code: 'លេខសម្គាល់ការកក់'
  },
  ko: {
    appName: '히노키 오마카세 다이닝',
    slogan: '마스터 셰프 12코스 테이스팅 & 준마이 사케 페어링',
    selectLanguage: '언어 선택',
    myPasses: '내 다이닝 초대장 보관함',
    noPasses: '예약된 오마카세 내역이 없습니다',
    bookFirst: '셰프 카운터석 예약하기',
    exitTitle: '예약을 종료하시겠습니까?',
    exitMessage: '선택하신 카운터 좌석이 취소됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    counterSeatingMap: '원형 셰프 카운터 좌석 배치도',
    tastingMenuScroll: '계절 특선 12코스 메뉴',
    confirmAndPay: '예약금 결제 및 초대장 발급',
    paymentSuccess: '예약 완료 및 좌석 확정',
    invitationPass: '마스터 셰프 VIP 다이닝 초대장',
    code: '다이닝 예약 번호'
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
