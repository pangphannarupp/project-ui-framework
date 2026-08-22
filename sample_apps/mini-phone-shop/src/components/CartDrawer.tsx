import React from 'react';
import { CartItem } from '../types/phone';
import { X, Trash2, Plus, Minus, ArrowRight } from 'lucide-react';

interface CartDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  items: CartItem[];
  onUpdateQuantity: (id: string, delta: number) => void;
  onRemoveItem: (id: string) => void;
  onProceedToCheckout: () => void;
}

export const CartDrawer: React.FC<CartDrawerProps> = ({
  isOpen,
  onClose,
  items,
  onUpdateQuantity,
  onRemoveItem,
  onProceedToCheckout
}) => {
  if (!isOpen) return null;

  const calculateSubtotal = () => {
    return items.reduce((total, item) => {
      const baseItemPrice = item.product.basePrice + item.selectedStorage.priceDelta - (item.tradeInDiscount || 0);
      const addonsPrice = (item.selectedAddons || []).reduce((sum, add) => sum + add.price, 0);
      return total + (baseItemPrice + addonsPrice) * item.quantity;
    }, 0);
  };

  const subtotal = calculateSubtotal();
  const deliveryFee = subtotal > 0 ? 0 : 0; // Free express delivery
  const total = subtotal + deliveryFee;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="bottom-sheet" onClick={e => e.stopPropagation()} style={{ maxHeight: '88vh' }}>
        <div className="sheet-handle" />

        {/* Drawer Header */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
          <div>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 800 }}>Shopping Bag</h2>
            <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
              {items.length} item{items.length !== 1 ? 's' : ''} in cart
            </div>
          </div>
          <button onClick={onClose} className="icon-btn" style={{ width: '32px', height: '32px' }} aria-label="Close cart">
            <X size={18} />
          </button>
        </div>

        {/* Items List */}
        {items.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '2.5rem 1rem' }}>
            <div style={{ fontSize: '3rem', marginBottom: '0.5rem' }}>🛍️</div>
            <div style={{ fontWeight: 700, fontSize: '1.1rem', marginBottom: '0.25rem' }}>
              Your Bag is Empty
            </div>
            <div style={{ color: 'var(--text-secondary)', fontSize: '0.85rem', marginBottom: '1.5rem' }}>
              Explore our latest 5G smartphones & accessories!
            </div>
            <button className="btn-primary" onClick={onClose}>
              Browse Store
            </button>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem', marginBottom: '1.5rem' }}>
            {items.map(item => {
              const itemUnitCost =
                item.product.basePrice +
                item.selectedStorage.priceDelta -
                (item.tradeInDiscount || 0) +
                (item.selectedAddons || []).reduce((acc, a) => acc + a.price, 0);

              return (
                <div
                  key={item.id}
                  style={{
                    background: 'rgba(255, 255, 255, 0.03)',
                    border: '1px solid var(--border-subtle)',
                    borderRadius: 'var(--radius-md)',
                    padding: '0.85rem',
                    display: 'flex',
                    flexDirection: 'column',
                    gap: '0.65rem'
                  }}
                >
                  <div style={{ display: 'flex', gap: '0.85rem', alignItems: 'center' }}>
                    <img
                      src={item.selectedColor.image}
                      alt={item.product.name}
                      style={{ width: '60px', height: '60px', objectFit: 'cover', borderRadius: '8px' }}
                    />
                    <div style={{ flex: 1 }}>
                      <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>{item.product.name}</div>
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)', marginTop: '0.1rem' }}>
                        {item.selectedColor.name} • {item.selectedStorage.size}
                      </div>
                      <div style={{ fontWeight: 800, color: '#38bdf8', marginTop: '0.2rem' }}>
                        ${itemUnitCost.toLocaleString()}
                      </div>
                    </div>

                    <button
                      onClick={() => onRemoveItem(item.id)}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        color: 'var(--text-muted)',
                        cursor: 'pointer',
                        padding: '4px'
                      }}
                      aria-label="Remove item"
                    >
                      <Trash2 size={16} />
                    </button>
                  </div>

                  {/* Addon details / Trade-in Pill */}
                  {(item.tradeInDiscount || (item.selectedAddons && item.selectedAddons.length > 0)) && (
                    <div
                      style={{
                        background: 'rgba(255, 255, 255, 0.02)',
                        padding: '0.4rem 0.6rem',
                        borderRadius: '6px',
                        fontSize: '0.72rem',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '0.2rem'
                      }}
                    >
                      {item.tradeInDiscount ? (
                        <span style={{ color: '#10b981' }}>⚡ Trade-in discount applied: -$250</span>
                      ) : null}
                      {item.selectedAddons?.map(a => (
                        <span key={a.id} style={{ color: 'var(--text-secondary)' }}>
                          + {a.name} (${a.price})
                        </span>
                      ))}
                    </div>
                  )}

                  {/* Quantity bar */}
                  <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: '0.75rem' }}>
                    <div
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem',
                        background: 'rgba(255, 255, 255, 0.06)',
                        borderRadius: 'var(--radius-sm)',
                        padding: '0.2rem 0.5rem'
                      }}
                    >
                      <button
                        onClick={() => onUpdateQuantity(item.id, -1)}
                        style={{ background: 'none', border: 'none', color: 'var(--text-main)', cursor: 'pointer' }}
                        aria-label="Decrease quantity"
                      >
                        <Minus size={14} />
                      </button>
                      <span style={{ fontWeight: 700, fontSize: '0.85rem', minWidth: '16px', textAlign: 'center' }}>
                        {item.quantity}
                      </span>
                      <button
                        onClick={() => onUpdateQuantity(item.id, 1)}
                        style={{ background: 'none', border: 'none', color: 'var(--text-main)', cursor: 'pointer' }}
                        aria-label="Increase quantity"
                      >
                        <Plus size={14} />
                      </button>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {/* Order Summary & Checkout Action */}
        {items.length > 0 && (
          <div
            style={{
              borderTop: '1px solid var(--border-subtle)',
              paddingTop: '1rem'
            }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.4rem', fontSize: '0.85rem' }}>
              <span style={{ color: 'var(--text-secondary)' }}>Subtotal</span>
              <span style={{ fontWeight: 600 }}>${subtotal.toLocaleString()}</span>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem', fontSize: '0.85rem' }}>
              <span style={{ color: 'var(--text-secondary)' }}>Free Express Delivery</span>
              <span style={{ color: '#10b981', fontWeight: 600 }}>$0.00 (FREE)</span>
            </div>

            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                marginBottom: '1rem',
                fontSize: '1.1rem',
                fontWeight: 800
              }}
            >
              <span>Total Amount</span>
              <span style={{ color: '#38bdf8' }}>${total.toLocaleString()}</span>
            </div>

            <button
              className="btn-primary btn-block"
              style={{ padding: '0.85rem' }}
              onClick={() => {
                onProceedToCheckout();
              }}
            >
              <span>Proceed to Checkout</span>
              <ArrowRight size={18} />
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
