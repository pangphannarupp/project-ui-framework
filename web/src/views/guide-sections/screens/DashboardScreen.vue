<template>
  <div class="component-section" style="padding: 0; background: #f8f9fa;">
    <div class="demo-box dashboard-demo">
      <div class="dashboard-layout">
        <!-- Sidebar Navigation -->
        <PPSidebarNavigation
          v-model="activeTab"
          :items="sidebarMenu"
          theme="dark"
          variant="indicator"
          style="background: #1c2434;"
        >
          <template #header>
            <div class="sidebar-logo">
              <span>React Dashboard</span>
            </div>
          </template>
        </PPSidebarNavigation>

        <!-- Main Content -->
        <div class="dashboard-main">
          <!-- App Bar -->
          <PPHeaderBar theme="light" height="64px" :bordered="true">
            <template #left>
              <div class="header-search">
                <ion-icon :icon="searchOutline" />
              </div>
            </template>
            <template #right>
              <div class="header-user">
                <div class="user-info">
                  <span class="user-name">Bill Ford</span>
                  <span class="user-role">Administrator</span>
                </div>
              </div>
            </template>
          </PPHeaderBar>

          <div class="dashboard-content">
            
            <div class="top-grid">
              <!-- Left Side: KPIs and Medium Cards -->
              <div class="left-section">
                <!-- 4 KPIs -->
                <div class="kpi-grid">
                  <div class="kpi-card">
                    <div class="kpi-info">
                      <span class="kpi-label">Profit</span>
                      <span class="kpi-value">$5,783</span>
                    </div>
                    <div class="kpi-icon" style="color: #0dcaf0;">
                      <ion-icon :icon="giftOutline" />
                    </div>
                  </div>
                  
                  <div class="kpi-card">
                    <div class="kpi-info">
                      <span class="kpi-label">No. of Orders</span>
                      <span class="kpi-value">15830</span>
                    </div>
                    <div class="kpi-icon" style="color: #0dcaf0;">
                      <ion-icon :icon="bagHandleOutline" />
                    </div>
                  </div>
                  
                  <div class="kpi-card">
                    <div class="kpi-info">
                      <span class="kpi-label">Avg Price</span>
                      <span class="kpi-value">$8,780</span>
                    </div>
                    <div class="kpi-icon" style="color: #0dcaf0;">
                      <ion-icon :icon="cashOutline" />
                    </div>
                  </div>
                  
                  <div class="kpi-card">
                    <div class="kpi-info">
                      <span class="kpi-label">Sold</span>
                      <span class="kpi-value">7082</span>
                    </div>
                    <div class="kpi-icon" style="color: #0dcaf0;">
                      <ion-icon :icon="pricetagOutline" />
                    </div>
                  </div>
                </div>

                <!-- 2 Medium Cards -->
                <div class="medium-cards-grid">
                  <div class="card conversion-card">
                    <div class="card-header-simple">
                      <div class="card-big-value">98.94%</div>
                      <div class="card-sub-label" style="color: #0dcaf0;">Conversion Statistics</div>
                      <div class="card-desc">Number of conversions vs footsteps.</div>
                    </div>
                    <div class="chart-wrap" style="margin-top: auto;">
                      <PPLineChart 
                        :data="[10, 20, 15, 30, 25, 40, 35]" 
                        :height="120"
                        color="#0dcaf0"
                        fillColor="#0dcaf0"
                        :showGrid="false"
                        :showPoints="false"
                      />
                      <div class="chart-bottom-labels">
                        <div class="c-label">
                          <span>10</span><span>2018</span>
                        </div>
                        <div class="c-label">
                          <span>15</span><span>2017</span>
                        </div>
                        <div class="c-label">
                          <span>13</span><span>2016</span>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="card orders-card">
                    <div class="card-header-simple">
                      <div class="card-big-value">1432</div>
                      <div class="card-sub-label" style="color: #0dcaf0;">Placed Orders</div>
                      <div class="card-desc">Number of orders placed yearly.</div>
                    </div>
                    <div class="card-stats-row">
                      <div class="c-stat"><span>130</span><span>Jun</span></div>
                      <div class="c-stat"><span>251</span><span>July</span></div>
                      <div class="c-stat"><span>235</span><span>Aug</span></div>
                    </div>
                    <div class="chart-wrap bar-sim" style="margin-top: auto; display: flex; align-items: flex-end; gap: 4px; height: 60px; padding: 0 16px;">
                      <div v-for="h in [20,40,30,50,45,20,10,30,60,80,40,30,50,60,90,70,50,30,20,10]" :key="h" class="bar-stick" :style="{ height: h + '%' }"></div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Right Side: Large Chart -->
              <div class="right-section">
                <div class="card large-chart-card">
                  <div class="card-title">Monthly Total/Avg Report</div>
                  <div class="large-stats">
                    <div class="stat-block">
                      <span class="l-val">$25,319.06</span>
                      <span class="l-lbl">Total</span>
                    </div>
                    <div class="stat-block">
                      <span class="l-val">$2010.00</span>
                      <span class="l-lbl">Avg.</span>
                    </div>
                    <div class="chart-actions">
                      <ion-icon :icon="addCircleOutline" />
                      <ion-icon :icon="removeCircleOutline" />
                      <ion-icon :icon="downloadOutline" />
                    </div>
                  </div>
                  <div class="main-chart-wrapper">
                    <PPLineChart 
                      :data="[30, 25, 36, 30, 45, 35, 64, 52, 58, 36, 39, 50]" 
                      :labels="['Jan 01', 'Feb 01', 'Mar 01', 'Apr 01', 'May 01', 'Jun 01', 'Jul 01', 'Aug 01', 'Sep 01', 'Oct 01', 'Nov 01', 'Dec 01']"
                      :height="300"
                      color="#3b82f6"
                      :fillArea="false"
                      :strokeWidth="3"
                      :showPoints="false"
                    />
                    <!-- Simulated bars behind -->
                    <div class="bg-bars">
                      <div v-for="(h, i) in [23, 11, 22, 27, 13, 22, 37, 21, 44, 22, 30, 40]" :key="i" class="bg-bar" :style="{ height: h + '%' }"></div>
                    </div>
                  </div>
                  <div class="chart-legend">
                    <span style="color: #0dcaf0">Total Sales</span>
                    <span style="color: #3b82f6">Average</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Bottom Grid -->
            <div class="bottom-grid">
              <div class="card pie-card">
                <div class="card-title">Customer Satisfaction</div>
                <p class="card-desc">It takes continuous effort to maintain high customer satisfaction levels internal and external.</p>
                <div class="download-icon"><ion-icon :icon="downloadOutline" /></div>
                
                <div class="pie-content">
                  <PPPieChart 
                    :data="[35.5, 21.5, 16.1, 26.9]"
                    :colors="['#0dcaf0', '#0dcaf0', '#0dcaf0', '#0dcaf0']"
                    :height="200"
                    style="opacity: 0.9;"
                  />
                  <!-- Note: Actual Donut chart implementation would vary, assuming PPPieChart for now -->
                  <div class="pie-legend">
                    <div class="l-item"><span class="dot exc"></span> Excellent</div>
                    <div class="l-item"><span class="dot sat"></span> Satisfied</div>
                    <div class="l-item"><span class="dot poor"></span> Poor</div>
                    <div class="l-item"><span class="dot vpoor"></span> Very Poor</div>
                  </div>
                </div>
              </div>

              <div class="card table-card">
                <div class="card-title">My Wishlist</div>
                <PPTable 
                  :columns="[
                    { key: 'description', title: 'Item Description' },
                    { key: 'status', title: 'Status', align: 'center' },
                    { key: 'price', title: 'Price', align: 'center' },
                    { key: 'action', title: 'Action', align: 'right' }
                  ]"
                  :data="wishlistItems"
                  :compact="true"
                >
                  <template #description="{ row }">
                    <div class="td-desc">
                      <div class="td-img" :style="{ backgroundImage: 'url(' + row.img + ')' }"></div>
                      <span>{{ row.desc }}</span>
                    </div>
                  </template>
                  <template #status="{ row }">
                    <span :class="['tbl-status', row.status.toLowerCase()]">{{ row.status }}</span>
                  </template>
                  <template #action="{ row }">
                    <div class="td-actions">
                      <ion-icon :icon="createOutline" style="color: #10b981" />
                      <ion-icon :icon="trashOutline" style="color: #ef4444" />
                    </div>
                  </template>
                </PPTable>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { 
  homeOutline, 
  barChartOutline, 
  optionsOutline, 
  shieldCheckmarkOutline, 
  personAddOutline, 
  folderOpenOutline,
  searchOutline,
  giftOutline,
  bagHandleOutline,
  cashOutline,
  pricetagOutline,
  addCircleOutline,
  removeCircleOutline,
  downloadOutline,
  createOutline,
  trashOutline
} from 'ionicons/icons';
import { 
  PPLineChart, 
  PPPieChart, 
  PPTable,
  PPSidebarNavigation,
  PPHeaderBar
} from '@phanna/ui-framework';
import { ref } from 'vue';

const activeTab = ref('sales-report');

const sidebarMenu = [
  {
    groupLabel: 'DASHBOARD',
    items: [
      { id: 'home', label: 'Home', icon: homeOutline },
      { id: 'charts', label: 'Charts', icon: barChartOutline },
      { id: 'filters', label: 'Filters', icon: optionsOutline },
    ]
  },
  {
    groupLabel: 'REPORTS',
    items: [
      { id: 'orders-report', label: 'Orders Report', icon: shieldCheckmarkOutline },
      { id: 'sales-report', label: 'Sales Report', icon: personAddOutline },
      { id: 'payment-report', label: 'Payment Report', icon: folderOpenOutline },
    ]
  }
];

const wishlistItems = [
  { img: 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=100&h=100&fit=crop', desc: 'Seasonal Delights', status: 'Success', price: '$10' },
  { img: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=100&h=100&fit=crop', desc: 'Medicinal Value Packed', status: 'Cancel', price: '$10' }
];
</script>

<style scoped>
.dashboard-demo {
  padding: 0;
  background: #f1f5f9;
  border-radius: 12px;
  overflow: hidden;
  height: 900px;
}

.dashboard-layout {
  display: flex;
  height: 100%;
  width: 100%;
}

.sidebar-logo {
  padding: 24px;
  font-size: 20px;
  font-weight: 700;
  color: #fff;
  border-bottom: 1px solid rgba(255,255,255,0.05);
}

.dashboard-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.header-search {
  color: #64748b;
  font-size: 20px;
  cursor: pointer;
}

.header-user {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-info {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}
.user-name {
  font-size: 14px;
  font-weight: 600;
  color: #1e293b;
}
.user-role {
  font-size: 12px;
  color: #64748b;
}

.dashboard-content {
  flex: 1;
  padding: 24px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.card {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  padding: 24px;
  display: flex;
  flex-direction: column;
}
.card-title {
  font-size: 16px;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 16px;
}

/* TOP GRID */
.top-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

.left-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* KPIs */
.kpi-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}
.kpi-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.kpi-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.kpi-label {
  font-size: 13px;
  font-weight: 600;
  color: #64748b;
}
.kpi-value {
  font-size: 22px;
  font-weight: 700;
  color: #1e293b;
}
.kpi-icon {
  font-size: 24px;
}

/* Medium Cards */
.medium-cards-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  flex: 1;
}
.card-header-simple {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.card-big-value {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
}
.card-sub-label {
  font-size: 13px;
  font-weight: 600;
}
.card-desc {
  font-size: 12px;
  color: #64748b;
  margin-top: 4px;
  line-height: 1.4;
}

.chart-bottom-labels {
  display: flex;
  justify-content: space-between;
  padding: 12px 16px;
  background: #0dcaf0;
  color: #fff;
  border-radius: 0 0 12px 12px;
  margin: 0 -24px -24px -24px;
}
.c-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 12px;
}
.c-label span:first-child { font-weight: 700; font-size: 14px; }

.card-stats-row {
  display: flex;
  justify-content: space-between;
  margin-top: 16px;
}
.c-stat {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 12px;
  color: #64748b;
}
.c-stat span:first-child { font-weight: 700; font-size: 16px; color: #1e293b; }

.bar-stick {
  flex: 1;
  background: #0dcaf0;
  border-radius: 2px 2px 0 0;
}

/* Large Chart */
.right-section {
  display: flex;
}
.large-chart-card {
  flex: 1;
}
.large-stats {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 24px;
}
.stat-block {
  display: flex;
  flex-direction: column;
}
.l-val { font-size: 22px; font-weight: 700; color: #1e293b; }
.l-lbl { font-size: 13px; color: #64748b; font-weight: 500; }
.chart-actions {
  margin-left: auto;
  display: flex;
  gap: 12px;
  color: #94a3b8;
  font-size: 18px;
}

.main-chart-wrapper {
  position: relative;
  height: 300px;
}
.bg-bars {
  position: absolute;
  bottom: 24px;
  left: 20px;
  right: 20px;
  top: 0;
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  padding: 0 10px;
  pointer-events: none;
}
.bg-bar {
  width: 14px;
  background: #0dcaf0;
  opacity: 0.8;
  border-radius: 2px 2px 0 0;
}
.chart-legend {
  display: flex;
  justify-content: center;
  gap: 24px;
  font-size: 13px;
  font-weight: 600;
  margin-top: 12px;
}

/* BOTTOM GRID */
.bottom-grid {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 24px;
}
.pie-card {
  position: relative;
}
.download-icon {
  position: absolute;
  top: 24px;
  right: 24px;
  color: #94a3b8;
}
.pie-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 24px;
}
.pie-legend {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-left: auto;
  position: absolute;
  right: 24px;
  bottom: 24px;
}
.l-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  color: #64748b;
}
.dot {
  width: 8px; height: 8px; border-radius: 50%;
}
.dot.exc { background: #0dcaf0; opacity: 1; }
.dot.sat { background: #0dcaf0; opacity: 0.8; }
.dot.poor { background: #0dcaf0; opacity: 0.6; }
.dot.vpoor { background: #0dcaf0; opacity: 0.4; }

.table-card {
  overflow: auto;
}
.td-desc {
  display: flex;
  align-items: center;
  gap: 12px;
}
.td-img {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background-size: cover;
  background-position: center;
}
.tbl-status {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 600;
}
.tbl-status.success { background: #dcfce7; color: #16a34a; }
.tbl-status.cancel { background: #fee2e2; color: #dc2626; }

.td-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  font-size: 16px;
}

@media (max-width: 1200px) {
  .top-grid { grid-template-columns: 1fr; }
  .bottom-grid { grid-template-columns: 1fr; }
}
</style>
