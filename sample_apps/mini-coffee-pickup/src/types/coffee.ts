export interface CoffeeItem {
  id: string
  name: Record<string, string>
  price: number
  imageUrl: string
  category: string
  roastLevel: string
  notes: string
  description: string
}

export interface CoffeeCustomization {
  cupSize: 'S' | 'M' | 'L'
  milkType: 'Whole Milk' | 'Oat Milk (+0.5)' | 'Almond Milk (+0.5)' | 'Soy Milk'
  sweetness: number // 0, 25, 50, 75, 100
  iceLevel: 'No Ice' | 'Less Ice' | 'Regular Ice' | 'Extra Ice'
  extraShots: number
}

export interface CoffeeOrderItem {
  item: CoffeeItem
  customization: CoffeeCustomization
  quantity: number
  unitPrice: number
}

export interface CoffeeOrderRecord {
  id: string
  orderNumber: string
  items: CoffeeOrderItem[]
  pickupTime: string
  subtotal: number
  tax: number
  total: number
  status: 'QUEUED' | 'GRINDING' | 'BREWING' | 'READY_FOR_PICKUP'
  createdAt: string
  qrValue: string
}
