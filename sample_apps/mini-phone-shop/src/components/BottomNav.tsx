import React from 'react';
import { Smartphone, Radio, FileText } from 'lucide-react';

export type TabType = 'phones' | 'plans' | 'orders';

interface BottomNavProps {
  activeTab: TabType;
  onSelectTab: (tab: TabType) => void;
  orderBadgeCount?: number;
}

export const BottomNav: React.FC<BottomNavProps> = ({
  activeTab,
  onSelectTab,
  orderBadgeCount = 0
}) => {
  return (
    <div className="bottom-nav-wrapper">
      <div className="bottom-nav-pill">
        <button
          className={`nav-tab-btn ${activeTab === 'phones' ? 'active' : ''}`}
          onClick={() => onSelectTab('phones')}
        >
          <Smartphone size={18} />
          <span>Phones</span>
        </button>

        <button
          className={`nav-tab-btn ${activeTab === 'plans' ? 'active' : ''}`}
          onClick={() => onSelectTab('plans')}
        >
          <Radio size={18} />
          <span>Plans & eSIM</span>
        </button>

        <button
          className={`nav-tab-btn ${activeTab === 'orders' ? 'active' : ''}`}
          onClick={() => onSelectTab('orders')}
          style={{ position: 'relative' }}
        >
          <FileText size={18} />
          <span>My Orders</span>
          {orderBadgeCount > 0 && (
            <span
              style={{
                position: 'absolute',
                top: '4px',
                right: '18px',
                background: '#f43f5e',
                color: 'white',
                fontSize: '0.6rem',
                borderRadius: '8px',
                padding: '0 4px',
                fontWeight: 700
              }}
            >
              {orderBadgeCount}
            </span>
          )}
        </button>
      </div>
    </div>
  );
};
