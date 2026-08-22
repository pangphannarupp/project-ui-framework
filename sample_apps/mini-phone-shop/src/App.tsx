import React, { useState, useEffect } from 'react';
import { transformDummyProduct, DummyJsonProduct } from './data/phones';
import { PhoneProduct, ColorOption, StorageOption, PlanAddon, CartItem, OrderRecord } from './types/phone';
import { BottomNav, TabType } from './components/BottomNav';
import { ShopHome } from './views/ShopHome';
import { PlansTab } from './views/PlansTab';
import { OrdersTab } from './views/OrdersTab';
import { PhoneDetailModal } from './components/PhoneDetailModal';
import { CartDrawer } from './components/CartDrawer';
import { CheckoutModal } from './components/CheckoutModal';
import { Sparkles, Loader2 } from 'lucide-react';
import './lib/mini.app.lib.js';

export const App: React.FC = () => {
  const [activeTab, setActiveTab] = useState<TabType>('phones');
  const [userName, setUserName] = useState<string>('GUEST USER');
  const [userPhone, setUserPhone] = useState<string>('012 888 999');
  const [phones, setPhones] = useState<PhoneProduct[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // Cart & Orders State
  const [cartItems, setCartItems] = useState<CartItem[]>([]);
  const [orders, setOrders] = useState<OrderRecord[]>([]);

  // Modals
  const [selectedProduct, setSelectedProduct] = useState<PhoneProduct | null>(null);
  const [isCartOpen, setIsCartOpen] = useState<boolean>(false);
  const [isCheckoutOpen, setIsCheckoutOpen] = useState<boolean>(false);

  // Fetch products from https://dummyjson.com/products/search?q=phone
  useEffect(() => {
    const fetchPhones = async () => {
      try {
        setIsLoading(true);
        const response = await fetch('https://dummyjson.com/products/search?q=phone');
        const data = await response.json();
        if (data && Array.isArray(data.products)) {
          const transformed = data.products.map((item: DummyJsonProduct) => transformDummyProduct(item));
          setPhones(transformed);
        }
      } catch (error) {
        console.error('Failed to fetch phone products from dummyjson:', error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchPhones();
  }, []);

  // Initialize MiniApp Bridge
  useEffect(() => {
    const initMiniApp = async () => {
      const MiniApp = (window as any).MiniApp;
      if (MiniApp) {
        try {
          if (typeof MiniApp.getUserProfile === 'function') {
            const profile = await MiniApp.getUserProfile({ appKey: 'PHONE_SHOP_KEY' });
            if (profile && profile.name) setUserName(profile.name.toUpperCase());
            if (profile && profile.phoneNumber) setUserPhone(profile.phoneNumber);
          }
        } catch (e) {
          console.log('MiniApp profile fetched with fallback or mock:', e);
        }
      }
    };

    initMiniApp();
  }, []);

  // const totalCartCount = cartItems.reduce((acc, item) => acc + item.quantity, 0);

  // Cart Actions
  const handleAddToCart = (
    product: PhoneProduct,
    color: ColorOption,
    storage: StorageOption,
    addons: PlanAddon[],
    tradeInDiscount: number
  ) => {
    const newItemId = `${product.id}-${color.name}-${storage.size}-${Date.now()}`;
    const newItem: CartItem = {
      id: newItemId,
      product,
      selectedColor: color,
      selectedStorage: storage,
      quantity: 1,
      selectedAddons: addons,
      tradeInDiscount
    };
    setCartItems(prev => [...prev, newItem]);
    setIsCartOpen(true);
  };

  const handleBuyNow = (
    product: PhoneProduct,
    color: ColorOption,
    storage: StorageOption,
    addons: PlanAddon[],
    tradeInDiscount: number
  ) => {
    const newItemId = `${product.id}-${color.name}-${storage.size}-${Date.now()}`;
    const newItem: CartItem = {
      id: newItemId,
      product,
      selectedColor: color,
      selectedStorage: storage,
      quantity: 1,
      selectedAddons: addons,
      tradeInDiscount
    };
    setCartItems([newItem]);
    setIsCheckoutOpen(true);
  };

  const handleUpdateQuantity = (id: string, delta: number) => {
    setCartItems(prev =>
      prev
        .map(item => {
          if (item.id === id) {
            const newQty = item.quantity + delta;
            return newQty > 0 ? { ...item, quantity: newQty } : null;
          }
          return item;
        })
        .filter(Boolean) as CartItem[]
    );
  };

  const handleRemoveItem = (id: string) => {
    setCartItems(prev => prev.filter(item => item.id !== id));
  };

  const handleOrderSuccess = (order: OrderRecord) => {
    setOrders(prev => [order, ...prev]);
    setCartItems([]);
    setIsCheckoutOpen(false);
    setActiveTab('orders');
  };

  // const handleShareApp = () => {
  //   const MiniApp = (window as any).MiniApp;
  //   if (MiniApp && typeof MiniApp.share === 'function') {
  //     MiniApp.share({
  //       title: 'Mini Phone Shop',
  //       text: 'Buy authentic flagship smartphones with KHQR & 0% installments!',
  //       url: window.location.href
  //     });
  //   } else if (navigator.share) {
  //     navigator.share({
  //       title: 'Mini Phone Shop',
  //       text: 'Buy authentic flagship smartphones with KHQR & 0% installments!',
  //       url: window.location.href
  //     }).catch(() => { });
  //   } else {
  //     alert('Link copied to clipboard!');
  //   }
  // };

  // const handleExitApp = () => {
  //   const MiniApp = (window as any).MiniApp;
  //   if (MiniApp && typeof MiniApp.exit === 'function') {
  //     MiniApp.exit(true);
  //   }
  // };

  return (
    <div className="app-viewport">
      {/* App Header */}
      <header className="app-header">
        {/* <div className="header-top">
          <div className="brand-badge">
            <Smartphone size={20} color="#38bdf8" />
            <span>PHONE STORE</span>
          </div>

          <div className="header-actions">
            <button className="icon-btn" onClick={handleShareApp} aria-label="Share Store">
              <Share2 size={16} />
            </button>
            <button className="icon-btn" onClick={() => setIsCartOpen(true)} aria-label="Open Shopping Bag">
              <ShoppingBag size={16} />
              {totalCartCount > 0 && <span className="badge-count">{totalCartCount}</span>}
            </button>
            <button className="icon-btn" onClick={handleExitApp} aria-label="Exit MiniApp">
              <XCircle size={16} />
            </button>
          </div>
        </div> */}

        {/* User Greeting & Native SuperApp Bridge Bar */}
        <div className="user-mascot-bar">
          <div style={{ display: 'flex', alignItems: 'center' }}>
            <div className="mascot-avatar">
              📱
            </div>
            <div className="user-info">
              <div className="user-name">
                <span>{userName}</span>
                <Sparkles size={13} color="#f59e0b" />
              </div>
              <div className="user-phone">{userPhone}</div>
            </div>
          </div>

          <div className="bridge-status-pill">
            <span className="bridge-dot" />
            <span>MiniApp Bridge</span>
          </div>
        </div>
      </header>

      {/* Main Content Area */}
      <main className="main-content">
        {isLoading ? (
          <div style={{ textAlign: 'center', padding: '4rem 1rem' }}>
            <Loader2 size={36} color="#38bdf8" style={{ animation: 'spin 1s linear infinite' }} />
            <div style={{ marginTop: '1rem', color: 'var(--text-secondary)', fontWeight: 600 }}>
              Loading phone products...
            </div>
            <style>{`
              @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
            `}</style>
          </div>
        ) : (
          <>
            {activeTab === 'phones' && (
              <ShopHome
                phones={phones}
                onSelectProduct={prod => setSelectedProduct(prod)}
              />
            )}

            {activeTab === 'plans' && (
              <PlansTab
                onQuickPurchase={addon => {
                  const dummyProduct: PhoneProduct = {
                    id: addon.id,
                    brand: 'Apple',
                    name: addon.name,
                    tagline: addon.description,
                    basePrice: addon.price,
                    rating: 5.0,
                    reviewsCount: 1,
                    colors: [{ name: 'Digital', hex: '#38bdf8', image: 'https://images.unsplash.com/photo-1592899677977-9c10ca588bbd?w=600&auto=format&fit=crop&q=80' }],
                    storageOptions: [{ size: 'Digital eSIM', priceDelta: 0 }],
                    specs: { screen: 'eSIM', processor: '5G', camera: 'N/A', battery: 'N/A', network: '5G', os: 'eSIM' },
                    highlights: [addon.description],
                    inStock: true
                  };
                  handleBuyNow(dummyProduct, dummyProduct.colors[0], dummyProduct.storageOptions[0], [], 0);
                }}
              />
            )}

            {activeTab === 'orders' && <OrdersTab orders={orders} />}
          </>
        )}
      </main>

      {/* Bottom Navigation */}
      <BottomNav
        activeTab={activeTab}
        onSelectTab={tab => setActiveTab(tab)}
        orderBadgeCount={orders.length}
      />

      {/* Product Detail Modal */}
      <PhoneDetailModal
        product={selectedProduct}
        onClose={() => setSelectedProduct(null)}
        onAddToCart={handleAddToCart}
        onBuyNow={handleBuyNow}
      />

      {/* Cart Drawer */}
      <CartDrawer
        isOpen={isCartOpen}
        onClose={() => setIsCartOpen(false)}
        items={cartItems}
        onUpdateQuantity={handleUpdateQuantity}
        onRemoveItem={handleRemoveItem}
        onProceedToCheckout={() => {
          setIsCartOpen(false);
          setIsCheckoutOpen(true);
        }}
      />

      {/* Checkout Gateway Modal */}
      <CheckoutModal
        isOpen={isCheckoutOpen}
        onClose={() => setIsCheckoutOpen(false)}
        items={cartItems}
        customerName={userName}
        customerPhone={userPhone}
        onOrderSuccess={handleOrderSuccess}
      />
    </div>
  );
};
