import { GiftCardTheme } from '../types/gift'

export const GIFT_THEMES: GiftCardTheme[] = [
  { id: 't-bday', title: 'Happy Birthday Celebration', category: 'BIRTHDAY', gradient: 'linear-gradient(135deg, #f43f5e, #fb7185)', cardArtEmoji: '🎂' },
  { id: 't-thanks', title: 'With Sincere Gratitude', category: 'THANK_YOU', gradient: 'linear-gradient(135deg, #8b5cf6, #c084fc)', cardArtEmoji: '💐' },
  { id: 't-love', title: 'Sending Warm Hugs & Love', category: 'LOVE', gradient: 'linear-gradient(135deg, #ec4899, #f472b6)', cardArtEmoji: '💖' },
  { id: 't-cheers', title: 'Golden Congratulations', category: 'CELEBRATION', gradient: 'linear-gradient(135deg, #f59e0b, #fbbf24)', cardArtEmoji: '🥂' }
]

export const PRESET_AMOUNTS = [10, 25, 50, 100, 200]
