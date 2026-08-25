import { reactive, computed } from 'vue'
import type { Book, CartItem, BookOrder } from '../types/book'
import { FORMAT_MULTIPLIERS } from '../data/bookData'

interface StoreState {
  cart: CartItem[]
  selectedBook: Book | null
  selectedFormat: string
  passengerName: string
  passengerPhone: string
  orders: BookOrder[]
  couponCode: string
  couponDiscount: number
}

const state = reactive<StoreState>({
  cart: [],
  selectedBook: null,
  selectedFormat: 'Hardcover',
  passengerName: 'BOOK GUEST',
  passengerPhone: '+855 12 345 678',
  orders: [],
  couponCode: '',
  couponDiscount: 0
})

const getFormatPrice = (book: Book, format: string): number => {
  const multiplier = FORMAT_MULTIPLIERS[format] || 1.0
  return Number((book.price * multiplier).toFixed(2))
}

const addToCart = (book: Book, format: string) => {
  const price = getFormatPrice(book, format)
  const existing = state.cart.find(item => item.book.id === book.id && item.format === format)
  if (existing) {
    existing.quantity++
  } else {
    state.cart.push({ book, format, price, quantity: 1 })
  }
}

const removeFromCart = (bookId: string, format: string) => {
  const idx = state.cart.findIndex(item => item.book.id === bookId && item.format === format)
  if (idx > -1) {
    if (state.cart[idx].quantity > 1) {
      state.cart[idx].quantity--
    } else {
      state.cart.splice(idx, 1)
    }
  }
}

const clearCart = () => {
  state.cart = []
  state.couponCode = ''
  state.couponDiscount = 0
}

const applyCoupon = (code: string): boolean => {
  if (code.toUpperCase() === 'READCOZY10') {
    state.couponCode = code
    state.couponDiscount = 0.1 // 10% off
    return true
  }
  return false
}

const subtotal = computed(() => {
  return state.cart.reduce((sum, item) => sum + item.price * item.quantity, 0)
})

const discountAmount = computed(() => {
  return subtotal.value * state.couponDiscount
})

const grandTotal = computed(() => {
  const total = subtotal.value - discountAmount.value
  return Number(Math.max(0, total).toFixed(2))
})

const createOrder = (): BookOrder => {
  const code = 'BK-' + Math.floor(100000 + Math.random() * 900000)
  const order: BookOrder = {
    id: 'ord_' + Date.now(),
    items: [...state.cart],
    customerName: state.passengerName,
    customerPhone: state.passengerPhone,
    orderDate: new Date().toLocaleDateString(),
    totalAmount: grandTotal.value,
    paymentStatus: 'SUCCESS',
    receiptCode: code
  }
  state.orders.push(order)
  clearCart()
  return order
}

export function useBookStore() {
  return {
    state,
    getFormatPrice,
    addToCart,
    removeFromCart,
    clearCart,
    applyCoupon,
    subtotal,
    discountAmount,
    grandTotal,
    createOrder
  }
}
