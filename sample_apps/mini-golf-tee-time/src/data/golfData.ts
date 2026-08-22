import type { GolfHole, CaddieProfile } from '../types/golf'

export const GOLF_HOLES: GolfHole[] = [
  { holeNumber: 1, par: 4, distanceYards: 412, handicapIndex: 5, fairwayType: 'STRAIGHT', stimpMeterSpeed: 11.2 },
  { holeNumber: 4, par: 3, distanceYards: 185, handicapIndex: 12, fairwayType: 'ISLAND_GREEN', stimpMeterSpeed: 11.5 },
  { holeNumber: 7, par: 5, distanceYards: 545, handicapIndex: 1, fairwayType: 'DOGLEG_LEFT', stimpMeterSpeed: 11.0 },
  { holeNumber: 18, par: 4, distanceYards: 430, handicapIndex: 3, fairwayType: 'WATER_HAZARD', stimpMeterSpeed: 12.0 }
]

export const CADDIES: CaddieProfile[] = [
  { id: 'cad-1', name: 'Master Caddie James', experienceYears: 12, rating: 5.0, fee: 35.00, specialty: 'Green slope reading & wind calculation' },
  { id: 'cad-2', name: 'Pro Caddie Ryan', experienceYears: 6, rating: 4.9, fee: 25.00, specialty: 'Club distance selection & pin placements' }
]
