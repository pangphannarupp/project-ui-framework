import React, { useState } from 'react';
import { PhoneProduct } from '../types/phone';
import { FEATURED_PROMOS } from '../data/phones';
import { Search, Star, ChevronRight } from 'lucide-react';

interface ShopHomeProps {
  phones: PhoneProduct[];
  onSelectProduct: (product: PhoneProduct) => void;
}

export const ShopHome: React.FC<ShopHomeProps> = ({ phones, onSelectProduct }) => {
  const [selectedBrand, setSelectedBrand] = useState<string>('All');
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [activePromoIndex, setActivePromoIndex] = useState<number>(0);

  const brands = ['All', 'Apple', 'Samsung', 'Xiaomi', 'Google', 'Nothing'];

  const filteredPhones = phones.filter(phone => {
    const matchesBrand = selectedBrand === 'All' || phone.brand === selectedBrand;
    const matchesSearch =
      phone.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      phone.tagline.toLowerCase().includes(searchQuery.toLowerCase()) ||
      phone.brand.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesBrand && matchesSearch;
  });

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
      {/* Featured Carousel Banner */}
      <div style={{ position: 'relative' }}>
        <div
          style={{
            background: FEATURED_PROMOS[activePromoIndex].bgGradient,
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-lg)',
            padding: '1.25rem',
            position: 'relative',
            overflow: 'hidden',
            boxShadow: 'var(--shadow-md)'
          }}
        >
          <div style={{ position: 'relative', zIndex: 2 }}>
            <div
              style={{
                display: 'inline-block',
                background: 'rgba(255, 255, 255, 0.12)',
                backdropFilter: 'blur(8px)',
                color: FEATURED_PROMOS[activePromoIndex].accentColor,
                fontSize: '0.72rem',
                fontWeight: 800,
                padding: '0.2rem 0.6rem',
                borderRadius: 'var(--radius-full)',
                marginBottom: '0.5rem'
              }}
            >
              {FEATURED_PROMOS[activePromoIndex].badge}
            </div>
            <h2 style={{ fontSize: '1.35rem', fontWeight: 800, color: '#ffffff', marginBottom: '0.25rem' }}>
              {FEATURED_PROMOS[activePromoIndex].title}
            </h2>
            <p style={{ fontSize: '0.8rem', color: '#cbd5e1', marginBottom: '0.85rem', maxWidth: '75%' }}>
              {FEATURED_PROMOS[activePromoIndex].subtitle}
            </p>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <span style={{ fontSize: '0.75rem', fontWeight: 700, color: '#fbbf24' }}>
                {FEATURED_PROMOS[activePromoIndex].tag}
              </span>
              <button
                className="btn-primary"
                style={{ padding: '0.45rem 0.9rem', fontSize: '0.8rem' }}
                onClick={() => {
                  const target = phones.find(p => p.id === FEATURED_PROMOS[activePromoIndex].productId);
                  if (target) onSelectProduct(target);
                }}
              >
                <span>Explore</span>
                <ChevronRight size={14} />
              </button>
            </div>
          </div>
        </div>

        {/* Carousel indicators */}
        <div style={{ display: 'flex', justifyContent: 'center', gap: '0.35rem', marginTop: '0.5rem' }}>
          {FEATURED_PROMOS.map((_, idx) => (
            <button
              key={idx}
              onClick={() => setActivePromoIndex(idx)}
              style={{
                width: activePromoIndex === idx ? '20px' : '6px',
                height: '6px',
                borderRadius: '3px',
                background: activePromoIndex === idx ? '#38bdf8' : 'rgba(255,255,255,0.2)',
                border: 'none',
                cursor: 'pointer',
                transition: 'all 0.3s ease'
              }}
              aria-label={`Slide ${idx + 1}`}
            />
          ))}
        </div>
      </div>

      {/* Search and Filter Bar */}
      <div style={{ display: 'flex', gap: '0.5rem' }}>
        <div
          style={{
            flex: 1,
            background: 'rgba(255, 255, 255, 0.04)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-md)',
            padding: '0.55rem 0.85rem',
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem'
          }}
        >
          <Search size={16} color="#94a3b8" />
          <input
            type="text"
            value={searchQuery}
            onChange={e => setSearchQuery(e.target.value)}
            placeholder="Search phones, 5G specs, brands..."
            style={{
              background: 'none',
              border: 'none',
              color: 'var(--text-main)',
              outline: 'none',
              width: '100%',
              fontSize: '0.85rem'
            }}
          />
        </div>
      </div>

      {/* Brand Horizontal Filter */}
      <div
        style={{
          display: 'flex',
          gap: '0.5rem',
          overflowX: 'auto',
          paddingBottom: '0.25rem',
          scrollbarWidth: 'none'
        }}
      >
        {brands.map(brand => {
          const isSelected = selectedBrand === brand;
          return (
            <button
              key={brand}
              onClick={() => setSelectedBrand(brand)}
              style={{
                padding: '0.45rem 1rem',
                borderRadius: 'var(--radius-full)',
                background: isSelected ? 'linear-gradient(135deg, #0284c7 0%, #2563eb 100%)' : 'rgba(255, 255, 255, 0.04)',
                border: isSelected ? '1px solid #38bdf8' : '1px solid var(--border-subtle)',
                color: isSelected ? '#ffffff' : 'var(--text-secondary)',
                fontWeight: 600,
                fontSize: '0.8rem',
                cursor: 'pointer',
                whiteSpace: 'nowrap',
                transition: 'all 0.2s ease'
              }}
            >
              {brand}
            </button>
          );
        })}
      </div>

      {/* Product Grid */}
      <div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.75rem' }}>
          <h3 style={{ fontSize: '1rem', fontWeight: 700 }}>
            {selectedBrand === 'All' ? 'All Smartphones' : `${selectedBrand} Phones`}
            <span style={{ fontSize: '0.8rem', color: 'var(--text-secondary)', marginLeft: '0.4rem' }}>
              ({filteredPhones.length})
            </span>
          </h3>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(170px, 1fr))', gap: '0.85rem' }}>
          {filteredPhones.map(phone => (
            <div
              key={phone.id}
              onClick={() => onSelectProduct(phone)}
              style={{
                background: 'var(--bg-card)',
                border: '1px solid var(--border-subtle)',
                borderRadius: 'var(--radius-md)',
                padding: '0.85rem',
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'space-between',
                cursor: 'pointer',
                position: 'relative',
                transition: 'all 0.2s ease'
              }}
            >
              {phone.badge && (
                <span
                  style={{
                    position: 'absolute',
                    top: '8px',
                    left: '8px',
                    background: 'rgba(2, 132, 199, 0.9)',
                    color: '#ffffff',
                    fontSize: '0.62rem',
                    fontWeight: 800,
                    padding: '0.15rem 0.45rem',
                    borderRadius: '4px',
                    zIndex: 2
                  }}
                >
                  {phone.badge}
                </span>
              )}

              {/* Product Image */}
              <div style={{ textAlign: 'center', margin: '0.5rem 0', position: 'relative' }}>
                <img
                  src={phone.colors[0].image}
                  alt={phone.name}
                  style={{
                    width: '100%',
                    height: '130px',
                    objectFit: 'cover',
                    borderRadius: '8px'
                  }}
                />
              </div>

              {/* Product Details */}
              <div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', marginBottom: '0.2rem' }}>
                  <Star size={12} fill="#f59e0b" color="#f59e0b" />
                  <span style={{ fontSize: '0.72rem', fontWeight: 700 }}>{phone.rating}</span>
                  <span style={{ fontSize: '0.68rem', color: 'var(--text-muted)' }}>({phone.reviewsCount})</span>
                </div>

                <h4
                  style={{
                    fontSize: '0.9rem',
                    fontWeight: 700,
                    color: 'var(--text-main)',
                    marginBottom: '0.2rem',
                    lineHeight: '1.2'
                  }}
                >
                  {phone.name}
                </h4>

                <p
                  style={{
                    fontSize: '0.72rem',
                    color: 'var(--text-secondary)',
                    marginBottom: '0.6rem',
                    display: '-webkit-box',
                    WebkitLineClamp: 1,
                    WebkitBoxOrient: 'vertical',
                    overflow: 'hidden'
                  }}
                >
                  {phone.specs.screen.split(' ')[0]} • {phone.specs.camera.split('+')[0]}
                </p>

                {/* Price and Action */}
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginTop: 'auto' }}>
                  <div>
                    <div style={{ fontSize: '1rem', fontWeight: 800, color: '#38bdf8' }}>
                      ${phone.basePrice}
                    </div>
                    {phone.originalPrice && (
                      <div style={{ fontSize: '0.68rem', color: 'var(--text-muted)', textDecoration: 'line-through' }}>
                        ${phone.originalPrice}
                      </div>
                    )}
                  </div>

                  <button
                    style={{
                      background: 'rgba(56, 189, 248, 0.12)',
                      border: '1px solid rgba(56, 189, 248, 0.3)',
                      color: '#38bdf8',
                      borderRadius: 'var(--radius-sm)',
                      padding: '0.35rem 0.65rem',
                      fontWeight: 700,
                      fontSize: '0.75rem',
                      cursor: 'pointer'
                    }}
                  >
                    View
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
