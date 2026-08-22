import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km' | 'ko'

export const translations = {
  en: {
    appName: 'Smart Food Court',
    guestUser: 'FOOD LOVER GUEST',
    searchPlaceholder: 'Search dishes, drinks, desserts...',
    dineIn: 'Dine In (Table QR)',
    takeaway: 'Takeaway Pick Up',
    tableNumber: 'Table No.',
    items: 'items',
    total: 'Total',
    subtotal: 'Subtotal',
    vatTax: 'VAT Tax (10%)',
    grandTotal: 'Grand Total',
    reviewAndPay: 'Review & Pay',
    pay: 'Pay Now',
    orderSummary: 'Order Summary',
    emptyCart: 'No food added yet. Please select items from the menu.',
    browseMenu: 'Browse Menu',
    checkoutTitle: 'Food Order Checkout',
    exitTitle: 'Exit Food Court',
    exitMessage: 'Are you sure you want to exit food ordering?',
    yesExit: 'Yes, Exit',
    stay: 'Stay',
    paymentSuccessTitle: 'Order Placed Successfully!',
    paymentReceived: 'Kitchen is preparing your delicious order!',
    orderCode: 'Order Token',
    orderStatus: 'Live Order Tracker',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English, Khmer or Korean'
  },
  km: {
    appName: 'អាហារដ្ឋានឆ្លាតវៃ',
    guestUser: 'ភ្ញៀវអាហារដ្ឋាន',
    searchPlaceholder: 'ស្វែងរកមុខម្ហូប ភេសជ្ជៈ បង្អែម...',
    dineIn: 'ញ៉ាំនៅកន្លែង (តុ)',
    takeaway: 'ខ្ចប់ទៅផ្ទះ',
    tableNumber: 'លេខតុ',
    items: 'មុខ',
    total: 'សរុប',
    subtotal: 'សរុបរង',
    vatTax: 'អាករលើតម្លៃបន្ថែម (10%)',
    grandTotal: 'ទឹកប្រាក់សរុប',
    reviewAndPay: 'ពិនិត្យ & បង់ប្រាក់',
    pay: 'បង់ប្រាក់ឥឡូវនេះ',
    orderSummary: 'សង្ខេបការកុម្ម៉ង់',
    emptyCart: 'មិនទាន់មានមុខម្ហូបត្រូវបានជ្រើសរើសទេ។',
    browseMenu: 'មើលមុខម្ហូប',
    checkoutTitle: 'ការទូទាត់ប្រាក់',
    exitTitle: 'ចាកចេញពីកម្មវិធី',
    exitMessage: 'តើអ្នកប្រាកដជាចង់ចាកចេញមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    paymentSuccessTitle: 'ការកុម្ម៉ង់ទទួលបានជោគជ័យ!',
    paymentReceived: 'ចុងភៅកំពុងរៀបចំម្ហូបដ៏ឈ្ងុយឆ្ងាញ់ជូនអ្នក!',
    orderCode: 'លេខសម្គាល់កុម្ម៉ង់',
    orderStatus: 'តាមដានស្ថានភាពម្ហូប',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើស ភាសាអង់គ្លេស ខ្មែរ ឬ កូរ៉េ'
  },
  ko: {
    appName: '스마트 푸드코트',
    guestUser: '푸드코트 방문객',
    searchPlaceholder: '메뉴, 음료, 디저트 검색...',
    dineIn: '매장 식사 (테이블 QR)',
    takeaway: '포장 주문',
    tableNumber: '테이블 번호',
    items: '개',
    total: '합계',
    subtotal: '소계',
    vatTax: '부가가치세 (10%)',
    grandTotal: '총 결제금액',
    reviewAndPay: '주문 확인 및 결제',
    pay: '결제하기',
    orderSummary: '주문 내역',
    emptyCart: '선택된 메뉴가 없습니다. 메뉴를 선택해 주세요.',
    browseMenu: '메뉴 둘러보기',
    checkoutTitle: '푸드코트 주문 결제',
    exitTitle: '푸드코트 종료',
    exitMessage: '주문을 종료하시겠습니까?',
    yesExit: '예, 종료합니다',
    stay: '계속 주문',
    paymentSuccessTitle: '주문이 성공적으로 접수되었습니다!',
    paymentReceived: '주방에서 음식을 정성껏 조리 중입니다!',
    orderCode: '주문 번호',
    orderStatus: '실시간 조리 현황',
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
    try { localStorage.setItem('food_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('food_lang') as LanguageCode
    if (s && ['en', 'km', 'ko'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
