import { CoffeeItem } from '../types/coffee'

export const COFFEE_ITEMS: CoffeeItem[] = [
  {
    id: 'c-1',
    name: { en: 'Nordic Oat Milk Cortado', km: 'ខកតាដូទឹកដោះគោអូត', ko: '노르딕 오트 코르타도' },
    price: 3.80,
    imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=600&auto=format&fit=crop&q=80',
    category: 'Espresso',
    roastLevel: 'Light Cinnamon Roast',
    notes: 'Jasmine blossom, bergamot, creamy honey',
    description: 'Equal parts single-origin Ethiopian espresso and velvety steamed organic Swedish oat milk.'
  },
  {
    id: 'c-2',
    name: { en: 'Single-Origin Flat White', km: 'ហ្វ្លែតវ៉ាយពិសេស', ko: '싱글오리진 플랫화이트' },
    price: 3.50,
    imageUrl: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=600&auto=format&fit=crop&q=80',
    category: 'Espresso',
    roastLevel: 'Medium Roast',
    notes: 'Dark chocolate, toasted hazelnut, vanilla',
    description: 'Double ristretto shot with microfoam silky textured milk.'
  },
  {
    id: 'c-3',
    name: { en: 'Kyoto Cold Drip Elixir', km: 'កាហ្វេត្រជាក់ក្យូតូ', ko: '교토 콜드드립' },
    price: 4.20,
    imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=600&auto=format&fit=crop&q=80',
    category: 'Slow Drip',
    roastLevel: 'Light Roast',
    notes: 'Black tea, candied citrus, dark rum finish',
    description: 'Slow 12-hour tower extraction for crisp, low-acidity clean caffeine clarity.'
  },
  {
    id: 'c-4',
    name: { en: 'Cardamom Cinnamon Dirty Latte', km: 'ឌើតធីឡាតេក្រវាញ', ko: '카다멈 시나몬 더티 라떼' },
    price: 4.00,
    imageUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=600&auto=format&fit=crop&q=80',
    category: 'Specialty',
    roastLevel: 'Medium-Dark',
    notes: 'Warm cardamom spice, Ceylon cinnamon, brown butter',
    description: 'Hot espresso poured over ice-cold layered whole milk infused with freshly crushed green cardamom.'
  },
  {
    id: 'c-5',
    name: { en: 'Ceremonial Uji Matcha Latte', km: 'ម៉ាត់ឆាឡាតេជប៉ុន', ko: '우지 말차 라떼' },
    price: 4.50,
    imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=600&auto=format&fit=crop&q=80',
    category: 'Non-Coffee',
    roastLevel: 'First Harvest Green Tea',
    notes: 'Sweet umami, fresh cut grass, silky texture',
    description: 'Whisked first-harvest Kyoto Uji ceremonial grade matcha with sweet textured milk.'
  }
]

export const COFFEE_CATEGORIES = ['All', 'Espresso', 'Slow Drip', 'Specialty', 'Non-Coffee']
