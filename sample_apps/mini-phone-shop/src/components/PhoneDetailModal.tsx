import React, { useState } from 'react';
import { PhoneProduct, ColorOption, StorageOption, PlanAddon } from '../types/phone';
import { SAMPLE_PLANS } from '../data/phones';
import { X, Check, Sparkles, ShoppingBag, Zap, Cpu, Camera, Battery, Smartphone } from 'lucide-react';

interface PhoneDetailModalProps {
  product: PhoneProduct | null;
  onClose: () => void;
  onAddToCart: (
    product: PhoneProduct,
    color: ColorOption,
    storage: StorageOption,
    addons: PlanAddon[],
    tradeInDiscount: number
  ) => void;
  onBuyNow: (
    product: PhoneProduct,
    color: ColorOption,
    storage: StorageOption,
    addons: PlanAddon[],
    tradeInDiscount: number
  ) => void;
}

export const PhoneDetailModal: React.FC<PhoneDetailModalProps> = ({
  product,
  onClose,
  onAddToCart,
  onBuyNow
}) => {
  if (!product) return null;

  const [selectedColor, setSelectedColor] = useState<ColorOption>(product.colors[0]);
  const [selectedStorage, setSelectedStorage] = useState<StorageOption>(product.storageOptions[0]);
  const [selectedAddonIds, setSelectedAddonIds] = useState<string[]>([]);
  const [hasTradeIn, setHasTradeIn] = useState<boolean>(false);

  const tradeInDiscount = hasTradeIn ? 250 : 0;
  const currentTotal = product.basePrice + selectedStorage.priceDelta - tradeInDiscount;

  const toggleAddon = (id: string) => {
    setSelectedAddonIds(prev =>
      prev.includes(id) ? prev.filter(item => item !== id) : [...prev, id]
    );
  };

  const getSelectedAddons = (): PlanAddon[] => {
    return SAMPLE_PLANS.filter(p => selectedAddonIds.includes(p.id));
  };

  const addonsTotal = getSelectedAddons().reduce((sum, item) => sum + item.price, 0);
  const finalPrice = currentTotal + addonsTotal;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="bottom-sheet" onClick={e => e.stopPropagation()} style={{ maxHeight: '92vh' }}>
        <div className="sheet-handle" />

        {/* Modal Header */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '1rem' }}>
          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.25rem' }}>
              <span
                style={{
                  background: 'rgba(56, 189, 248, 0.15)',
                  color: '#38bdf8',
                  fontSize: '0.7rem',
                  fontWeight: 700,
                  padding: '0.15rem 0.5rem',
                  borderRadius: '4px'
                }}
              >
                {product.brand}
              </span>
              {product.badge && (
                <span
                  style={{
                    background: 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
                    color: '#000',
                    fontSize: '0.68rem',
                    fontWeight: 800,
                    padding: '0.15rem 0.5rem',
                    borderRadius: '4px'
                  }}
                >
                  {product.badge}
                </span>
              )}
            </div>
            <h2 style={{ fontSize: '1.35rem', fontWeight: 800, color: 'var(--text-main)' }}>
              {product.name}
            </h2>
          </div>
          <button
            onClick={onClose}
            className="icon-btn"
            style={{ width: '32px', height: '32px' }}
            aria-label="Close details"
          >
            <X size={18} />
          </button>
        </div>

        {/* Product Image & Color Preview */}
        <div
          style={{
            background: 'linear-gradient(180deg, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.01) 100%)',
            border: '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-lg)',
            padding: '1.25rem',
            textAlign: 'center',
            marginBottom: '1.25rem',
            position: 'relative'
          }}
        >
          <img
            src={selectedColor.image}
            alt={`${product.name} - ${selectedColor.name}`}
            style={{
              width: '180px',
              height: '180px',
              objectFit: 'cover',
              borderRadius: '12px',
              boxShadow: '0 10px 25px rgba(0,0,0,0.5)',
              marginBottom: '0.75rem'
            }}
          />
          <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--text-secondary)' }}>
            Finish: <span style={{ color: 'var(--text-main)' }}>{selectedColor.name}</span>
          </div>
        </div>

        {/* 1. Color Selector */}
        <div style={{ marginBottom: '1.25rem' }}>
          <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.5rem' }}>
            Select Color
          </div>
          <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap' }}>
            {product.colors.map(col => {
              const isSelected = selectedColor.name === col.name;
              return (
                <button
                  key={col.name}
                  onClick={() => setSelectedColor(col)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.45rem 0.75rem',
                    borderRadius: 'var(--radius-full)',
                    background: isSelected ? 'rgba(56, 189, 248, 0.15)' : 'rgba(255,255,255,0.04)',
                    border: isSelected ? '1px solid #38bdf8' : '1px solid var(--border-subtle)',
                    color: isSelected ? '#38bdf8' : 'var(--text-main)',
                    cursor: 'pointer',
                    fontSize: '0.8rem',
                    fontWeight: 600
                  }}
                >
                  <span
                    style={{
                      width: '14px',
                      height: '14px',
                      borderRadius: '50%',
                      backgroundColor: col.hex,
                      border: '1px solid rgba(255,255,255,0.3)'
                    }}
                  />
                  {col.name}
                </button>
              );
            })}
          </div>
        </div>

        {/* 2. Storage Selector */}
        <div style={{ marginBottom: '1.25rem' }}>
          <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.5rem' }}>
            Select Storage Capacity
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '0.5rem' }}>
            {product.storageOptions.map(opt => {
              const isSelected = selectedStorage.size === opt.size;
              return (
                <button
                  key={opt.size}
                  onClick={() => setSelectedStorage(opt)}
                  style={{
                    padding: '0.65rem 0.5rem',
                    borderRadius: 'var(--radius-md)',
                    background: isSelected ? 'linear-gradient(135deg, rgba(2, 132, 199, 0.25) 0%, rgba(37, 99, 235, 0.2) 100%)' : 'rgba(255,255,255,0.03)',
                    border: isSelected ? '1.5px solid #0284c7' : '1px solid var(--border-subtle)',
                    color: 'var(--text-main)',
                    textAlign: 'center',
                    cursor: 'pointer'
                  }}
                >
                  <div style={{ fontWeight: 800, fontSize: '0.95rem' }}>{opt.size}</div>
                  <div style={{ fontSize: '0.72rem', color: isSelected ? '#38bdf8' : 'var(--text-secondary)', marginTop: '0.15rem' }}>
                    {opt.priceDelta === 0 ? 'Included' : `+$${opt.priceDelta}`}
                  </div>
                </button>
              );
            })}
          </div>
        </div>

        {/* 3. Trade-in Program */}
        <div
          style={{
            background: hasTradeIn ? 'rgba(16, 185, 129, 0.08)' : 'rgba(255, 255, 255, 0.02)',
            border: hasTradeIn ? '1px solid rgba(16, 185, 129, 0.3)' : '1px solid var(--border-subtle)',
            borderRadius: 'var(--radius-md)',
            padding: '0.85rem 1rem',
            marginBottom: '1.25rem'
          }}
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Zap size={18} color="#10b981" />
              <div>
                <div style={{ fontWeight: 700, fontSize: '0.85rem' }}>Trade-in Old Device</div>
                <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>Get up to $250 instant cash voucher</div>
              </div>
            </div>
            <input
              type="checkbox"
              checked={hasTradeIn}
              onChange={e => setHasTradeIn(e.target.checked)}
              style={{ width: '18px', height: '18px', accentColor: '#10b981', cursor: 'pointer' }}
            />
          </div>
          {hasTradeIn && (
            <div style={{ marginTop: '0.65rem', paddingTop: '0.65rem', borderTop: '1px dashed rgba(255,255,255,0.1)' }}>
              <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 600 }}>
                ✓ Estimated instant trade-in value: -$250.00
              </div>
            </div>
          )}
        </div>

        {/* 4. Tech Specs Summary */}
        <div style={{ marginBottom: '1.25rem' }}>
          <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.5rem' }}>
            Device Specifications
          </div>
          <div
            style={{
              background: 'rgba(255, 255, 255, 0.02)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '0.75rem',
              display: 'flex',
              flexDirection: 'column',
              gap: '0.5rem',
              fontSize: '0.8rem'
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Smartphone size={16} color="#94a3b8" />
              <span style={{ color: 'var(--text-secondary)' }}>Display:</span>
              <span style={{ fontWeight: 600, color: 'var(--text-main)' }}>{product.specs.screen}</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Cpu size={16} color="#94a3b8" />
              <span style={{ color: 'var(--text-secondary)' }}>Chipset:</span>
              <span style={{ fontWeight: 600, color: 'var(--text-main)' }}>{product.specs.processor}</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Camera size={16} color="#94a3b8" />
              <span style={{ color: 'var(--text-secondary)' }}>Camera:</span>
              <span style={{ fontWeight: 600, color: 'var(--text-main)' }}>{product.specs.camera}</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Battery size={16} color="#94a3b8" />
              <span style={{ color: 'var(--text-secondary)' }}>Battery:</span>
              <span style={{ fontWeight: 600, color: 'var(--text-main)' }}>{product.specs.battery}</span>
            </div>
          </div>
        </div>

        {/* 5. Bundled Add-ons */}
        <div style={{ marginBottom: '1.5rem' }}>
          <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.5rem' }}>
            Recommended Add-ons & Protection
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
            {SAMPLE_PLANS.slice(0, 3).map(addon => {
              const isSelected = selectedAddonIds.includes(addon.id);
              return (
                <div
                  key={addon.id}
                  onClick={() => toggleAddon(addon.id)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '0.65rem 0.85rem',
                    borderRadius: 'var(--radius-md)',
                    background: isSelected ? 'rgba(56, 189, 248, 0.1)' : 'rgba(255,255,255,0.02)',
                    border: isSelected ? '1px solid #38bdf8' : '1px solid var(--border-subtle)',
                    cursor: 'pointer'
                  }}
                >
                  <div>
                    <div style={{ fontSize: '0.82rem', fontWeight: 700, color: 'var(--text-main)' }}>
                      {addon.name}
                    </div>
                    <div style={{ fontSize: '0.72rem', color: 'var(--text-secondary)' }}>
                      {addon.description.slice(0, 50)}...
                    </div>
                  </div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
                    <span style={{ fontWeight: 700, fontSize: '0.85rem', color: '#38bdf8' }}>
                      +${addon.price}
                    </span>
                    <div
                      style={{
                        width: '18px',
                        height: '18px',
                        borderRadius: '4px',
                        background: isSelected ? '#38bdf8' : 'rgba(255,255,255,0.1)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center'
                      }}
                    >
                      {isSelected && <Check size={12} color="#000" strokeWidth={3} />}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Sheet Action Footer */}
        <div
          style={{
            borderTop: '1px solid var(--border-subtle)',
            paddingTop: '1rem',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: '1rem'
          }}
        >
          <div>
            <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>Total Price</div>
            <div style={{ fontSize: '1.35rem', fontWeight: 800, color: '#38bdf8' }}>
              ${finalPrice.toLocaleString()}
            </div>
          </div>

          <div style={{ display: 'flex', gap: '0.5rem', flex: 1 }}>
            <button
              className="btn-secondary"
              style={{ flex: 1, padding: '0.65rem' }}
              onClick={() => {
                onAddToCart(product, selectedColor, selectedStorage, getSelectedAddons(), tradeInDiscount);
                onClose();
              }}
            >
              <ShoppingBag size={16} />
              Add
            </button>
            <button
              className="btn-primary"
              style={{ flex: 1.5, padding: '0.65rem' }}
              onClick={() => {
                onBuyNow(product, selectedColor, selectedStorage, getSelectedAddons(), tradeInDiscount);
                onClose();
              }}
            >
              <Sparkles size={16} />
              Buy Now
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
