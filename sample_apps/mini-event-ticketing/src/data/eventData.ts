import { ConcertEvent } from '../types/event'

export const CONCERT_EVENTS: ConcertEvent[] = [
  {
    id: 'evt-neon-lights',
    title: 'Neon Odyssey World Tour 2026',
    artist: 'The Midnight Synthesizers & Luna Ray',
    venue: 'Diamond Island National Arena, Hall A',
    date: 'Saturday, 12 Sep 2026',
    time: '07:30 PM (Doors open 06:00 PM)',
    bannerUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=600&auto=format&fit=crop&q=80',
    zones: [
      {
        id: 'z-vip',
        name: { en: 'VIP Soundcheck & Golden Circle', km: 'សំបុត្រ VIP មុខឆាក & Soundcheck', ko: 'VIP 골든서클 & 사운드체크' },
        price: 150.00,
        perks: ['Front-row standing barricade', 'Exclusive LED lightstick', 'Early access soundcheck pass'],
        badge: 'VIP Tier',
        color: '#f59e0b'
      },
      {
        id: 'z-standing',
        name: { en: 'General Admission Floor (Standing)', km: 'សំបុត្រឈរទូទៅ (Ground Floor)', ko: '스탠딩 일반 입장권' },
        price: 65.00,
        perks: ['Direct main floor arena view', 'Official concert poster included'],
        badge: 'Popular',
        color: '#a855f7'
      },
      {
        id: 'z-tier-seat',
        name: { en: 'Grandstand Tiered Seated (Upper)', km: 'សំបុត្រកៅអីអង្គុយ (Upper Tier)', ko: '지정석 스탠드 좌석' },
        price: 40.00,
        perks: ['Numbered cushioned stadium seat', 'Panoramic stage laser visibility'],
        badge: 'Budget Choice',
        color: '#3b82f6'
      }
    ]
  }
]
