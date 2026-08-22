export interface StorageOption {
  size: string; // '128GB' | '256GB' | '512GB' | '1TB'
  priceDelta: number; // e.g. 0, 120, 260
}

export interface ColorOption {
  name: string;
  hex: string;
  bgGradient?: string;
  image: string;
}

export interface PhoneProduct {
  id: string;
  brand: 'Apple' | 'Samsung' | 'Xiaomi' | 'Google' | 'Nothing';
  name: string;
  tagline: string;
  basePrice: number;
  originalPrice?: number;
  rating: number;
  reviewsCount: number;
  badge?: string; // 'New' | 'Best Seller' | '5G Special' | 'Hot Deal'
  isFeatured?: boolean;
  colors: ColorOption[];
  storageOptions: StorageOption[];
  specs: {
    screen: string;
    processor: string;
    camera: string;
    battery: string;
    network: string;
    os: string;
  };
  highlights: string[];
  inStock: boolean;
}

export interface PlanAddon {
  id: string;
  name: string;
  category: 'eSIM' | 'Protection' | 'Data' | 'Accessories';
  price: number;
  validity?: string;
  dataAllowance?: string;
  description: string;
  iconName: string;
  recommended?: boolean;
}

export interface CartItem {
  id: string;
  product: PhoneProduct;
  selectedColor: ColorOption;
  selectedStorage: StorageOption;
  quantity: number;
  selectedAddons?: PlanAddon[];
  tradeInDiscount?: number;
}

export interface OrderRecord {
  orderId: string;
  transactionId?: string;
  date: string;
  items: CartItem[];
  totalAmount: number;
  paymentMethod: string;
  status: 'Processing' | 'Shipped' | 'Delivered' | 'Ready for Pickup';
  imei?: string;
  warrantyExpiry?: string;
  customerName: string;
  customerPhone: string;
}
