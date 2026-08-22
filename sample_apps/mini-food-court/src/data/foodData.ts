import { FoodItem } from '../types/food'

export const FOOD_ITEMS: FoodItem[] = [
  {
    id: 'f-1',
    name: { en: 'Signature Beef Lok Lak Rice', km: 'បាយសាច់គោឡុកឡាក់', ko: '시그니처 록락 소고기 덮밥' },
    price: 4.50,
    imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80',
    category: 'Mains',
    rating: 4.9,
    prepTime: '10-15m',
    description: 'Wok-tossed black pepper beef cubes with fragrant jasmine rice and crispy fried egg.'
  },
  {
    id: 'f-2',
    name: { en: 'Authentic Khmer Fish Amok', km: 'អាម៉ុកត្រីបុរាណ', ko: '크메르 피시 아목' },
    price: 5.00,
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&auto=format&fit=crop&q=80',
    category: 'Mains',
    rating: 4.8,
    prepTime: '12-18m',
    description: 'Steamed curried river fish in coconut banana leaf boat.'
  },
  {
    id: 'f-3',
    name: { en: 'Crispy Pork & Shrimp Spring Rolls', km: 'ណែមបំពងសាច់ជ្រូកបង្គា', ko: '바삭 돼지고기 새우 춘권' },
    price: 3.20,
    imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=600&auto=format&fit=crop&q=80',
    category: 'Appetizers',
    rating: 4.7,
    prepTime: '5-8m',
    description: 'Hand-rolled golden crispy spring rolls served with sweet garlic chili dip.'
  },
  {
    id: 'f-4',
    name: { en: 'Brown Sugar Pearl Milk Tea', km: 'តែទឹកដោះគោគុជស្ករត្នោត', ko: '흑당 버블 밀크티' },
    price: 2.80,
    imageUrl: 'https://images.unsplash.com/photo-1558857563-b37cfb49a21e?w=600&auto=format&fit=crop&q=80',
    category: 'Drinks',
    rating: 4.9,
    prepTime: '3m',
    description: 'Fresh milk with slow-cooked chewy brown sugar boba pearls.'
  },
  {
    id: 'f-5',
    name: { en: 'Iced Coconut Milk Matcha Latte', km: 'ម៉ាត់ឆាដូងទឹកកក', ko: '아이스 코코넛 말차 라떼' },
    price: 3.00,
    imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=600&auto=format&fit=crop&q=80',
    category: 'Drinks',
    rating: 4.8,
    prepTime: '3m',
    description: 'Ceremonial Uji matcha poured over organic sweet coconut water and milk.'
  },
  {
    id: 'f-6',
    name: { en: 'Mango Sticky Rice with Coconut Cream', km: 'បាយដំណើបស្វាយ', ko: '망고 찹쌀밥 코코넛' },
    price: 3.50,
    imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&auto=format&fit=crop&q=80',
    category: 'Desserts',
    rating: 4.9,
    prepTime: '5m',
    description: 'Sweet ripe honey mango with warm pandan sticky rice and rich salted coconut drizzle.'
  }
]

export const FOOD_CATEGORIES = ['All', 'Mains', 'Appetizers', 'Drinks', 'Desserts']
