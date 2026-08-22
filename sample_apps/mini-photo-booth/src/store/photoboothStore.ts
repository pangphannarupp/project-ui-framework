import { reactive } from 'vue'
import type { FilmFrameTheme, PhotoStripSession } from '../types/photobooth'
import { FRAME_THEMES } from '../data/photoboothData'

interface PhotoBoothState {
  selectedTheme: FilmFrameTheme
  selectedLayout: '4_CUT_VERTICAL' | '2X2_GRID' | 'POLAROID_DUO'
  customTextStamp: string
  printCopies: number
  sessions: PhotoStripSession[]
  latestSession: PhotoStripSession | null
}

const state = reactive<PhotoBoothState>({
  selectedTheme: FRAME_THEMES[1], // Cyber Pink
  selectedLayout: '4_CUT_VERTICAL',
  customTextStamp: 'MEMORIES • 2026.08.22',
  printCopies: 2,
  sessions: [],
  latestSession: null
})

export function usePhotoBoothStore() {
  const basePricePerPair = 5.00

  const shootAndPrint = () => {
    const s: PhotoStripSession = {
      id: 'photo-' + Date.now(),
      printPassCode: 'PRINT-' + Math.floor(10000 + Math.random() * 90000),
      theme: state.selectedTheme,
      layoutType: state.selectedLayout,
      timestamp: new Date().toLocaleTimeString(),
      totalPrice: basePricePerPair,
      status: 'READY_TO_PRINT'
    }
    state.sessions.unshift(s)
    state.latestSession = s
    return s
  }

  return { state, basePricePerPair, shootAndPrint }
}
