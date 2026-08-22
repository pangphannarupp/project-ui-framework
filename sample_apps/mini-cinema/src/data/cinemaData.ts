import { MovieItem, ShowtimeSlot, SnackItem } from '../types/cinema'

export const MOVIES_LIST: MovieItem[] = [
  {
    id: 'mov-1',
    title: 'Avatar: Fire and Ash',
    khmerTitle: 'អាវ៉ាតា៖ ភ្លើងនិងផេះ',
    genre: 'Sci-Fi / Action',
    duration: '162 min',
    rating: 'PG-13',
    poster: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=600&auto=format&fit=crop&q=80',
    banner: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=1200&auto=format&fit=crop&q=80',
    description: 'Return to Pandora with Jake Sully and Neytiri as they confront a fierce new volcanic Ash People clan.',
    director: 'James Cameron',
    cast: ['Sam Worthington', 'Zoe Saldana', 'Sigourney Weaver'],
    formats: ['3D IMAX', '2D Digital', 'VIP Atmos']
  },
  {
    id: 'mov-2',
    title: 'Kingdom of the Planet of the Apes',
    khmerTitle: 'រាជាណាចក្រសត្វស្វា',
    genre: 'Action / Adventure',
    duration: '145 min',
    rating: 'PG-13',
    poster: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=600&auto=format&fit=crop&q=80',
    banner: 'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?w=1200&auto=format&fit=crop&q=80',
    description: 'Many years after Caesar, a young ape embarks on a journey that leads him to question everything he has been taught.',
    director: 'Wes Ball',
    cast: ['Owen Teague', 'Freya Allan', 'Kevin Durand'],
    formats: ['2D Digital', '3D IMAX']
  },
  {
    id: 'mov-3',
    title: 'Dune: Part Two',
    khmerTitle: 'ឌូន៖ វគ្គពីរ',
    genre: 'Sci-Fi / Epic',
    duration: '166 min',
    rating: 'PG-13',
    poster: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=600&auto=format&fit=crop&q=80',
    banner: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&auto=format&fit=crop&q=80',
    description: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    director: 'Denis Villeneuve',
    cast: ['Timothée Chalamet', 'Zendaya', 'Rebecca Ferguson'],
    formats: ['3D IMAX', 'VIP Atmos']
  },
  {
    id: 'mov-4',
    title: 'Kung Fu Panda 4',
    khmerTitle: 'កុងហ្វូផេនដា ៤',
    genre: 'Animation / Family',
    duration: '94 min',
    rating: 'G',
    poster: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=600&auto=format&fit=crop&q=80',
    banner: 'https://images.unsplash.com/photo-1513151233558-d860c5398176?w=1200&auto=format&fit=crop&q=80',
    description: 'Po must train a new warrior when he is chosen to become the spiritual leader of the Valley of Peace.',
    director: 'Mike Mitchell',
    cast: ['Jack Black', 'Awkwafina', 'Viola Davis'],
    formats: ['2D Digital']
  }
]

export const SHOWTIME_SLOTS: ShowtimeSlot[] = [
  { id: 'st-1', time: '11:00 AM', hall: 'Hall 1 (VIP Atmos)', format: 'VIP Atmos', price: 9.50 },
  { id: 'st-2', time: '01:45 PM', hall: 'Hall 3 (IMAX Laser)', format: '3D IMAX', price: 8.00 },
  { id: 'st-3', time: '04:30 PM', hall: 'Hall 2 (Digital 2D)', format: '2D Digital', price: 5.50 },
  { id: 'st-4', time: '07:15 PM', hall: 'Hall 1 (VIP Atmos)', format: 'VIP Atmos', price: 9.50 },
  { id: 'st-5', time: '09:45 PM', hall: 'Hall 3 (IMAX Laser)', format: '3D IMAX', price: 8.00 }
]

export const CINEMA_BRANCHES = [
  'Legend Cinema (Eden Garden)',
  'Major Cineplex (Aeon Mall Sen Sok)',
  'Prime Cineplex (Samai Square)',
  'Legend Premium (Exchange Square)'
]

export const SNACKS_LIST: SnackItem[] = [
  { id: 'sn-1', name: 'Caramel & Butter Popcorn (L)', price: 4.50, description: 'Fresh giant warm popcorn tub', icon: '🍿' },
  { id: 'sn-2', name: 'Combo: 1 Popcorn + 2 Drinks', price: 7.00, description: 'Popcorn + 2 Coke/Sprite cups', icon: '🥤' },
  { id: 'sn-3', name: 'Crispy Cheese Nachos', price: 4.00, description: 'Warm tortilla chips with jalapeño cheese', icon: '🧀' },
  { id: 'sn-4', name: 'Churros with Chocolate Dip', price: 3.50, description: 'Cinnamon sugar dusted churros', icon: '🥨' }
]
