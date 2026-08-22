export interface FilmFrameTheme {
  id: string
  name: string
  borderColor: string
  filterEffect: 'VINTAGE_SEPIA' | 'CYBER_NEON' | 'PURIKURA_CUTE' | 'BW_GRAIN'
  stickerEmoji: string
  bgPattern: string
}

export interface PhotoStripSession {
  id: string
  printPassCode: string
  theme: FilmFrameTheme
  layoutType: '4_CUT_VERTICAL' | '2X2_GRID' | 'POLAROID_DUO'
  timestamp: string
  totalPrice: number
  status: 'READY_TO_PRINT'
}
