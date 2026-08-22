import type { SpaRitual } from '../types/spa'

export const SPA_RITUALS: SpaRitual[] = [
  {
    id: 'rit-onsen-zen',
    name: { en: 'Thermal Onsen & Hinoki Herbal Bath', km: 'ត្រាំទឹកក្ដៅធម្មជាតិ និងស្ទីមឱសថបុរាណ', ko: '히노키 온천욕 & 허브 스팀 입욕' },
    durationMins: 90,
    price: 85.00,
    steps: ['Mineral Hot Spring Soak (41°C)', 'Aromatherapy Steam Mist', 'Scalp Tension Release', 'Organic Matcha Tea'],
    essentialOil: 'LAVENDER'
  },
  {
    id: 'rit-lava-stone',
    name: { en: 'Warm Himalayan Salt & Lava Stone Massage', km: 'ម៉ាស្សាថ្មក្ដៅ និងអំបិលហិម៉ាឡៃ', ko: '히말라야 핑크 솔트 & 핫 라바 스톤' },
    durationMins: 120,
    price: 135.00,
    steps: ['Dead Sea Salt Scrub', 'Heated Basalt Stone Placement', 'Deep Muscle Essential Oil Massage', 'Sound Bowl Meditation'],
    essentialOil: 'SANDALWOOD'
  }
]
