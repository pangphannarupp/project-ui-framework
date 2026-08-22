export interface ServiceItem {
  id: string
  title: string
  duration: string
  price: number
  originalPrice: number
  discount: string
  imageUrl: string
  description: string
  category: string
}

export const services: ServiceItem[] = [
  { id: '1', title: 'Anantara Signature Facial', duration: '60 min', price: 52.50, originalPrice: 105.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?auto=format&fit=crop&w=400&q=80', description: 'Our signature facial combines the preferred blend of nourishing plant extracts and traditional Thai ingredients to encourage cell renewal and oxygenation.', category: 'FACIAL TREATMENT' },
  { id: '2', title: 'Anantara Signature Massage', duration: '60 min - 90 min', price: 55.00, originalPrice: 110.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=400&q=80', description: 'A deeply relaxing massage using our signature oil blend.', category: 'BODY MASSAGE' },
  { id: '3', title: 'Back Head and Shoulder Massage', duration: '60 min', price: 40.00, originalPrice: 80.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=400&q=80', description: 'Focuses on releasing tension in the upper body.', category: 'BODY MASSAGE' },
  { id: '4', title: 'Bamboo Signature Massage', duration: '90 min', price: 75.00, originalPrice: 150.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1600334129128-685054110230?auto=format&fit=crop&w=400&q=80', description: 'Uses warm bamboo stalks to provide deep tissue massage.', category: 'BODY MASSAGE' },
  { id: '5', title: 'Deep Tissue Massage', duration: '90 min', price: 65.00, originalPrice: 130.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=400&q=80', description: 'Intensive therapy for relieving muscle tension.', category: 'BODY MASSAGE' },
  { id: '6', title: 'Thai Herbal Compress', duration: '90 min', price: 70.00, originalPrice: 140.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?auto=format&fit=crop&w=400&q=80', description: 'Traditional Thai healing therapy using warm herbs.', category: 'BODY MASSAGE' },
  { id: '7', title: 'Anti-Aging Facial', duration: '60 min', price: 80.00, originalPrice: 160.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=400&q=80', description: 'Advanced facial to reduce fine lines.', category: 'FACIAL TREATMENT' },
  { id: '8', title: 'Hydrating Glow Facial', duration: '60 min', price: 60.00, originalPrice: 120.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1600334129128-685054110230?auto=format&fit=crop&w=400&q=80', description: 'Deep hydration for a radiant glow.', category: 'FACIAL TREATMENT' },
  { id: '9', title: 'Detoxifying Body Wrap', duration: '90 min', price: 85.00, originalPrice: 170.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=400&q=80', description: 'Body mask to eliminate toxins.', category: 'WELLNESS' },
  { id: '10', title: 'Himalayan Salt Scrub', duration: '45 min', price: 45.00, originalPrice: 90.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?auto=format&fit=crop&w=400&q=80', description: 'Exfoliating treatment for smooth skin.', category: 'WELLNESS' },
  { id: '11', title: 'Aromatherapy Massage', duration: '60 min', price: 50.00, originalPrice: 100.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=400&q=80', description: 'Relaxing massage with essential oils.', category: 'BODY MASSAGE' },
  { id: '12', title: 'Couples Spa Retreat', duration: '120 min', price: 150.00, originalPrice: 300.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1600334129128-685054110230?auto=format&fit=crop&w=400&q=80', description: 'A shared spa experience for two.', category: 'WELLNESS' },
  { id: '13', title: 'Hot Stone Therapy', duration: '90 min', price: 75.00, originalPrice: 150.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=400&q=80', description: 'Soothing massage using heated volcanic stones.', category: 'BODY MASSAGE' },
  { id: '14', title: 'Brightening Vitamin C Facial', duration: '60 min', price: 70.00, originalPrice: 140.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?auto=format&fit=crop&w=400&q=80', description: 'Vitamin-rich treatment to brighten complexion.', category: 'FACIAL TREATMENT' },
  { id: '15', title: 'Foot Reflexology', duration: '45 min', price: 35.00, originalPrice: 70.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=400&q=80', description: 'Pressure point therapy for the feet.', category: 'BODY MASSAGE' },
  { id: '16', title: 'Ayurvedic Shirodhara', duration: '60 min', price: 80.00, originalPrice: 160.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1600334129128-685054110230?auto=format&fit=crop&w=400&q=80', description: 'Warm oil poured on the forehead for deep relaxation.', category: 'WELLNESS' },
  { id: '17', title: 'Acne Clearing Facial', duration: '60 min', price: 65.00, originalPrice: 130.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=400&q=80', description: 'Purifying treatment for problematic skin.', category: 'FACIAL TREATMENT' },
  { id: '18', title: 'Slimming Body Contour', duration: '90 min', price: 90.00, originalPrice: 180.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?auto=format&fit=crop&w=400&q=80', description: 'Targeted treatment to tone and firm.', category: 'WELLNESS' },
  { id: '19', title: 'Pregnancy Massage', duration: '60 min', price: 55.00, originalPrice: 110.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?auto=format&fit=crop&w=400&q=80', description: 'Gentle and safe massage for expecting mothers.', category: 'BODY MASSAGE' },
  { id: '20', title: 'Full Day Spa Journey', duration: '240 min', price: 250.00, originalPrice: 500.00, discount: '50% OFF', imageUrl: 'https://images.unsplash.com/photo-1600334129128-685054110230?auto=format&fit=crop&w=400&q=80', description: 'The ultimate day of pampering from head to toe.', category: 'WELLNESS' }
]
