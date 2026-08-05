<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Sales Analytics</h1>
            <p class="page-subtitle">Track your revenue, best-selling products, and overall business performance.</p>
          </div>
          <div class="header-right">
            <PPButton variant="primary">Export Report</PPButton>
          </div>
        </div>

        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-label">Total Revenue</div>
            <div class="stat-value">$24,500</div>
            <div class="stat-change positive">+15% from last month</div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Orders</div>
            <div class="stat-value">342</div>
            <div class="stat-change positive">+5% from last month</div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Average Order Value</div>
            <div class="stat-value">$71.63</div>
            <div class="stat-change negative">-2% from last month</div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Conversion Rate</div>
            <div class="stat-value">3.2%</div>
            <div class="stat-change positive">+0.4% from last month</div>
          </div>
        </div>

        <div class="charts-grid">
          <div class="chart-card wide">
            <h2 class="section-title">Revenue Over Time</h2>
            <div style="height: 300px">
              <PPLineChart :data="revenueData" :labels="revenueLabels" />
            </div>
          </div>
          
          <div class="chart-card">
            <h2 class="section-title">Sales by Category</h2>
            <div style="height: 300px">
              <PPPieChart :data="categoryData" />
            </div>
          </div>
          
          <div class="chart-card">
            <h2 class="section-title">Top Products</h2>
            <div style="height: 300px">
              <PPBarChart :data="productData" />
            </div>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent } from '@ionic/vue';
import { PPButton, PPLineChart, PPPieChart, PPBarChart } from '@phanna/ui-framework';

const revenueData = [12000, 15000, 14000, 18000, 22000, 24500, 21000];
const revenueLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];

const categoryData = [
  { label: 'Electronics', value: 45, color: '#3b82f6' },
  { label: 'Clothing', value: 25, color: '#10b981' },
  { label: 'Home & Garden', value: 20, color: '#f59e0b' },
  { label: 'Sports', value: 10, color: '#ef4444' }
];

const productData = [
  { label: 'Headphones', value: 120, color: '#6366f1' },
  { label: 'T-Shirt', value: 85, color: '#6366f1' },
  { label: 'Coffee Mug', value: 60, color: '#6366f1' },
  { label: 'Yoga Mat', value: 45, color: '#6366f1' }
];
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.page-container {
  padding: 40px;
  width: 100%;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
  margin-bottom: 32px;
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  border: 1px solid #e2e8f0;
}

.stat-label {
  font-size: 14px;
  color: #64748b;
  margin-bottom: 8px;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 8px;
}

.stat-change {
  font-size: 13px;
  font-weight: 500;
}

.stat-change.positive { color: #10b981; }
.stat-change.negative { color: #ef4444; }

.charts-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

.chart-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.chart-card.wide {
  grid-column: 1 / -1;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #334155;
  margin: 0 0 16px 0;
}

@media (max-width: 1024px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .header-section {
    flex-direction: column;
    gap: 16px;
  }
  .page-container {
    padding: 20px;
  }
  .stats-grid {
    grid-template-columns: 1fr;
  }
  .charts-grid {
    grid-template-columns: 1fr;
  }
}
</style>
