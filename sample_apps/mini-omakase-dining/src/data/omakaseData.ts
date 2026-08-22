import type { OmakaseSeat, TastingCourse } from '../types/omakase'

export const OMAKASE_SEATS: OmakaseSeat[] = [
  { seatNumber: 1, position: 'CORNER_LEFT', isReserved: false },
  { seatNumber: 2, position: 'CHEF_CENTER', isReserved: false },
  { seatNumber: 3, position: 'CHEF_CENTER', isReserved: true },
  { seatNumber: 4, position: 'CHEF_CENTER', isReserved: false },
  { seatNumber: 5, position: 'CORNER_RIGHT', isReserved: false },
  { seatNumber: 6, position: 'PRIVATE_TATAMI', isReserved: false }
]

export const TASTING_COURSES: TastingCourse[] = [
  { courseNumber: 1, name: { en: 'Otoro Nigiri & White Truffle', km: 'ត្រីធូណាខ្លាញ់ និងផ្សិតត្រុហ្វល', ko: '오토로 니기리 & 화이트 트러플' }, ingredient: 'Wild Bluefin Tuna, Shizuoka Wasabi', sakePairing: 'Dassai 23 Junmai Daiginjo' },
  { courseNumber: 2, name: { en: 'Hokkaido Bafun Uni Toast', km: 'ពងកាំប្រម៉ាអ៊ូនី ហុកកៃដូ', ko: '북해도 바푼 우니 브리오슈' }, ingredient: 'Sea Urchin, Nori Brioche, Caviar', sakePairing: 'Kokuryu Black Dragon' },
  { courseNumber: 3, name: { en: 'A5 Miyazaki Wagyu Sukiyaki', km: 'សាច់គោវ៉ាហ្គ្យូ A5 មីយ៉ាហ្សាគី', ko: 'A5 미야자키 와규 스키야키' }, ingredient: 'Miyazaki Sirloin, Onsen Tamago', sakePairing: 'Juyondai Honmaru' },
  { courseNumber: 4, name: { en: 'Yuzu Blossom Matcha Monaka', km: 'បង្អែមម៉ាត់ឆាយូហ្ស៊ូ', ko: '유자 블라썸 말차 모나카' }, ingredient: 'Uji Matcha Gelato, Crispy Wafer', sakePairing: 'Kyoto Yuzu Liqueur' }
]
