export interface FoodItem {
  id: string
  name: Record<string, string>
  price: number
  imageUrl: string
  category: string
  rating: number
  prepTime: string
  description: string
}

export interface FoodModifier {
  id: string
  name: string
  options: { label: string; price: number }[]
}

export interface CartFoodItem {
  item: FoodItem
  quantity: number
  selectedOptions: Record<string, string>
  unitPrice: number
}

export interface FoodOrderRecord {
  id: string
  orderCode: string
  orderType: 'DINE_IN' | 'TAKEAWAY'
  tableNumber: string
  items: CartFoodItem[]
  subtotal: number
  tax: number
  total: number
  status: 'RECEIVED' | 'PREPARING' | 'READY' | 'COMPLETED'
  createdAt: string
  qrValue: string
}
