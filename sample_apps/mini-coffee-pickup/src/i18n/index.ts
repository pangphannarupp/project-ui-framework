import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Nordic Artisan Coffee',
    guestUser: 'COFFEE ENTHUSIAST',
    searchPlaceholder: 'Search roasts, single-origins, brews...',
    cupSize: 'Cup Size',
    milkType: 'Milk & Plant Dairy',
    sweetness: 'Sweetness',
    iceLevel: 'Ice Temp',
    extraShots: 'Extra Espresso Shot',
    customize: 'Customize Cup',
    orderNow: 'Add to Cart',
    reviewAndPay: 'Review & Pay',
    pay: 'Place Coffee Order',
    checkoutTitle: 'Coffee Order Summary',
    exitTitle: 'Exit Coffee App',
    exitMessage: 'Are you sure you want to leave the coffee bar?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Brewing In Progress!',
    paymentReceived: 'Our barista is pulling your artisan espresso shot!',
    orderCode: 'Pickup Token',
    orderStatus: 'Live Brewing Telemetry',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'កាហ្វេរសជាតិបុរាណអឺរ៉ុប',
    guestUser: 'អតិថិជនកាហ្វេ',
    searchPlaceholder: 'ស្វែងរកប្រភេទកាហ្វេ...',
    cupSize: 'ទំហំកែវ',
    milkType: 'ជម្រើសទឹកដោះគោ',
    sweetness: 'កម្រិតជាតិផ្អែម',
    iceLevel: 'កម្រិតទឹកកក',
    extraShots: 'បន្ថែមសាច់កាហ្វេ (Shot)',
    customize: 'កែតម្រូវភេសជ្ជៈ',
    orderNow: 'បញ្ចូលក្នុងកន្ត្រក',
    reviewAndPay: 'ពិនិត្យ & បង់ប្រាក់',
    pay: 'បញ្ជាទិញកាហ្វេ',
    checkoutTitle: 'សង្ខេបការបញ្ជាទិញកាហ្វេ',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'កំពុងឆុងកាហ្វេ!',
    paymentReceived: 'បារីស្តាកំពុងកិនគ្រាប់កាហ្វេ និង ឆុងជូនអ្នកយ៉ាងយកចិត្តទុកដាក់!',
    orderCode: 'លេខសម្គាល់ទទួលកាហ្វេ',
    orderStatus: 'ស្ថានភាពឆុងកាហ្វេផ្ទាល់',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '노르딕 아티산 커피',
    guestUser: '커피 애호가',
    searchPlaceholder: '원두, 싱글오리진, 브루잉 검색...',
    cupSize: '컵 사이즈',
    milkType: '우유 및 비건 밀크',
    sweetness: '당도 조절',
    iceLevel: '얼음양',
    extraShots: '샷 추가',
    customize: '음료 커스텀',
    orderNow: '장바구니 담기',
    reviewAndPay: '주문 확인 및 결제',
    pay: '커피 주문 결제',
    checkoutTitle: '커피 주문 확인',
    exitTitle: '커피 앱 종료',
    exitMessage: '주문을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 이용',
    paymentSuccessTitle: '커피 추출 중입니다!',
    paymentReceived: '바리스타가 신선한 원두로 정성스럽게 추출 중입니다!',
    orderCode: '픽업 번호',
    orderStatus: '실시간 바리스타 현황',
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
    try { localStorage.setItem('coffee_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('coffee_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
