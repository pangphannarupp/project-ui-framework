import React, { useState } from 'react';
import { CartItem, OrderRecord } from '../types/phone';
import { X, Phone, MapPin, Sparkles, ShieldCheck } from 'lucide-react';
import { PaymentAlert } from './PaymentAlert';

interface CheckoutModalProps {
  isOpen: boolean;
  onClose: () => void;
  items: CartItem[];
  customerName: string;
  customerPhone: string;
  onOrderSuccess: (order: OrderRecord) => void;
}

export const CheckoutModal: React.FC<CheckoutModalProps> = ({
  isOpen,
  onClose,
  items,
  customerName,
  customerPhone,
  onOrderSuccess
}) => {
  if (!isOpen) return null;

  const recipientName = customerName || 'Sovannara Kem';
  const [recipientPhone, setRecipientPhone] = useState(customerPhone || '012 888 999');
  const [deliveryAddress, setDeliveryAddress] = useState('St. 2004, Sen Sok, Phnom Penh');
  const [isProcessing, setIsProcessing] = useState(false);

  // Alert State for Success / Failed
  const [alertOpen, setAlertOpen] = useState(false);
  const [alertType, setAlertType] = useState<'success' | 'failed'>('success');
  const [alertTitle, setAlertTitle] = useState('');
  const [alertMessage, setAlertMessage] = useState('');
  const [pendingOrder, setPendingOrder] = useState<OrderRecord | null>(null);

  const calculateTotal = () => {
    return items.reduce((total, item) => {
      const baseItemPrice = item.product.basePrice + item.selectedStorage.priceDelta - (item.tradeInDiscount || 0);
      const addonsPrice = (item.selectedAddons || []).reduce((sum, add) => sum + add.price, 0);
      return total + (baseItemPrice + addonsPrice) * item.quantity;
    }, 0);
  };

  const grandTotal = calculateTotal();

  const handlePayNow = async () => {
    setIsProcessing(true);

    const MiniApp = (window as any).MiniApp;

    try {
      const payload = {
        serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
        prepayId: 'PREPAY_' + Date.now(),
        amount: grandTotal,
        currency: 'USD',
        partnerCode: 'PHONE_STORE',
        metadata: {
          orderId: 'ORD_' + Date.now(),
          accountNumber: recipientPhone,
          customerName: recipientName,
          itemsCount: items.length
        }
      };

      let result: any;
      if (MiniApp && typeof MiniApp.requestPayment === 'function') {
        result = await MiniApp.requestPayment(payload);
      } else {
        // Fallback simulation for browser testing
        await new Promise(res => setTimeout(res, 800));
        result = {
          status: 'SUCCESS',
          transactionId: 'TXN_' + Date.now()
        };
      }

      console.log('Payment status:', result?.status);
      console.log('Transaction ID:', result?.transactionId);

      const newOrder: OrderRecord = {
        orderId: 'ORD-' + Math.floor(100000 + Math.random() * 900000),
        transactionId: result?.transactionId || 'TXN_' + Date.now(),
        date: new Date().toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }),
        items: [...items],
        totalAmount: grandTotal,
        paymentMethod: 'KHQR / SuperApp',
        status: 'Processing',
        imei: '86' + Math.floor(1000000000000 + Math.random() * 9000000000000),
        warrantyExpiry: 'Aug 18, 2027',
        customerName: recipientName,
        customerPhone: recipientPhone
      };

      setPendingOrder(newOrder);
      setAlertType('success');
      setAlertTitle('Payment Successful');
      setAlertMessage(
        `You have successfully placed your order!\nAmount: $${grandTotal.toLocaleString()}\nTransaction ID: ${result?.transactionId || 'SUCCESS'}`
      );
      setAlertOpen(true);
    } catch (error: any) {
      console.error('Payment failed or cancelled:', error);
      setAlertType('failed');
      setAlertTitle('Payment Failed');
      setAlertMessage(
        error?.errorMessage || error?.message || 'Payment was cancelled or failed to process.'
      );
      setAlertOpen(true);
    } finally {
      setIsProcessing(false);
    }
  };

  const handleAlertClose = () => {
    setAlertOpen(false);
    if (alertType === 'success' && pendingOrder) {
      onOrderSuccess(pendingOrder);
      onClose();
    }
  };

  return (
    <>
      <div className="modal-overlay" onClick={onClose}>
        <div className="bottom-sheet" onClick={e => e.stopPropagation()} style={{ maxHeight: '90vh' }}>
          <div className="sheet-handle" />

          {/* Header */}
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
            <div>
              <h2 style={{ fontSize: '1.25rem', fontWeight: 800 }}>Confirm Order & Pay</h2>
              <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>
                KHQR SuperApp Secure Gateway
              </div>
            </div>
            <button onClick={onClose} className="icon-btn" style={{ width: '32px', height: '32px' }} aria-label="Close checkout">
              <X size={18} />
            </button>
          </div>

          {/* Delivery Details */}
          <div style={{ marginBottom: '1.25rem' }}>
            <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.65rem' }}>
              Delivery Information
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
              <div
                style={{
                  background: 'rgba(255, 255, 255, 0.03)',
                  border: '1px solid var(--border-subtle)',
                  borderRadius: 'var(--radius-md)',
                  padding: '0.6rem 0.85rem',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem'
                }}
              >
                <Phone size={16} color="#94a3b8" />
                <input
                  type="text"
                  value={recipientPhone}
                  onChange={e => setRecipientPhone(e.target.value)}
                  placeholder="Recipient Phone Number"
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

              <div
                style={{
                  background: 'rgba(255, 255, 255, 0.03)',
                  border: '1px solid var(--border-subtle)',
                  borderRadius: 'var(--radius-md)',
                  padding: '0.6rem 0.85rem',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem'
                }}
              >
                <MapPin size={16} color="#94a3b8" />
                <input
                  type="text"
                  value={deliveryAddress}
                  onChange={e => setDeliveryAddress(e.target.value)}
                  placeholder="Delivery Address"
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
          </div>

          {/* Items Summary list */}
          <div style={{ marginBottom: '1.25rem' }}>
            <div style={{ fontSize: '0.85rem', fontWeight: 700, marginBottom: '0.65rem' }}>
              Order Summary ({items.length} items)
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
              {items.map(item => (
                <div
                  key={item.id}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '0.5rem 0.75rem',
                    background: 'rgba(255, 255, 255, 0.02)',
                    borderRadius: '8px',
                    fontSize: '0.8rem'
                  }}
                >
                  <span style={{ color: 'var(--text-main)', fontWeight: 600 }}>
                    {item.product.name} (x{item.quantity})
                  </span>
                  <span style={{ color: '#38bdf8', fontWeight: 700 }}>
                    ${(
                      (item.product.basePrice + item.selectedStorage.priceDelta - (item.tradeInDiscount || 0)) * item.quantity
                    ).toLocaleString()}
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Order Total and Submit */}
          <div style={{ borderTop: '1px solid var(--border-subtle)', paddingTop: '1rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
              <div>
                <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>Total to Pay</div>
                <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#38bdf8' }}>
                  ${grandTotal.toLocaleString()}
                </div>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.75rem', color: '#10b981' }}>
                <ShieldCheck size={16} />
                <span>Official Warranty 1-Yr</span>
              </div>
            </div>

            <button
              className="btn-primary btn-block"
              disabled={isProcessing}
              onClick={handlePayNow}
              style={{ padding: '0.9rem' }}
            >
              {isProcessing ? (
                <span>Processing with Native SuperApp...</span>
              ) : (
                <>
                  <Sparkles size={18} />
                  <span>Pay ${grandTotal.toLocaleString()}</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Success / Failed Message Alert Modal */}
      <PaymentAlert
        isOpen={alertOpen}
        type={alertType}
        title={alertTitle}
        message={alertMessage}
        confirmText={alertType === 'success' ? 'View Orders' : 'Try Again'}
        onConfirm={handleAlertClose}
      />
    </>
  );
};
