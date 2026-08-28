import { reactive, computed } from 'vue'

export interface Product {
  id: string
  name: string
  price: number
  image: string
  category: string
  description?: string
}

export interface CartItem extends Product {
  quantity: number
}

const state = reactive({
  items: [] as CartItem[]
})

export const cartStore = {
  get items() {
    return state.items
  },
  
  get total() {
    return state.items.reduce((acc, item) => acc + (item.price * item.quantity), 0)
  },

  get itemCount() {
    return state.items.reduce((acc, item) => acc + item.quantity, 0)
  },

  addToCart(product: Product) {
    const existing = state.items.find(item => item.id === product.id)
    if (existing) {
      existing.quantity++
    } else {
      state.items.push({ ...product, quantity: 1 })
    }
  },

  removeFromCart(productId: string) {
    const index = state.items.findIndex(item => item.id === productId)
    if (index > -1) {
      state.items.splice(index, 1)
    }
  },

  updateQuantity(productId: string, quantity: number) {
    const item = state.items.find(i => i.id === productId)
    if (item) {
      if (quantity <= 0) {
        this.removeFromCart(productId)
      } else {
        item.quantity = quantity
      }
    }
  },
  
  clearCart() {
    state.items = []
  }
}
