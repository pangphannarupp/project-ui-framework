import { HotelSuite } from '../types/hotel'

export const HOTEL_SUITES: HotelSuite[] = [
  {
    id: 's-presidential',
    name: { en: 'Grand Champagne Penthouse', km: 'បន្ទប់វីអាយភីប្រណិត', ko: '그랜드 샴페인 펜트하우스' },
    tier: 'Signature Penthouse',
    pricePerNight: 280.00,
    imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=600&auto=format&fit=crop&q=80',
    sqm: 120,
    bedType: '1 King Size Velvet Bed',
    amenities: ['Private Jacuzzi Balcony', '24/7 Butler Service', 'Champagne Bar', 'Hermès Toiletries'],
    description: 'Ultra-luxurious high-floor corner suite with panoramic skyline views and private whirlpool jacuzzi.'
  },
  {
    id: 's-executive',
    name: { en: 'Skyline Executive Suite', km: 'បន្ទប់ស្កាយឡាញ អ៊ិចស៊ីឃ្យូធីវ', ko: '스카이라인 이그제큐티브 스위트' },
    tier: 'Executive Suite',
    pricePerNight: 160.00,
    imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?w=600&auto=format&fit=crop&q=80',
    sqm: 65,
    bedType: '1 California King Bed',
    amenities: ['Floor-to-Ceiling Windows', 'Espresso Bar', 'Dyson Haircare', 'Lounge Access'],
    description: 'Sophisticated modern layout designed for both relaxing stays and executive productivity.'
  },
  {
    id: 's-deluxe',
    name: { en: 'Deluxe Velvet Studio', km: 'បន្ទប់ស្ទូឌីយោ វ៉ែលវេត', ko: '디럭스 벨벳 스튜디오' },
    tier: 'Deluxe Studio',
    pricePerNight: 95.00,
    imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=600&auto=format&fit=crop&q=80',
    sqm: 42,
    bedType: '1 Queen Plush Bed',
    amenities: ['Smart Ambient Lighting', 'Rain Shower', 'High-Speed Wi-Fi', 'Artisan Mini Bar'],
    description: 'Cozy boutique aesthetic room with custom velvet headboard and mood ambient lighting.'
  }
]
