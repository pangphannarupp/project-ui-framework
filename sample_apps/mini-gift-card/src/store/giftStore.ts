import { reactive } from 'vue'
import { GiftCardTheme, GiftCardOrderRecord } from '../types/gift'
import { GIFT_THEMES } from '../data/giftData'

const STORAGE_KEY = 'mini_gift_cards_v1'

function loadOrders(): GiftCardOrderRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveOrders(list: GiftCardOrderRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedTheme: GIFT_THEMES[0] as GiftCardTheme,
  selectedAmount: 50,
  recipientName: 'Sarah Jenkins',
  recipientEmail: 'sarah.j@example.com',
  customMessage: 'Wishing you the happiest birthday filled with joy and sweetness!',
  orders: loadOrders(),
  currentOrder: null as GiftCardOrderRecord | null
})

export function useGiftStore() {
  const purchaseGiftCard = () => {
    const id = 'GIFT-' + Math.floor(100 + Math.random() * 900)
    const vCode = `GIFT-${Math.floor(1000 + Math.random() * 9000)}-${Math.floor(1000 + Math.random() * 9000)}`
    const rec: GiftCardOrderRecord = {
      id,
      voucherCode: vCode,
      theme: state.selectedTheme,
      amount: state.selectedAmount,
      recipientName: state.recipientName,
      recipientEmail: state.recipientEmail,
      customMessage: state.customMessage,
      totalPaid: state.selectedAmount,
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      qrValue: `${id}|${vCode}|VAL_${state.selectedAmount}USD|NOT_REDEEMED`,
      redeemed: false
    }
    state.orders.unshift(rec)
    state.currentOrder = rec
    saveOrders(state.orders)
    return rec
  }

  return {
    state,
    purchaseGiftCard
  }
}
