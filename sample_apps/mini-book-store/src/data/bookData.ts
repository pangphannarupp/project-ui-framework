import type { Book } from '../types/book'

export const BOOK_CATEGORIES = ['All', 'Fiction & Literature', 'Philosophy & Essays', 'Mystery & Thriller', 'History & Science']

export const BOOK_FORMATS = ['Hardcover', 'Paperback', 'E-book', 'Audiobook']

export const FORMAT_MULTIPLIERS: Record<string, number> = {
  'Hardcover': 1.0,
  'Paperback': 0.8,
  'E-book': 0.5,
  'Audiobook': 0.6
}

export const BOOK_DATABASE: Book[] = [
  {
    id: '1',
    title: 'The Shadow of the Oak',
    author: 'Alistair Vance',
    category: 'Fiction & Literature',
    price: 18.99,
    rating: 4.8,
    reviewsCount: 124,
    publishedYear: 2024,
    publisher: 'Archway Press',
    pages: 320,
    coverUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&q=80&w=400',
    description: 'A hauntingly beautiful tale of a long-forgotten family manor in the English countryside, where every rustle of the ancient oak tree outside holds secrets of a forgotten generation.',
    formats: ['Hardcover', 'Paperback', 'E-book'],
    samplePages: [
      "CHAPTER I\n\nThe winter of 1894 was the coldest on record. The frost clung to the window panes like delicate crystal lace, and the wind howled through the valley, carrying the scent of dry pine and distant sea salt. Alistair Vance sat near the crackling fireplace, a copper kettle whistling softly. His father's letter lay unopened on the mahogany table.",
      "The letter was written in a trembling hand, the ink faded to a dull charcoal grey. It spoke of a secret chamber buried beneath the root structures of the ancient oak that stood in the eastern courtyard. 'Alistair,' the letter read, 'do not let the house fall into decay. What is buried beneath the tree must never see the light of day, yet it must be guarded at all costs.'",
      "He took a slow sip of his black tea, staring into the embers. The oak tree had always cast a long, menacing shadow across his childhood bedroom. He remembered the faint tapping of branches against the brickwork, like bone fingers searching for a way inside. Tomorrow, the solicitors would arrive to sign away the estate, unless he could find the truth."
    ]
  },
  {
    id: '2',
    title: 'Meditations on Solitude',
    author: 'Clara Montaigne',
    category: 'Philosophy & Essays',
    price: 14.50,
    rating: 4.9,
    reviewsCount: 98,
    publishedYear: 2023,
    publisher: 'Meridian Leaf',
    pages: 210,
    coverUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=400',
    description: 'A deep philosophical exploration of the human condition in moments of quiet. Montaigne argues that modern society is plagued by a fear of silence, and offers practical reflections on how to reclaim our inner peace.',
    formats: ['Paperback', 'E-book', 'Audiobook'],
    samplePages: [
      "INTRODUCTION\n\nIn the noise of the marketplace, we lose the thread of our own thoughts. We run from room to room, seeking the chatter of companions, the distraction of novelty, the heavy hum of machine work. We have forgotten how to sit quietly in a room. To be alone is not to be empty; it is to be full of the world's quietest truths.",
      "Solitude is the sanctuary of the mind. In silence, the dust of daily worries settles, and the waters of consciousness run clear. When we look inward without fear, we discover that the self is not a lonely island, but a vast continent connected by deep undercurrents to all living things. Let us sit then, and simply listen.",
      "CHAPTER II: THE FEAR OF SILENCE\n\nWhy does the modern soul dread the silent hour? Because in the quiet, the illusions of importance crumble. We are forced to ask ourselves: who are we when we are not busy? We find that we are strangers to our own minds. Reclaiming solitude requires courage, the patience to sit through the initial restlessness."
    ]
  },
  {
    id: '3',
    title: 'Murder at Cobble Street',
    author: 'Raymond Finch',
    category: 'Mystery & Thriller',
    price: 16.99,
    rating: 4.7,
    reviewsCount: 231,
    publishedYear: 2024,
    publisher: 'Black Ink Co.',
    pages: 280,
    coverUrl: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&q=80&w=400',
    description: 'When a prominent watchmaker is found dead in his locked study on Cobble Street, Inspector Holloway must untangle a web of secrets, stolen gears, and midnight rendezvous.',
    formats: ['Hardcover', 'Paperback', 'Audiobook'],
    samplePages: [
      "CHAPTER I: THE CLOCK STOPS\n\nThe watchmaker was dead. Not simply dead, but posed. He sat at his workbench, his head resting gently on his arms as if asleep. But the blood pool surrounding the brass gears told a different story. In his hand, he held a key of exquisite craftsmanship, one that did not fit any clock in the room.",
      "Inspector Holloway stood by the door, rain dripping from his heavy wool coat. The fireplace was cold, indicating the crime had happened hours before. 'No signs of forced entry,' the constable murmured, scribbling in his pocketbook. 'The windows are bolted from the inside. The lock on the main door is unbroken. It is a sealed room, sir.'",
      "Holloway stepped closer to the workbench. A giant pendulum clock against the wall was frozen at exactly 3:14 AM. The pendulum had been stopped manually, wedged with a small folded piece of parchment. Holloway pulled out the parchment with a pair of tweezers. Written on it in red ink was a single word: 'Tempus.'"
    ]
  },
  {
    id: '4',
    title: 'The Whispering Galaxies',
    author: 'Dr. Helen Carter',
    category: 'History & Science',
    price: 22.00,
    rating: 4.6,
    reviewsCount: 154,
    publishedYear: 2024,
    publisher: 'Cosmos Press',
    pages: 410,
    coverUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=400',
    description: 'An elegant overview of astrophysics and the search for cosmic signals, explaining how scientists decode radio waves, gravity waves, and starlight to build a history of our universe.',
    formats: ['Hardcover', 'E-book', 'Audiobook'],
    samplePages: [
      "CHAPTER I: SIGNALS FROM THE PAST\n\nStarlight is old news. When you look up at the night sky, you are looking at history books written in photons. The light from a star in the Andromeda galaxy took two and a half million years to reach your eyes. We are, in the most literal sense, chroniclers of ancient cosmic events.",
      "For centuries, we could only look. Today, we listen. Giant radio dishes, nestled in quiet valleys away from the electrical chatter of cities, point their metallic ears to the void. They pick up the faint hiss of the Big Bang, the rhythmic pulse of dying neutron stars, and the mysterious fast radio bursts that challenge our physics.",
      "The universe is not silent; it is whispering in a language of radiation, gravity, and light. To understand these signals is to realize that we are made of the very stardust we observe, trying to comprehend its own origins. Let us trace these cosmic letters back to their source."
    ]
  }
]
