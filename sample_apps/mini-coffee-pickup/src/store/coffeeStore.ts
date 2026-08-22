import { reactive, computed } from 'vue'
import { CoffeeItem, CoffeeCustomization, CoffeeOrderItem, CoffeeOrderRecord } from '../types/coffee'
import { COFFEE_ITEMS } from '../data/coffeeData'

const STORAGE_KEY = 'mini_coffee_orders_v1'

function loadOrders(): CoffeeOrderRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveOrders(orders: CoffeeOrderRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(orders)) } catch (e) {}
}

const defaultCustomization: CoffeeCustomization = {
  cupSize: 'M',
  milkType: 'Oat Milk (+0.5)',
  sweetness: 50,
  iceLevel: 'Less Ice',
  extraShots: 0
}

const state = reactive({
  cart: [] as CoffeeOrderItem[],
  activeCustomItem: COFFEE_ITEMS[0] as CoffeeItem,
  currentCustom: { ...defaultCustomization } as CoffeeCustomization,
  orders: loadOrders(),
  currentOrder: null as CoffeeOrderRecord | null
})

export function useCoffeeStore() {
  const calculateItemPrice = (item: CoffeeItem, custom: CoffeeCustomization) => {
    let price = item.price
    if (custom.cupSize === 'L') price += 0.80
    if (custom.cupSize === 'S') price -= 0.40
    if (custom.milkType.includes('+0.5')) price += 0.50
    if (custom.extraShots > 0) price += custom.extraShots * 0.70
    return Number(price.toFixed(2))
  }

  const addToCart = (item: CoffeeItem, custom: CoffeeCustomization) => {
    const unitPrice = calculateItemPrice(item, custom)
    state.cart.push({
      item,
      customization: { ...custom },
      quantity: 1,
      unitPrice
    })
  }

  const removeCartItem = (index: number) => {
    state.cart.splice(index, 1)
  }

  const subtotal = computed(() => state.cart.reduce((sum, i) => sum + i.unitPrice * i.quantity, 0))
  const tax = computed(() => Number((subtotal.value * 0.08).toFixed(2)))
  const grandTotal = computed(() => Number((subtotal.value + tax.value).toFixed(2)))

  const createOrder = () => {
    const id = 'COFFEE-' + Math.floor(100 + Math.random() * 900)
    const newOrder: CoffeeOrderRecord = {
      id,
      orderNumber: `BARISTA-${Math.floor(1000 + Math.random() * 9000)}`,
      items: JSON.parse(JSON.stringify(state.cart)),
      pickupTime: 'In 6-8 mins',
      subtotal: subtotal.value,
      tax: tax.value,
      total: grandTotal.value,
      status: 'BREWING',
      createdAt: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      qrValue: `${id}|NORDIC_COFFEE|${grandTotal.value}USD|TOKEN_${Math.floor(1000 + Math.random() * 9000)}`
    }
    state.orders.unshift(newOrder)
    state.currentOrder = newOrder
    saveOrders(state.orders)
    state.cart = []
    return newOrder
  }

  return {
    state,
    calculateItemPrice,
    addToCart,
    removeCartItem,
    subtotal,
    tax,
    grandTotal,
    createOrder
  }
}
