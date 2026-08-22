import { TicketType, AddonItem } from '../types/zoo';

export const AVAILABLE_TICKETS: TicketType[] = [
  {
    id: 'ticket-adult-day',
    name: 'Adult Day Pass',
    category: 'adult',
    tier: 'standard',
    price: 15.00,
    originalPrice: 18.00,
    description: 'Full day access to all open animal exhibits, botanical gardens, and live keeper talks.',
    ageLimit: 'Ages 13 - 59',
    features: [
      'Access to 6 Zoo Zones',
      'Daily Keeper Talk & Feedings',
      'Complimentary Digital Map & Guide',
      'Free WiFi in Park'
    ],
    icon: '🧑',
    badge: 'Popular',
    color: '#10b981'
  },
  {
    id: 'ticket-child-day',
    name: 'Child Explorer Pass',
    category: 'child',
    tier: 'standard',
    price: 8.00,
    originalPrice: 10.00,
    description: 'Special access for young wildlife lovers including kids playground & petting zoo area.',
    ageLimit: 'Ages 3 - 12 (Under 3 Free)',
    features: [
      'Full park zone admission',
      'Access to Kids Petting Farm',
      'Free Junior Ranger Passport & Stamp book',
      'Playground access'
    ],
    icon: '🧒',
    badge: 'Kids Favorite',
    color: '#3b82f6'
  },
  {
    id: 'ticket-senior-day',
    name: 'Senior Citizen Pass',
    category: 'senior',
    tier: 'standard',
    price: 10.00,
    originalPrice: 12.00,
    description: 'Discounted admission for seniors. Wheelchair-accessible pathways throughout the park.',
    ageLimit: 'Ages 60+ with ID',
    features: [
      'Full park admission',
      'Accessible rest lounge access',
      'Priority tram boarding discount'
    ],
    icon: '👴',
    color: '#8b5cf6'
  },
  {
    id: 'ticket-vip-safari',
    name: 'VIP Safari Experience',
    category: 'combo',
    tier: 'vip-safari',
    price: 45.00,
    originalPrice: 55.00,
    description: 'Premium guided tour on an air-conditioned buggy with behind-the-scenes animal encounters.',
    ageLimit: 'All ages welcome',
    features: [
      'Fast-track VIP Gate Entry',
      '2-Hour Private Buggy Tour with Biologist Guide',
      'Exclusive Giraffe & Elephant Feeding Experience',
      'VIP Lounge with Complimentary Refreshments',
      'Free Wildlife Souvenir Photo'
    ],
    icon: '👑',
    badge: 'Best Experience',
    color: '#f59e0b'
  },
  {
    id: 'ticket-night-safari',
    name: 'Twilight & Night Safari',
    category: 'combo',
    tier: 'safari-night',
    price: 24.00,
    originalPrice: 30.00,
    description: 'Witness nocturnal wildlife in their active hours with specialized low-light safari trams.',
    ageLimit: 'Open from 5:30 PM - 9:30 PM',
    features: [
      'Evening Tram Safari through nocturnal zones',
      'Predator feeding spectacle (Lions & Hyenas)',
      'Fire & Wildlife Cultural Show',
      'Glow-in-the-dark wristband'
    ],
    icon: '🌙',
    badge: 'Evening Only',
    color: '#6366f1'
  },
  {
    id: 'ticket-family-combo',
    name: 'Family Adventure Combo (2A + 2C)',
    category: 'combo',
    tier: 'standard',
    price: 39.00,
    originalPrice: 46.00,
    description: 'Great value bundle for 2 Adults and 2 Children. Includes feeding tokens!',
    ageLimit: '2 Adults + 2 Children',
    features: [
      'Day admission for 4 family members',
      '4x Animal Feeding Tokens included',
      '10% Zoo Cafe Discount voucher',
      'Junior Safari Map kit'
    ],
    icon: '👨‍👩‍👧‍👦',
    badge: 'Save 15%',
    color: '#ec4899'
  }
];

export const AVAILABLE_ADDONS: AddonItem[] = [
  {
    id: 'addon-tram-unlimited',
    name: 'Unlimited Safari Tram Pass',
    price: 4.00,
    unit: 'per person',
    description: 'Hop-on hop-off electric tram connecting all 6 zones throughout the day.',
    icon: '🚋',
    recommendedFor: 'Families & Walking Comfort'
  },
  {
    id: 'addon-feeding-tokens',
    name: 'Animal Feeding Token Pack (5 Tokens)',
    price: 6.00,
    unit: 'per pack',
    description: 'Feed giraffes, elephants, petting goats, and tropical birds under keeper supervision.',
    icon: '🥕',
    recommendedFor: 'Interactive Experience'
  },
  {
    id: 'addon-photo-package',
    name: 'Digital Wildlife Photo Pass',
    price: 8.00,
    unit: 'per group',
    description: 'High-res photos taken by park photographers at photo points and animal encounters.',
    icon: '📸',
    recommendedFor: 'Memories'
  },
  {
    id: 'addon-ar-guide',
    name: 'AR Smart Glasses & Audio Guide',
    price: 5.00,
    unit: 'per device',
    description: 'Interactive augmented reality glasses with 3D animal facts in English and Khmer.',
    icon: '🥽',
    recommendedFor: 'Tech Enthusiasts & Kids'
  }
];

export const TIME_SLOTS = [
  { id: 'morning', label: 'Morning Slot (08:30 AM - 12:30 PM)', icon: '🌅', note: 'Best for animal feeding & active animals' },
  { id: 'afternoon', label: 'Afternoon Slot (01:00 PM - 05:00 PM)', icon: '☀️', note: 'Includes main bird shows & talks' },
  { id: 'sunset', label: 'Sunset & Twilight (05:30 PM - 09:00 PM)', icon: '🌇', note: 'Night safari and nocturnal animals' }
];

export const PROMO_CODES: Record<string, { discountPercent: number; description: string }> = {
  'ZOOFUN10': { discountPercent: 10, description: '10% Off Zoo Tickets' },
  'SAFARI20': { discountPercent: 20, description: '20% Special Seasonal Safari Discount' },
  'KIDSFREE': { discountPercent: 15, description: 'Family Special 15% Off' }
};
