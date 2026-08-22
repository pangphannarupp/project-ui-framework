import { reactive, computed } from 'vue'
import { FoodItem, CartFoodItem, FoodOrderRecord } from '../types/food'
import { FOOD_ITEMS } from '../data/foodData'

const STORAGE_KEY = 'mini_food_orders_v1'

function loadOrders(): FoodOrderRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveOrders(orders: FoodOrderRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(orders)) } catch (e) {}
}

const state = reactive({
  cart: [] as CartFoodItem[],
  orderType: 'DINE_IN' as 'DINE_IN' | 'TAKEAWAY',
  tableNumber: 'A-12',
  orders: loadOrders(),
  currentOrder: null as FoodOrderRecord | null
})

export function useFoodStore() {
  const addToCart = (item: FoodItem) => {
    const existing = state.cart.find(c => c.item.id === item.id)
    if (existing) {
      existing.quantity++
    } else {
      state.cart.push({
        item,
        quantity: 1,
        selectedOptions: {},
        unitPrice: item.price
      })
    }
  }

  const removeFromCart = (itemId: string) => {
    const idx = state.cart.findIndex(c => c.item.id === itemId)
    if (idx >= 0) {
      if (state.cart[idx].quantity > 1) {
        state.cart[idx].quantity--
      } else {
        state.cart.splice(idx, 1)
      }
    }
  }

  const getItemQuantity = (itemId: string) => {
    const found = state.cart.find(c => c.item.id === itemId)
    return found ? found.quantity : 0
  }

  const clearCart = () => {
    state.cart = []
  }

  const totalCount = computed(() => state.cart.reduce((acc, curr) => acc + curr.quantity, 0))
  const subtotal = computed(() => state.cart.reduce((acc, curr) => acc + curr.unitPrice * curr.quantity, 0))
  const tax = computed(() => Number((subtotal.value * 0.10).toFixed(2)))
  const grandTotal = computed(() => Number((subtotal.value + tax.value).toFixed(2)))

  const createOrder = () => {
    const orderId = 'ORD-' + Math.floor(1000 + Math.random() * 9000)
    const newOrder: FoodOrderRecord = {
      id: orderId,
      orderCode: 'FOOD-' + Math.floor(100000 + Math.random() * 900000),
      orderType: state.orderType,
      tableNumber: state.tableNumber,
      items: JSON.parse(JSON.stringify(state.cart)),
      subtotal: subtotal.value,
      tax: tax.value,
      total: grandTotal.value,
      status: 'PREPARING',
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      qrValue: `${orderId}|${state.orderType}|TABLE_${state.tableNumber}|${grandTotal.value}USD`
    }
    state.orders.unshift(newOrder)
    state.currentOrder = newOrder
    saveOrders(state.orders)
    clearCart()
    return newOrder
  }

  return {
    state,
    addToCart,
    removeFromCart,
    getItemQuantity,
    clearCart,
    totalCount,
    subtotal,
    tax,
    grandTotal,
    createOrder
  }
}
