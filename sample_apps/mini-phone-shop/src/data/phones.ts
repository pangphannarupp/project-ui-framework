import { PhoneProduct, PlanAddon } from '../types/phone';

export interface DummyJsonProduct {
  id: number;
  title: string;
  description: string;
  category: string;
  price: number;
  discountPercentage: number;
  rating: number;
  stock: number;
  tags: string[];
  brand?: string;
  sku: string;
  images: string[];
  thumbnail: string;
}

export const FEATURED_PROMOS = [
  {
    id: 'promo-1',
    title: 'iPhone 13 Pro',
    subtitle: 'Pro camera system. Ceramic Shield front.',
    tag: '⚡ 0% Installment',
    bgGradient: 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)',
    accentColor: '#38bdf8',
    productId: '123',
    badge: 'Popular Flagship'
  },
  {
    id: 'promo-2',
    title: 'Samsung Galaxy S10',
    subtitle: 'Dynamic AMOLED Display & Pro-grade Camera.',
    tag: '🎁 Free Wireless Charger',
    bgGradient: 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)',
    accentColor: '#818cf8',
    productId: '133',
    badge: 'Special Offer'
  },
  {
    id: 'promo-3',
    title: 'Realme XT Quad Camera',
    subtitle: '64MP Ultra-clear sensor with Super AMOLED.',
    tag: '🔥 $50 Instant Voucher',
    bgGradient: 'linear-gradient(135deg, #450a0a 0%, #7f1d1d 100%)',
    accentColor: '#f87171',
    productId: '130',
    badge: 'Camera Pro'
  }
];

export const transformDummyProduct = (item: DummyJsonProduct): PhoneProduct => {
  const brand = (item.brand || 'Apple') as any;
  const originalPrice = item.discountPercentage 
    ? Math.round(item.price / (1 - item.discountPercentage / 100))
    : undefined;

  const colorPalettes = [
    { name: 'Space Gray', hex: '#374151' },
    { name: 'Silver Titanium', hex: '#e2e8f0' },
    { name: 'Deep Midnight', hex: '#0f172a' },
    { name: 'Pacific Blue', hex: '#0284c7' }
  ];

  const colors = item.images && item.images.length > 0 
    ? item.images.map((img, i) => ({
        name: colorPalettes[i % colorPalettes.length].name,
        hex: colorPalettes[i % colorPalettes.length].hex,
        image: img
      }))
    : [{ name: 'Default', hex: '#38bdf8', image: item.thumbnail }];

  return {
    id: String(item.id),
    brand: brand,
    name: item.title,
    tagline: item.description,
    basePrice: Math.round(item.price),
    originalPrice: originalPrice,
    rating: item.rating || 4.5,
    reviewsCount: Math.floor(Math.random() * 200) + 20,
    badge: item.stock < 10 ? 'Low Stock' : item.price > 500 ? 'Flagship' : 'Hot Deal',
    colors: colors,
    storageOptions: [
      { size: '128GB', priceDelta: 0 },
      { size: '256GB', priceDelta: 80 },
      { size: '512GB', priceDelta: 180 }
    ],
    specs: {
      screen: '6.5" Super Retina / AMOLED 120Hz',
      processor: `${item.brand || 'Octa-Core'} AI Bionic Processor`,
      camera: 'Ultra HD Multi-lens Sensor System',
      battery: '4,500 mAh with Fast Charging',
      network: '5G Sub-6 / Dual SIM LTE',
      os: item.brand === 'Apple' ? 'iOS' : 'Android with Custom UI'
    },
    highlights: [
      item.description,
      'High dynamic range display',
      'Official brand warranty support'
    ],
    inStock: item.stock > 0
  };
};

export const SAMPLE_PLANS: PlanAddon[] = [
  {
    id: 'plan-esim-5g-unlimited',
    name: '5G Max Unlimited eSIM',
    category: 'eSIM',
    price: 15,
    validity: '30 Days',
    dataAllowance: 'Unlimited 5G Data + 500 Mins',
    description: 'Instant QR code activation. Ultra-high speed 5G data nationwide with free on-net calls.',
    iconName: 'wifi',
    recommended: true
  },
  {
    id: 'plan-esim-tourist',
    name: 'Tourist 5G Roaming Pass',
    category: 'eSIM',
    price: 8,
    validity: '14 Days',
    dataAllowance: '25GB High Speed',
    description: 'Perfect for travelers in Cambodia & SEA. No contract or physical SIM swap needed.',
    iconName: 'globe',
    recommended: false
  },
  {
    id: 'plan-care-plus',
    name: 'Device Care+ Complete (1 Year)',
    category: 'Protection',
    price: 49,
    validity: '365 Days',
    description: 'Covers accidental damage, screen cracked repair, liquid spill & 24/7 express replacement.',
    iconName: 'shield',
    recommended: true
  },
  {
    id: 'addon-fast-charger-65w',
    name: 'GaN 65W Ultra-Fast Charger & Cable',
    category: 'Accessories',
    price: 25,
    description: 'Dual USB-C PD 3.0 ultra-compact charger compatible with iPhone, Galaxy and laptops.',
    iconName: 'zap',
    recommended: false
  },
  {
    id: 'addon-magsafe-case',
    name: 'Magnetic Armor Glass & Case Combo',
    category: 'Accessories',
    price: 18,
    description: 'Military drop-tested protective case with 9H tempered screen shield.',
    iconName: 'box',
    recommended: false
  }
];
