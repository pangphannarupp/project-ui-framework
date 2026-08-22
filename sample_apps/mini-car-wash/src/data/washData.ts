import { WashTier } from '../types/wash'

export const WASH_TIERS: WashTier[] = [
  {
    id: 'tier-express',
    name: { en: 'Express Touchless Rinse', km: 'លាងសម្អាតរហ័ស Touchless', ko: '익스프레스 터치리스 세차' },
    price: 6.00,
    durationMins: 5,
    badge: 'Fast & Basic',
    features: ['High-pressure underbody blast', 'Spot-free water rinse', 'Dual air blower dry']
  },
  {
    id: 'tier-lava',
    name: { en: 'Lava Foam & Wheel Blast', km: 'បាញ់ពពុះ Lava & សម្អាតកង់', ko: '라바 폼 & 휠 케어' },
    price: 12.00,
    durationMins: 9,
    badge: 'Popular',
    features: ['Tri-color active lava foam', 'Brake dust wheel scrub', 'Clear coat sealant shine', 'Heated contour dry']
  },
  {
    id: 'tier-ceramic',
    name: { en: 'Ultra Ceramic Shield & Polish', km: 'ស្រោបសេរ៉ាមិច & ប៉ូលាភ្លឺចាំង', ko: '울트라 세라믹 코팅 & 광택' },
    price: 22.00,
    durationMins: 14,
    badge: 'Ultimate Gloss',
    features: ['Graphene ceramic hydrophobic layer', 'Tire wet gloss dressing', 'Bug & tar decontamination', 'Total 360 air dry']
  }
]
