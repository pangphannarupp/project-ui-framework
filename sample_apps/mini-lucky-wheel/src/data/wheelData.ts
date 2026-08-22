import { WheelPrize } from '../types/wheel'

export const WHEEL_PRIZES: WheelPrize[] = [
  { id: 'p-1', label: '$5 Voucher', color: '#f59e0b', textColor: '#000000', icon: '💵', value: '$5 Store Credit', probability: 0.2 },
  { id: 'p-2', label: 'Free Drink', color: '#3b82f6', textColor: '#ffffff', icon: '🧋', value: '1x Boba Milk Tea', probability: 0.25 },
  { id: 'p-3', label: '1000 Points', color: '#10b981', textColor: '#ffffff', icon: '⭐', value: '1,000 Loyalty Pts', probability: 0.2 },
  { id: 'p-4', label: 'Cinema Ticket', color: '#8b5cf6', textColor: '#ffffff', icon: '🎬', value: '1x Free Movie Pass', probability: 0.1 },
  { id: 'p-5', label: 'Mega $50 Cash', color: '#ef4444', textColor: '#ffffff', icon: '🏆', value: '$50 Cash Prize', probability: 0.05 },
  { id: 'p-6', label: 'Lucky Try Again', color: '#64748b', textColor: '#ffffff', icon: '🍀', value: '+1 Bonus Spin', probability: 0.2 }
]
