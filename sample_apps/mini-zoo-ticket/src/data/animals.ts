import { ZooZone, AnimalProfile, ShowSchedule } from '../types/zoo';

export const ZOO_ZONES: ZooZone[] = [
  {
    id: 'zone-savanna',
    name: 'African Savanna Safari',
    khmerName: 'វាលស្មៅសាហ្វារី',
    icon: '🦁',
    coverImage: 'https://images.unsplash.com/photo-1516426122078-c23e76319801?w=800&auto=format&fit=crop&q=80',
    accentColor: '#f59e0b',
    description: 'Wide-open grassland biome featuring lions, giraffes, zebras, and majestic African elephants.',
    featuredAnimals: ['African Lion', 'Reticulated Giraffe', 'Plains Zebra', 'African Bush Elephant'],
    totalSpecies: 24,
    highlight: 'Open Safari Tram Drive & Giraffe Feeding Deck'
  },
  {
    id: 'zone-rainforest',
    name: 'Tropical Rainforest Haven',
    khmerName: 'ព្រៃទឹកភ្លៀងត្រូពិក',
    icon: '🐒',
    coverImage: 'https://images.unsplash.com/photo-1534567153574-2b12153a87f0?w=800&auto=format&fit=crop&q=80',
    accentColor: '#10b981',
    description: 'Lush misty jungle canopy sheltering tigers, playful chimpanzees, sun bears, and exotic orchids.',
    featuredAnimals: ['Bengal Tiger', 'Sun Bear', 'Chimpanzee', 'Red Panda'],
    totalSpecies: 38,
    highlight: 'Canopy Walkway & Tiger Glass Tunnel'
  },
  {
    id: 'zone-aviary',
    name: 'Feathered Paradise Aviary',
    khmerName: 'សួនបក្សីឋានសួគ៌',
    icon: '🦜',
    coverImage: 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=800&auto=format&fit=crop&q=80',
    accentColor: '#ec4899',
    description: 'Walk-through giant free-flight aviary with thousands of colorful macaws, flamingos, and toucans.',
    featuredAnimals: ['Scarlet Macaw', 'Greater Flamingo', 'Keel-billed Toucan', 'Bald Eagle'],
    totalSpecies: 56,
    highlight: 'Nectar Feeding & Free Flight Eagle Spectacle'
  },
  {
    id: 'zone-aqua',
    name: 'Ocean Realm & Penguin Cove',
    khmerName: 'អាងសមុទ្រ & ផេនឃ្វីន',
    icon: '🐧',
    coverImage: 'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?w=800&auto=format&fit=crop&q=80',
    accentColor: '#0ea5e9',
    description: 'Sub-zero indoor penguin paradise and crystal aquarium tunnels teeming with sharks, rays, and sea otters.',
    featuredAnimals: ['King Penguin', 'Asian Small-Clawed Otter', 'Sand Tiger Shark', 'Green Sea Turtle'],
    totalSpecies: 42,
    highlight: 'Underwater Tunnel & Daily Penguin March'
  },
  {
    id: 'zone-reptile',
    name: 'Reptile & Nocturnal Kingdom',
    khmerName: 'រូងសត្វល្មូន & សត្វរាត្រី',
    icon: '🦎',
    coverImage: 'https://images.unsplash.com/photo-1508873696983-2df5293cb395?w=800&auto=format&fit=crop&q=80',
    accentColor: '#8b5cf6',
    description: 'Temperature-controlled bioclimatic house harboring Komodo dragons, giant tortoises, chameleons, and pythons.',
    featuredAnimals: ['Komodo Dragon', 'Aldabra Giant Tortoise', 'Veiled Chameleon', 'Reticulated Python'],
    totalSpecies: 30,
    highlight: 'Komodo Live Encounter & Night Reptile Dome'
  }
];

export const ANIMAL_LIST: AnimalProfile[] = [
  {
    id: 'animal-lion',
    name: 'Simba & Nala (African Lions)',
    scientificName: 'Panthera leo',
    species: 'Mammal / Felidae',
    zoneId: 'zone-savanna',
    zoneName: 'African Savanna Safari',
    avatar: '🦁',
    diet: 'Carnivore (Beef, Enrichment meats)',
    origin: 'Sub-Saharan Africa',
    funFact: 'A lion’s roar can be heard up to 8 kilometers (5 miles) away in the wild!',
    status: 'Vulnerable',
    feedingTime: '11:30 AM & 04:30 PM'
  },
  {
    id: 'animal-giraffe',
    name: 'Twiggy & Barnaby (Giraffes)',
    scientificName: 'Giraffa camelopardalis',
    species: 'Mammal / Giraffidae',
    zoneId: 'zone-savanna',
    zoneName: 'African Savanna Safari',
    avatar: '🦒',
    diet: 'Herbivore (Acacia leaves, carrots)',
    origin: 'East African Savanna',
    funFact: 'Giraffes only need between 5 to 30 minutes of sleep in a 24-hour cycle!',
    status: 'Vulnerable',
    feedingTime: '10:00 AM & 02:00 PM (Visitor Interactive)'
  },
  {
    id: 'animal-tiger',
    name: 'Rajah (Bengal Tiger)',
    scientificName: 'Panthera tigris tigris',
    species: 'Mammal / Felidae',
    zoneId: 'zone-rainforest',
    zoneName: 'Tropical Rainforest Haven',
    avatar: '🐯',
    diet: 'Carnivore (Fresh poultry, enrichment bones)',
    origin: 'Southeast Asia & Indian Subcontinent',
    funFact: 'No two tigers have the same stripe pattern—they are unique like human fingerprints!',
    status: 'Endangered',
    feedingTime: '01:30 PM'
  },
  {
    id: 'animal-penguin',
    name: 'Pippin & Splash (King Penguins)',
    scientificName: 'Aptenodytes patagonicus',
    species: 'Aves / Spheniscidae',
    zoneId: 'zone-aqua',
    zoneName: 'Ocean Realm & Penguin Cove',
    avatar: '🐧',
    diet: 'Piscivore (Krill, small fish, squid)',
    origin: 'Sub-Antarctic Islands',
    funFact: 'King penguins can dive to depths of over 300 meters (1000 ft) hunting for fish!',
    status: 'Least Concern',
    feedingTime: '10:30 AM & 03:30 PM (Penguin Parade)'
  },
  {
    id: 'animal-macaw',
    name: 'Rio (Scarlet Macaw)',
    scientificName: 'Ara macao',
    species: 'Aves / Psittacidae',
    zoneId: 'zone-aviary',
    zoneName: 'Feathered Paradise Aviary',
    avatar: '🦜',
    diet: 'Frugivore & Granivore (Nuts, seeds, tropical berries)',
    origin: 'Central & South America',
    funFact: 'Macaws can live up to 50 to 75 years in protective human care and mimic words easily.',
    status: 'Least Concern',
    feedingTime: '09:30 AM & 02:30 PM'
  },
  {
    id: 'animal-elephant',
    name: 'Babu (African Bush Elephant)',
    scientificName: 'Loxodonta africana',
    species: 'Mammal / Elephantidae',
    zoneId: 'zone-savanna',
    zoneName: 'African Savanna Safari',
    avatar: '🐘',
    diet: 'Herbivore (Hay, watermelons, banana trees)',
    origin: 'Southern Africa',
    funFact: 'An elephant trunk contains over 40,000 individual muscles and can lift up to 350 kg!',
    status: 'Endangered',
    feedingTime: '12:00 PM & 03:00 PM'
  },
  {
    id: 'animal-komodo',
    name: 'Draco (Komodo Dragon)',
    scientificName: 'Varanus komodoensis',
    species: 'Reptilia / Varanidae',
    zoneId: 'zone-reptile',
    zoneName: 'Reptile & Nocturnal Kingdom',
    avatar: '🦎',
    diet: 'Carnivore',
    origin: 'Komodo Island, Indonesia',
    funFact: 'The largest living lizard on Earth, capable of growing over 3 meters in length!',
    status: 'Endangered',
    feedingTime: 'Wed & Sat at 02:00 PM'
  }
];

export const DAILY_SHOWS: ShowSchedule[] = [
  {
    id: 'show-1',
    title: 'Wings of Wonder Free-Flight Show',
    location: 'Aviary Amphitheatre',
    time: '10:15 AM & 03:00 PM',
    duration: '25 Mins',
    icon: '🦅',
    zoneId: 'zone-aviary',
    description: 'High-flying eagles, colorful parrots solving puzzles, and falcons swooping over the audience.'
  },
  {
    id: 'show-2',
    title: 'Elephant Splash & Enrichment Talk',
    location: 'Savanna Waterhole Arena',
    time: '11:00 AM & 02:30 PM',
    duration: '30 Mins',
    icon: '🐘',
    zoneId: 'zone-savanna',
    description: 'Watch elephants bathe, swim in deep pools, and learn about conservation efforts.'
  },
  {
    id: 'show-3',
    title: 'Otter & Penguin Feeding Splash',
    location: 'Penguin Cove Pavilion',
    time: '11:45 AM & 03:45 PM',
    duration: '20 Mins',
    icon: '🦦',
    zoneId: 'zone-aqua',
    description: 'Playful Asian small-clawed otters and penguins showing off their acrobatic underwater skills.'
  },
  {
    id: 'show-4',
    title: 'Predator Twilight Feeding Experience',
    location: 'Lions & Tigers Gorge',
    time: '06:30 PM',
    duration: '35 Mins',
    icon: '🔥',
    zoneId: 'zone-savanna',
    description: 'Dramatic low-light night safari predator feeding and interactive conservation talk.'
  }
];
