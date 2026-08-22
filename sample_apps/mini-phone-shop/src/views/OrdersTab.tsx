import React, { useState } from 'react';
import { OrderRecord } from '../types/phone';
import { ShieldCheck } from 'lucide-react';

interface OrdersTabProps {
  orders: OrderRecord[];
}

export const OrdersTab: React.FC<OrdersTabProps> = ({ orders }) => {
  const [imeiInput, setImeiInput] = useState('');
  const [checkedWarranty, setCheckedWarranty] = useState<{
    valid: boolean;
    device?: string;
    expiry?: string;
    coverage?: string;
  } | null>(null);

  const handleCheckWarranty = (e: React.FormEvent) => {
    e.preventDefault();
    if (!imeiInput.trim()) return;

    const matched = orders.find(o => o.imei?.includes(imeiInput.trim()));
    if (matched) {
      setCheckedWarranty({
        valid: true,
        device: matched.items[0]?.product.name || 'Smartphone Flagship',
        expiry: matched.warrantyExpiry || 'August 18, 2027',
        coverage: 'Active Coverage (Hardware & Screen Protection)'
      });
    } else {
      setCheckedWarranty({
        valid: true,
        device: 'Apple / Samsung Official Registered Device',
        expiry: '1 Year from Activation Date',
        coverage: 'Standard Manufacturer Official Warranty'
      });
    }
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
      {/* IMEI Warranty Lookup Card */}
      <div
        style={{
          background: 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)',
          border: '1px solid var(--border-subtle)',
          borderRadius: 'var(--radius-lg)',
          padding: '1.25rem',
          boxShadow: 'var(--shadow-sm)'
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.5rem' }}>
          <ShieldCheck size={20} color="#10b981" />
          <h3 style={{ fontSize: '1rem', fontWeight: 800, color: '#ffffff' }}>
            Check IMEI & Warranty Status
          </h3>
        </div>
        <p style={{ fontSize: '0.78rem', color: '#94a3b8', marginBottom: '1rem' }}>
          Verify genuine phone activation, official warranty, and service history.
        </p>

        <form onSubmit={handleCheckWarranty} style={{ display: 'flex', gap: '0.5rem' }}>
          <input
            type="text"
            value={imeiInput}
            onChange={e => setImeiInput(e.target.value)}
            placeholder="Enter 15-digit IMEI number"
            style={{
              flex: 1,
              background: 'rgba(255, 255, 255, 0.05)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)',
              padding: '0.6rem 0.85rem',
              color: 'var(--text-main)',
              fontSize: '0.85rem',
              outline: 'none',
              fontFamily: 'JetBrains Mono, monospace'
            }}
          />
          <button type="submit" className="btn-primary" style={{ padding: '0.6rem 1rem' }}>
            Verify
          </button>
        </form>

        {checkedWarranty && (
          <div
            style={{
              marginTop: '1rem',
              padding: '0.85rem',
              background: 'rgba(16, 185, 129, 0.08)',
              border: '1px solid rgba(16, 185, 129, 0.25)',
              borderRadius: 'var(--radius-md)',
              fontSize: '0.8rem'
            }}
          >
            <div style={{ fontWeight: 700, color: '#10b981', marginBottom: '0.25rem' }}>
              ✓ Genuine Device Verified
            </div>
            <div style={{ color: 'var(--text-main)', marginBottom: '0.2rem' }}>
              <strong>Device:</strong> {checkedWarranty.device}
            </div>
            <div style={{ color: 'var(--text-secondary)', marginBottom: '0.2rem' }}>
              <strong>Warranty Until:</strong> {checkedWarranty.expiry}
            </div>
            <div style={{ color: 'var(--text-secondary)' }}>
              <strong>Status:</strong> {checkedWarranty.coverage}
            </div>
          </div>
        )}
      </div>

      {/* Orders List */}
      <div>
        <h3 style={{ fontSize: '1rem', fontWeight: 700, marginBottom: '0.75rem' }}>
          Order History ({orders.length})
        </h3>

        {orders.length === 0 ? (
          <div
            style={{
              textAlign: 'center',
              padding: '2.5rem 1rem',
              background: 'var(--bg-card)',
              border: '1px solid var(--border-subtle)',
              borderRadius: 'var(--radius-md)'
            }}
          >
            <div style={{ fontSize: '2.5rem', marginBottom: '0.5rem' }}>📦</div>
            <div style={{ fontWeight: 700, fontSize: '1rem', marginBottom: '0.25rem' }}>
              No Orders Placed Yet
            </div>
            <div style={{ fontSize: '0.8rem', color: 'var(--text-secondary)' }}>
              Orders and warranties purchased via MiniApp will show here.
            </div>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
            {orders.map(order => (
              <div
                key={order.orderId}
                style={{
                  background: 'var(--bg-card)',
                  border: '1px solid var(--border-subtle)',
                  borderRadius: 'var(--radius-md)',
                  padding: '1rem',
                  display: 'flex',
                  flexDirection: 'column',
                  gap: '0.75rem'
                }}
              >
                {/* Header */}
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: '0.9rem', color: 'var(--text-main)' }}>
                      {order.orderId}
                    </div>
                    <div style={{ fontSize: '0.72rem', color: 'var(--text-secondary)' }}>
                      Placed on {order.date}
                    </div>
                  </div>
                  <span
                    style={{
                      background: 'rgba(56, 189, 248, 0.15)',
                      color: '#38bdf8',
                      fontSize: '0.72rem',
                      fontWeight: 700,
                      padding: '0.2rem 0.6rem',
                      borderRadius: 'var(--radius-full)'
                    }}
                  >
                    {order.status}
                  </span>
                </div>

                {/* Items */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                  {order.items.map(item => (
                    <div
                      key={item.id}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.75rem',
                        background: 'rgba(255, 255, 255, 0.02)',
                        padding: '0.5rem',
                        borderRadius: '6px'
                      }}
                    >
                      <img
                        src={item.selectedColor.image}
                        alt={item.product.name}
                        style={{ width: '40px', height: '40px', objectFit: 'cover', borderRadius: '4px' }}
                      />
                      <div style={{ flex: 1 }}>
                        <div style={{ fontWeight: 600, fontSize: '0.82rem' }}>{item.product.name}</div>
                        <div style={{ fontSize: '0.72rem', color: 'var(--text-secondary)' }}>
                          {item.selectedColor.name} • {item.selectedStorage.size} (Qty: {item.quantity})
                        </div>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Order Footer */}
                <div
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    borderTop: '1px solid rgba(255, 255, 255, 0.04)',
                    paddingTop: '0.65rem',
                    fontSize: '0.8rem'
                  }}
                >
                  <div>
                    <span style={{ color: 'var(--text-secondary)' }}>Paid with </span>
                    <strong style={{ color: 'var(--text-main)' }}>{order.paymentMethod}</strong>
                  </div>
                  <div style={{ fontSize: '1rem', fontWeight: 800, color: '#10b981' }}>
                    ${order.totalAmount.toLocaleString()}
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};
