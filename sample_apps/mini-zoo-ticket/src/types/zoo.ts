export type TicketTier = 'standard' | 'safari-night' | 'vip-safari' | 'annual-pass';

export interface TicketType {
  id: string;
  name: string;
  category: 'adult' | 'child' | 'senior' | 'combo';
  tier: TicketTier;
  price: number;
  originalPrice?: number;
  description: string;
  ageLimit?: string;
  features: string[];
  icon: string;
  badge?: string;
  color: string;
}

export interface AddonItem {
  id: string;
  name: string;
  price: number;
  unit: string;
  description: string;
  icon: string;
  recommendedFor?: string;
}

export interface SelectedTicket {
  ticket: TicketType;
  quantity: number;
}

export interface SelectedAddon {
  addon: AddonItem;
  quantity: number;
}

export interface VisitorInfo {
  fullName: string;
  email: string;
  phone: string;
  idOrPassport?: string;
  specialRequests?: string;
  agreeTerms: boolean;
}

export interface ZooZone {
  id: string;
  name: string;
  khmerName?: string;
  icon: string;
  coverImage: string;
  accentColor: string;
  description: string;
  featuredAnimals: string[];
  totalSpecies: number;
  highlight: string;
}

export interface AnimalProfile {
  id: string;
  name: string;
  scientificName: string;
  species: string;
  zoneId: string;
  zoneName: string;
  avatar: string;
  diet: string;
  origin: string;
  funFact: string;
  status: 'Least Concern' | 'Vulnerable' | 'Endangered' | 'Critically Endangered';
  feedingTime: string;
}

export interface ShowSchedule {
  id: string;
  title: string;
  location: string;
  time: string;
  duration: string;
  icon: string;
  zoneId: string;
  description: string;
}

export interface BookedTicketRecord {
  id: string;
  bookingCode: string;
  purchaseDate: string;
  visitDate: string;
  timeSlot: string;
  tickets: SelectedTicket[];
  addons: SelectedAddon[];
  visitor: VisitorInfo;
  subtotal: number;
  discount: number;
  tax: number;
  total: number;
  promoCode?: string;
  paymentMethod: string;
  status: 'CONFIRMED' | 'USED' | 'CANCELLED';
  qrValue: string;
}
