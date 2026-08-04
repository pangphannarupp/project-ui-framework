<template>
  <div class="guide-section">
    <h2>Application Layout Templates</h2>
    <p>These templates demonstrate how to combine various UI framework components to create complex, real-world application layouts for Mobile, Web, and Desktop environments.</p>

    <!-- Mobile Layout -->
    <div class="variant-group">
      <h3>Mobile Layout: Social Media Feed</h3>
      <p class="custom-guide">A classic mobile-first layout featuring a bottom navigation bar, a scrolling feed, a floating action button (FAB), and a top app bar.</p>
      
      <div class="component-demo mobile-demo-wrapper">
        <!-- Mock Phone Container -->
        <div class="mock-phone">
          <PPMaterialApp>
            <template #header>
              <div class="mobile-header">
                <span class="app-title">SocialFeed</span>
                <div class="header-actions">
                  <PPIconButton :icon="searchOutline" size="small" />
                  <PPIconButton :icon="notificationsOutline" size="small" badge />
                </div>
              </div>
            </template>

            <!-- Scrollable Feed -->
            <div class="feed-container">
              <div class="post-card" v-for="i in 3" :key="i">
                <div class="post-header">
                  <div class="avatar"></div>
                  <div class="post-meta">
                    <span class="user-name">User {{ i }}</span>
                    <span class="post-time">2 hours ago</span>
                  </div>
                </div>
                <div class="post-content">
                  This is a sample post in the social media feed to demonstrate the layout. The bottom navigation provides easy access to primary routes, while the FAB handles the primary action.
                </div>
                <div class="post-actions">
                  <PPIconButton :icon="heartOutline" size="small" />
                  <PPIconButton :icon="chatbubbleOutline" size="small" />
                  <PPIconButton :icon="shareOutline" size="small" />
                </div>
              </div>
              <div style="height: 80px;"></div> <!-- Spacer for FAB/Nav -->
            </div>

            <!-- FAB -->
            <div style="position: absolute; bottom: 70px; right: 16px;">
              <PPFab :icon="addOutline" color="primary" />
            </div>

            <!-- Bottom Nav -->
            <template #footer>
              <PPBottomNav 
                v-model="mobileTab"
                :items="[
                  { label: 'Home', value: 'home', icon: homeOutline },
                  { label: 'Explore', value: 'explore', icon: compassOutline },
                  { label: 'Profile', value: 'profile', icon: personOutline }
                ]"
              />
            </template>
          </PPMaterialApp>
        </div>
      </div>
    </div>

    <!-- Web Dashboard Layout -->
    <div class="variant-group" style="margin-top: 48px;">
      <h3>Web Layout: Analytics Dashboard</h3>
      <p class="custom-guide">A responsive web layout with a permanent sidebar navigation, a top header, and a grid-based dashboard.</p>
      
      <div class="component-demo web-demo-wrapper">
        <div class="dashboard-layout">
          <!-- Sidebar -->
          <div class="dashboard-sidebar">
            <div class="sidebar-logo">AnalyticsPro</div>
            <ul class="sidebar-nav">
              <li class="active"><ion-icon :icon="pieChartOutline" /> Overview</li>
              <li><ion-icon :icon="barChartOutline" /> Reports</li>
              <li><ion-icon :icon="peopleOutline" /> Audience</li>
              <li><ion-icon :icon="settingsOutline" /> Settings</li>
            </ul>
          </div>
          
          <!-- Main Area -->
          <div class="dashboard-main">
            <!-- Header -->
            <div class="dashboard-header">
              <span class="page-title">Overview</span>
              <div class="user-profile">
                <div class="avatar-small"></div>
                <span>Admin User</span>
              </div>
            </div>
            
            <!-- Grid Content -->
            <div class="dashboard-content">
              <div class="stats-grid">
                <div class="stat-card">
                  <span class="stat-label">Total Users</span>
                  <span class="stat-value">24,592</span>
                </div>
                <div class="stat-card">
                  <span class="stat-label">Revenue</span>
                  <span class="stat-value">$12,450</span>
                </div>
                <div class="stat-card">
                  <span class="stat-label">Bounce Rate</span>
                  <span class="stat-value">42.3%</span>
                </div>
              </div>
              <div class="chart-card">
                <div class="chart-placeholder">
                  <ion-icon :icon="barChartOutline" style="font-size: 64px; color: #cbd5e1;" />
                  <span>Interactive Chart Area</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Desktop Mail Client -->
    <div class="variant-group" style="margin-top: 48px;">
      <h3>Desktop Layout: Mail Client (3-Pane View)</h3>
      <p class="custom-guide">A dense, information-rich layout utilizing a 3-pane structure typical of native desktop applications.</p>
      
      <div class="component-demo desktop-demo-wrapper">
        <div class="mail-layout">
          <!-- Left Pane: Folders -->
          <div class="pane-folders">
            <div class="folder-header">Mailbox</div>
            <ul class="folder-list">
              <li class="active"><ion-icon :icon="mailOutline" /> Inbox <span class="badge">12</span></li>
              <li><ion-icon :icon="sendOutline" /> Sent</li>
              <li><ion-icon :icon="documentOutline" /> Drafts</li>
              <li><ion-icon :icon="trashOutline" /> Trash</li>
            </ul>
          </div>
          
          <!-- Middle Pane: Message List -->
          <div class="pane-list">
            <div class="list-search">
              <ion-icon :icon="searchOutline" />
              <input type="text" placeholder="Search mail..." />
            </div>
            <div class="message-item active">
              <div class="msg-sender">Product Team</div>
              <div class="msg-subject">Q3 Roadmap Update</div>
              <div class="msg-preview">Here is the latest update regarding our...</div>
            </div>
            <div class="message-item">
              <div class="msg-sender">Design Dept</div>
              <div class="msg-subject">New UI Assets</div>
              <div class="msg-preview">Please find attached the latest assets...</div>
            </div>
          </div>
          
          <!-- Right Pane: Reading Pane -->
          <div class="pane-reading">
            <!-- Ribbon for Actions -->
            <PPRibbon variant="classic" :collapsible="true" model-value="message">
              <PPRibbonTab title="Message" id="message">
                <PPRibbonGroup title="Respond">
                  <PPRibbonButton :icon="arrowUndoOutline" label="Reply" size="large" />
                  <PPRibbonButton :icon="arrowRedoOutline" label="Forward" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Delete">
                  <PPRibbonButton :icon="trashOutline" label="Delete" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
            </PPRibbon>
            
            <div class="email-content">
              <h2 style="margin-top: 0; margin-bottom: 8px; font-size: 24px; color: #0f172a;">Q3 Roadmap Update</h2>
              <div class="email-meta">From: Product Team &lt;product@example.com&gt;</div>
              <div class="email-body">
                <p>Hello everyone,</p>
                <p>We are excited to share the upcoming milestones for Q3. We will be focusing heavily on optimizing the desktop layouts and improving performance across the board.</p>
                <p>Best,<br>Product Team</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { 
  searchOutline, notificationsOutline, addOutline, heartOutline, chatbubbleOutline, shareOutline,
  homeOutline, compassOutline, personOutline, pieChartOutline, barChartOutline, peopleOutline, settingsOutline,
  mailOutline, sendOutline, documentOutline, trashOutline, arrowUndoOutline, arrowRedoOutline
} from 'ionicons/icons';
import { 
  PPMaterialApp, PPFab, PPBottomNav, PPIconButton,
  PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton
} from '@phanna/ui-framework';

const mobileTab = ref('home');
</script>

<style scoped>
/* Mobile Layout */
.mobile-demo-wrapper {
  display: flex;
  justify-content: center;
  background-color: #f1f5f9;
  padding: 32px 0;
  border-radius: 8px;
}
.mock-phone {
  width: 375px;
  height: 700px;
  border: 12px solid #1e293b;
  border-radius: 36px;
  overflow: hidden;
  position: relative;
  background: white;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}
.mobile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: white;
  border-bottom: 1px solid #e2e8f0;
}
.app-title {
  font-size: 18px;
  font-weight: 700;
  color: #0f172a;
}
.header-actions {
  display: flex;
  gap: 8px;
}
.feed-container {
  padding: 16px;
  background: #f8fafc;
  height: calc(100% - 110px);
  overflow-y: auto;
}
.post-card {
  background: white;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  border: 1px solid #e2e8f0;
}
.post-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #cbd5e1;
}
.post-meta {
  display: flex;
  flex-direction: column;
}
.user-name { font-weight: 600; font-size: 14px; }
.post-time { font-size: 12px; color: #64748b; }
.post-content { font-size: 14px; color: #334155; margin-bottom: 12px; line-height: 1.5; }
.post-actions {
  display: flex;
  gap: 16px;
  border-top: 1px solid #f1f5f9;
  padding-top: 8px;
}

/* Web Dashboard Layout */
.web-demo-wrapper {
  background-color: #f1f5f9;
  padding: 24px;
  border-radius: 8px;
}
.dashboard-layout {
  display: flex;
  height: 600px;
  background: #f8fafc;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
  border: 1px solid #e2e8f0;
}
.dashboard-sidebar {
  width: 240px;
  background: #1e293b;
  color: white;
  display: flex;
  flex-direction: column;
}
.sidebar-logo {
  padding: 24px;
  font-size: 20px;
  font-weight: bold;
  border-bottom: 1px solid #334155;
  color: #38bdf8;
}
.sidebar-nav {
  list-style: none;
  padding: 16px 0;
  margin: 0;
}
.sidebar-nav li {
  padding: 12px 24px;
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
  color: #cbd5e1;
}
.sidebar-nav li:hover { background: #334155; }
.sidebar-nav li.active { background: #0ea5e9; color: white; font-weight: 500; }
.dashboard-main {
  flex: 1;
  display: flex;
  flex-direction: column;
}
.dashboard-header {
  height: 64px;
  background: white;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
}
.page-title { font-size: 20px; font-weight: 600; color: #0f172a; }
.user-profile {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  font-weight: 500;
}
.avatar-small { width: 32px; height: 32px; border-radius: 50%; background: #94a3b8; }
.dashboard-content {
  padding: 24px;
  flex: 1;
  overflow-y: auto;
}
.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  margin-bottom: 24px;
}
.stat-card {
  background: white;
  padding: 24px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.stat-label { font-size: 14px; color: #64748b; font-weight: 500; }
.stat-value { font-size: 32px; font-weight: 700; color: #0f172a; }
.chart-card {
  background: white;
  height: 300px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  padding: 24px;
}
.chart-placeholder {
  width: 100%;
  height: 100%;
  background: #f8fafc;
  border: 2px dashed #cbd5e1;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
  color: #94a3b8;
}

/* Desktop Mail Layout */
.desktop-demo-wrapper {
  background-color: #f1f5f9;
  padding: 24px;
  border-radius: 8px;
}
.mail-layout {
  display: flex;
  height: 600px;
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
  border: 1px solid #e2e8f0;
}
.pane-folders {
  width: 200px;
  background: #f8fafc;
  border-right: 1px solid #e2e8f0;
  display: flex;
  flex-direction: column;
}
.folder-header {
  padding: 16px;
  font-weight: 600;
  color: #64748b;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.folder-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.folder-list li {
  padding: 8px 16px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  color: #334155;
  cursor: pointer;
}
.folder-list li:hover { background: #e2e8f0; }
.folder-list li.active { background: #e0f2fe; color: #0284c7; font-weight: 500; border-left: 3px solid #0284c7; }
.folder-list ion-icon { font-size: 18px; }
.badge { margin-left: auto; background: #0284c7; color: white; padding: 2px 6px; border-radius: 12px; font-size: 11px; }

.pane-list {
  width: 300px;
  background: white;
  border-right: 1px solid #e2e8f0;
  display: flex;
  flex-direction: column;
}
.list-search {
  padding: 12px;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  gap: 8px;
  background: #f8fafc;
}
.list-search input {
  border: none; background: transparent; outline: none; width: 100%; font-size: 13px;
}
.message-item {
  padding: 16px;
  border-bottom: 1px solid #e2e8f0;
  cursor: pointer;
}
.message-item:hover { background: #f8fafc; }
.message-item.active { background: #eff6ff; }
.msg-sender { font-weight: 600; font-size: 14px; color: #0f172a; margin-bottom: 4px; }
.msg-subject { font-size: 13px; font-weight: 500; color: #334155; margin-bottom: 4px; }
.msg-preview { font-size: 12px; color: #64748b; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

.pane-reading {
  flex: 1;
  display: flex;
  flex-direction: column;
  background: white;
}
.pane-reading :deep(.pp-ribbon--classic .pp-ribbon-header) {
  padding-top: 0;
}
.pane-reading :deep(.pp-ribbon--classic .pp-ribbon-tab-header) {
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
.pane-reading :deep(.pp-ribbon-tabs) {
  padding: 0 8px;
}
.email-content {
  padding: 32px;
  flex: 1;
  overflow-y: auto;
}
.email-meta { font-size: 13px; color: #64748b; margin-bottom: 32px; border-bottom: 1px solid #e2e8f0; padding-bottom: 16px; }
.email-body { font-size: 15px; color: #334155; line-height: 1.6; }
</style>
