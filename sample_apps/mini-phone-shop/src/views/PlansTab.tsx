import React, { useState } from 'react';
import { SAMPLE_PLANS } from '../data/phones';
import { PlanAddon } from '../types/phone';
import { Wifi, Globe, Shield, Zap, Box, Sparkles } from 'lucide-react';

interface PlansTabProps {
  onQuickPurchase: (addon: PlanAddon) => void;
}

export const PlansTab: React.FC<PlansTabProps> = ({ onQuickPurchase }) => {
  const [activeCategory, setActiveCategory] = useState<'All' | 'eSIM' | 'Protection' | 'Accessories'>('All');

  const categories = ['All', 'eSIM', 'Protection', 'Accessories'] as const;

  const filteredPlans = SAMPLE_PLANS.filter(plan =>
    activeCategory === 'All' ? true : plan.category === activeCategory
  );

  const getCategoryIcon = (iconName: string) => {
    switch (iconName) {
      case 'wifi':
        return <Wifi size={20} color="#38bdf8" />;
      case 'globe':
        return <Globe size={20} color="#10b981" />;
      case 'shield':
        return <Shield size={20} color="#f59e0b" />;
      case 'zap':
        return <Zap size={20} color="#ec4899" />;
      default:
        return <Box size={20} color="#94a3b8" />;
    }
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
      {/* Header Info Card */}
      <div
        style={{
          background: 'linear-gradient(135deg, rgba(2, 132, 199, 0.2) 0%, rgba(37, 99, 235, 0.1) 100%)',
          border: '1px solid rgba(56, 189, 248, 0.25)',
          borderRadius: 'var(--radius-lg)',
          padding: '1.25rem',
          display: 'flex',
          alignItems: 'center',
          gap: '1rem'
        }}
      >
        <div
          style={{
            width: '48px',
            height: '48px',
            borderRadius: '50%',
            background: 'rgba(56, 189, 248, 0.2)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
        >
          <Sparkles size={24} color="#38bdf8" />
        </div>
        <div>
          <h3 style={{ fontSize: '1.1rem', fontWeight: 800, color: '#ffffff' }}>
            Instant eSIM & Device Add-ons
          </h3>
          <p style={{ fontSize: '0.78rem', color: '#cbd5e1' }}>
            Activate high-speed 5G eSIM instantly or protect your new smartphone.
          </p>
        </div>
      </div>

      {/* Category Pills */}
      <div style={{ display: 'flex', gap: '0.5rem', overflowX: 'auto', scrollbarWidth: 'none' }}>
        {categories.map(cat => {
          const isSelected = activeCategory === cat;
          return (
            <button
              key={cat}
              onClick={() => setActiveCategory(cat)}
              style={{
                padding: '0.45rem 1rem',
                borderRadius: 'var(--radius-full)',
                background: isSelected ? 'linear-gradient(135deg, #0284c7 0%, #2563eb 100%)' : 'rgba(255, 255, 255, 0.04)',
                border: isSelected ? '1px solid #38bdf8' : '1px solid var(--border-subtle)',
                color: isSelected ? '#ffffff' : 'var(--text-secondary)',
                fontWeight: 600,
                fontSize: '0.8rem',
                cursor: 'pointer',
                whiteSpace: 'nowrap'
              }}
            >
              {cat}
            </button>
          );
        })}
      </div>

      {/* Plans List */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
        {filteredPlans.map(plan => (
          <div
            key={plan.id}
            style={{
              background: 'var(--bg-card)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '1rem',
              display: 'flex',
              flexDirection: 'column',
              gap: '0.75rem',
              position: 'relative'
            }}
          >
            {plan.recommended && (
              <span
                style={{
                  position: 'absolute',
                  top: '10px',
                  right: '10px',
                  background: 'rgba(16, 185, 129, 0.15)',
                  color: '#10b981',
                  border: '1px solid rgba(16, 185, 129, 0.3)',
                  fontSize: '0.68rem',
                  fontWeight: 700,
                  padding: '0.15rem 0.5rem',
                  borderRadius: 'var(--radius-full)'
                }}
              >
                Recommended
              </span>
            )}

            <div style={{ display: 'flex', gap: '0.85rem', alignItems: 'flex-start' }}>
              <div
                style={{
                  width: '40px',
                  height: '40px',
                  borderRadius: '10px',
                  background: 'rgba(255, 255, 255, 0.04)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center'
                }}
              >
                {getCategoryIcon(plan.iconName)}
              </div>

              <div style={{ flex: 1, paddingRight: plan.recommended ? '75px' : '0' }}>
                <h4 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--text-main)' }}>
                  {plan.name}
                </h4>
                {plan.dataAllowance && (
                  <div style={{ fontSize: '0.78rem', color: '#38bdf8', fontWeight: 600, marginTop: '0.1rem' }}>
                    {plan.dataAllowance}
                  </div>
                )}
                <p style={{ fontSize: '0.75rem', color: 'var(--text-secondary)', marginTop: '0.25rem' }}>
                  {plan.description}
                </p>
              </div>
            </div>

            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                borderTop: '1px solid rgba(255, 255, 255, 0.04)',
                paddingTop: '0.65rem'
              }}
            >
              <div>
                <span style={{ fontSize: '1.15rem', fontWeight: 800, color: '#38bdf8' }}>
                  ${plan.price}
                </span>
                {plan.validity && (
                  <span style={{ fontSize: '0.75rem', color: 'var(--text-secondary)', marginLeft: '0.3rem' }}>
                    / {plan.validity}
                  </span>
                )}
              </div>

              <button
                className="btn-primary"
                style={{ padding: '0.45rem 1rem', fontSize: '0.8rem' }}
                onClick={() => onQuickPurchase(plan)}
              >
                Buy Now
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
