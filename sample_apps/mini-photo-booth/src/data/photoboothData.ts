import type { FilmFrameTheme } from '../types/photobooth'

export const FRAME_THEMES: FilmFrameTheme[] = [
  { id: 'th-retro-sepia', name: 'Vintage 1998 Film', borderColor: '#fef3c7', filterEffect: 'VINTAGE_SEPIA', stickerEmoji: '🎞️', bgPattern: 'linear-gradient(135deg, #fef3c7 0%, #fde68a 100%)' },
  { id: 'th-cyber-pink', name: 'Y2K Cyber Hologram', borderColor: '#fbcfe8', filterEffect: 'CYBER_NEON', stickerEmoji: '💖', bgPattern: 'linear-gradient(135deg, #fbcfe8 0%, #f472b6 100%)' },
  { id: 'th-purikura', name: 'Harajuku Sparkle', borderColor: '#e0e7ff', filterEffect: 'PURIKURA_CUTE', stickerEmoji: '✨', bgPattern: 'linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%)' },
  { id: 'th-bw-noir', name: 'Monochrome Noir', borderColor: '#18181b', filterEffect: 'BW_GRAIN', stickerEmoji: '🖤', bgPattern: 'linear-gradient(135deg, #27272a 0%, #09090b 100%)' }
]
