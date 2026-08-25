import { ref, computed } from 'vue'

export type LanguageCode = 'en' | 'km'

export const translations = {
  en: {
    appName: 'Cozy Bookstore',
    guestUser: 'BOOK LOVER',
    selectLanguage: 'Please Select Your Language',
    languageSubtitle: 'Choose English or Khmer',
    searchPlaceholder: 'Search by title, author, category...',
    allCategories: 'All Categories',
    formatTitle: 'Available Formats',
    bookDetails: 'Book Details',
    pages: 'Pages',
    published: 'Published',
    publisher: 'Publisher',
    rating: 'Rating',
    buyNow: 'Add to Cart',
    goToCart: 'Go to Cart',
    cartTitle: 'Your Book Cart',
    emptyCart: 'Your cart is empty. Explore our collection!',
    subtotal: 'Subtotal',
    couponDiscount: 'Coupon Discount',
    grandTotal: 'Grand Total',
    applyCoupon: 'Apply Coupon',
    couponSuccess: 'Coupon applied successfully!',
    couponError: 'Invalid coupon code',
    paymentSuccessTitle: 'Purchase Successful!',
    paymentReceived: 'Thank you for your order! Your receipt is generated.',
    receiptCode: 'Order Reference',
    myPasses: 'My Purchased Books',
    checkoutTitle: 'Book Store Checkout',
    exitTitle: 'Exit Bookstore',
    exitMessage: 'Are you sure you want to close the bookstore?',
    yesExit: 'Yes, Close',
    stay: 'Stay',
    pay: 'Confirm & Pay',
    readPreview: 'Read Sample Pages',
    closeReader: 'Close Preview',
    pageOf: 'of',
    firstPage: 'First Page',
    lastPage: 'End of Sample'
  },
  km: {
    appName: 'បណ្ណាគារកក់ក្តៅ',
    guestUser: 'អ្នកស្រឡាញ់សៀវភៅ',
    selectLanguage: 'សូមជ្រើសរើសភាសា',
    languageSubtitle: 'ជ្រើសរើសភាសាអង់គ្លេស ឬភាសាខ្មែរ',
    searchPlaceholder: 'ស្វែងរកតាមចំណងជើង អ្នកនិពន្ធ ចំណាត់ថ្នាក់...',
    allCategories: 'គ្រប់ចំណាត់ថ្នាក់',
    formatTitle: 'ទម្រង់ដែលមាន',
    bookDetails: 'ព័ត៌មានលម្អិតសៀវភៅ',
    pages: 'ទំព័រ',
    published: 'បោះពុម្ពផ្សាយ',
    publisher: 'អ្នកបោះពុម្ពផ្សាយ',
    rating: 'ការវាយតម្លៃ',
    buyNow: 'ដាក់ក្នុងកន្ត្រក',
    goToCart: 'ទៅកាន់កន្ត្រក',
    cartTitle: 'កន្ត្រកសៀវភៅរបស់អ្នក',
    emptyCart: 'កន្ត្រករបស់អ្នកទទេស្អាត។ សូមស្វែងរកសៀវភៅដែលអ្នកចូលចិត្ត!',
    subtotal: 'សរុបរង',
    couponDiscount: 'ការបញ្ចុះតម្លៃពីកូប៉ុង',
    grandTotal: 'ទឹកប្រាក់សរុប',
    applyCoupon: 'ប្រើប្រាស់កូប៉ុង',
    couponSuccess: 'កូប៉ុងត្រូវបានប្រើប្រាស់ដោយជោគជ័យ!',
    couponError: 'លេខកូដកូប៉ុងមិនត្រឹមត្រូវ',
    paymentSuccessTitle: 'ការទិញទទួលបានជោគជ័យ!',
    paymentReceived: 'សូមអរគុណសម្រាប់ការបញ្ជាទិញរបស់អ្នក! វិក្កយបត្រត្រូវបានបង្កើតឡើង។',
    receiptCode: 'លេខសំគាល់ការបញ្ជាទិញ',
    myPasses: 'សៀវភៅដែលបានទិញ',
    checkoutTitle: 'ការទូទាត់សៀវភៅ',
    exitTitle: 'ចាកចេញពីបណ្ណាគារ',
    exitMessage: 'តើអ្នកពិតជាចង់ចាកចេញពីបណ្ណាគារមែនទេ?',
    yesExit: 'បាទ/ចាស ចាកចេញ',
    stay: 'នៅបន្ត',
    pay: 'បញ្ជាក់ & បង់ប្រាក់',
    readPreview: 'អានទំព័រគំរូ',
    closeReader: 'បិទការអានគំរូ',
    pageOf: 'នៃ',
    firstPage: 'ទំព័រដំបូង',
    lastPage: 'ចុងបញ្ចប់នៃគំរូ'
  }
}

export const supportedLanguages = [
  { code: 'en' as LanguageCode, name: 'English', subname: 'English (US)', flag: '🇺🇸' },
  { code: 'km' as LanguageCode, name: 'ភាសាខ្មែរ', subname: 'Khmer', flag: '🇰🇭' }
]

const currentLanguage = ref<LanguageCode>('en')

export function useI18n() {
  const setLanguage = (lang: LanguageCode) => {
    currentLanguage.value = lang
    try { localStorage.setItem('book_lang', lang) } catch (e) {}
  }
  try {
    const s = localStorage.getItem('book_lang') as LanguageCode
    if (s && ['en', 'km'].includes(s)) currentLanguage.value = s
  } catch (e) {}

  const t = computed(() => (translations as any)[currentLanguage.value] || translations.en)
  const currentLangObj = computed(() => supportedLanguages.find(l => l.code === currentLanguage.value) || supportedLanguages[0])

  return { currentLanguage, supportedLanguages, setLanguage, t, currentLangObj }
}
