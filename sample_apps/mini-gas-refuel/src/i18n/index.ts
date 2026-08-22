export const translations = {
  en: {
    appName: 'NITRO SMART REFUEL',
    slogan: 'Instant Island Pump Pre-Pay & Smart Fuel Dispenser',
    selectLanguage: 'Select Language',
    myPasses: 'My Fuel Receipts',
    noPasses: 'No fuel transactions found',
    bookFirst: 'Select Pump & Grade',
    exitTitle: 'Exit Fuel Station?',
    exitMessage: 'Your selected pump authorization will be cancelled.',
    yesExit: 'Exit',
    stay: 'Stay at Pump',
    pumpMatrix: 'Station Island Pump Grid',
    fuelDispenser: 'Smart Fuel Meter Dispenser',
    confirmAndPay: 'Authorize Pump & Dispense Fuel',
    paymentSuccess: 'Pump Authorized & Fuel Dispensed',
    liveReceipt: 'Smart Fuel Tax Receipt',
    receiptNo: 'Fuel Dispatch Receipt #'
  },
  km: {
    appName: 'ស្ថានីយ៍ប្រេងឥន្ធនៈឆ្លាតវៃ NITRO',
    slogan: 'ទូទាត់ប្រេងឥន្ធនៈភ្លាមៗ និងគ្រប់គ្រងការចាក់ប្រេង',
    selectLanguage: 'ជ្រើសរើសភាសា',
    myPasses: 'វិក្កយបត្រប្រេងរបស់ខ្ញុំ',
    noPasses: 'មិនទាន់មានប្រវត្តិទិញប្រេងនៅឡើយទេ',
    bookFirst: 'ជ្រើសរើសទូប្រេង និងប្រភេទប្រេង',
    exitTitle: 'ចាកចេញពីកម្មវិធី?',
    exitMessage: 'ការអនុញ្ញាតទូប្រេងនឹងត្រូវបោះបង់។',
    yesExit: 'ចាកចេញ',
    stay: 'បន្តនៅទីនេះ',
    pumpMatrix: 'ប្លង់ទូប្រេងក្នុងស្ថានីយ៍',
    fuelDispenser: 'ឧបករណ៍វាស់បរិមាណប្រេង',
    confirmAndPay: 'ទូទាត់ និងដោះសោរបូមប្រេង',
    paymentSuccess: 'ការទូទាត់ជោគជ័យ និងប្រេងបានចាក់រួចរាល់',
    liveReceipt: 'វិក្កយបត្រប្រេងឌីជីថល',
    receiptNo: 'លេខសម្គាល់វិក្កយបត្រ'
  },
  ko: {
    appName: '니트로 스마트 주유소',
    slogan: '실시간 주유기 사전 결제 및 스마트 연료 디스펜서',
    selectLanguage: '언어 선택',
    myPasses: '내 주유 영수증 보관함',
    noPasses: '주유 결제 내역이 없습니다',
    bookFirst: '주유기 및 유종 선택하기',
    exitTitle: '주유 앱을 종료하시겠습니까?',
    exitMessage: '선택하신 주유기 승인이 취소됩니다.',
    yesExit: '종료',
    stay: '계속 머무르기',
    pumpMatrix: '스테이션 주유기 아일랜드 맵',
    fuelDispenser: '스마트 연료 주유량 조절기',
    confirmAndPay: '결제 및 주유 노즐 활성화',
    paymentSuccess: '주유기 승인 완료 및 주유 완료',
    liveReceipt: '디지털 주유 전자 영수증',
    receiptNo: '주유 승인 영수증 번호'
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
