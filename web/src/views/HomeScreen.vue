<template>
  <ion-page>
    <div class="biz-screen biz-home-screen">
    
    <!-- Floating Back Button for Dev Navigation -->
    <button class="dev-back-btn" @click="router.push('/')">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="19" y1="12" x2="5" y2="12"></line>
        <polyline points="12 19 5 12 12 5"></polyline>
      </svg>
      Back to List
    </button>

    <!-- Top App Bar / Profile Area -->
    <div class="top-bar">
      <BizUserProfile 
        :userName="userName" 
        :role="userRole" 
        :isVerified="isVerified" 
      />
      <div class="top-actions">
        <BizIconButton color="danger">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
            <rect x="7" y="7" width="3" height="3"></rect>
            <rect x="14" y="7" width="3" height="3"></rect>
            <rect x="7" y="14" width="3" height="3"></rect>
          </svg>
        </BizIconButton>
        <BizIconButton color="white" badge>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
            <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
          </svg>
        </BizIconButton>
      </div>
    </div>

    <!-- Main Scrollable Card -->
    <div class="main-card">
      
      <!-- Company Selector -->
      <div class="section-container">
        <div class="section-label" style="margin-bottom: 8px;">Now Managing</div>
        <BizCompanySelector 
          :companyName="companyName"
          :companyType="companyType"
        />
      </div>

      <!-- Action Center -->
      <div class="section-container">
        <h2 class="section-title">Action Center</h2>
        <div class="action-grid">
          <BizActionCard 
            title="Approval" 
            subtitle="Pending" 
            badgeCount="5" 
            badgeColor="pink" 
          />
          <BizActionCard 
            title="Payment" 
            subtitle="Due today" 
            badgeCount="2" 
            badgeColor="orange" 
          />
          <BizActionCard 
            title="Payment" 
            subtitle="In process" 
            badgeCount="2" 
            badgeColor="teal" 
          />
          <BizActionCard 
            title="Send" 
            badgeColor="blue" 
          >
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10"></circle>
                <polyline points="12 16 16 12 12 8"></polyline>
                <line x1="8" y1="12" x2="16" y2="12"></line>
              </svg>
            </template>
          </BizActionCard>
          <BizActionCard 
            title="Pay Bill" 
            badgeColor="blue"
          >
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="2" y="5" width="20" height="14" rx="2"></rect>
                <line x1="2" y1="10" x2="22" y2="10"></line>
              </svg>
            </template>
          </BizActionCard>
          <BizActionCard 
            title="Users" 
            badgeColor="pink"
          >
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </template>
          </BizActionCard>
        </div>
      </div>

      <!-- My Accounts -->
      <div class="section-container">
        <div class="section-header-row">
          <h2 class="section-title">My Accounts (10)</h2>
        </div>
        
        <BizSegment v-model="accountTab" class="account-segment">
          <BizSegmentButton value="deposits">Deposits</BizSegmentButton>
          <BizSegmentButton value="loans">Loans</BizSegmentButton>
          <BizSegmentButton value="cards">Cards</BizSegmentButton>
        </BizSegment>

        <div class="account-filters">
          <div class="filter-col">
            <label>Accounts</label>
            <BizSelect v-model="accountFilter" :options="[{ label: 'All Accounts', value: 'all' }]" />
          </div>
          <div class="filter-col">
            <label>Currency</label>
            <BizSelect v-model="currencyFilter" :options="[{ label: 'All', value: 'all' }]" />
          </div>
        </div>
        
        <div class="accounts-list">
          <BizAccountListCard 
            type="Savings"
            accountName="Chan Ty' Saving"
            accountNumber="1-120-14335454-8"
            :balance="12000000.00"
            currency="USD"
            v-model:isHidden="hideDeposit1"
            @action-click="openActionSheet"
          />
          <BizAccountListCard 
            type="Savings"
            accountName="Chan Ty' Saving"
            accountNumber="1-120-14335454-8"
            :balance="12000000.00"
            currency="USD"
            v-model:isHidden="hideDeposit2"
            @action-click="openActionSheet"
          />
          <BizAccountListCard 
            type="Savings"
            accountName="Chan Ty' Saving"
            accountNumber="1-120-14335454-8"
            :balance="12000000.00"
            currency="USD"
            v-model:isHidden="hideDeposit3"
            @action-click="openActionSheet"
          />
        </div>
      </div>
      
      <!-- Account Action Bottom Sheet -->
      <BizBottomSheet v-model="showActionSheet" title="">
        <ul style="list-style: none; padding: 0; margin: 0;">
          <li class="action-item" @click="closeActionSheet">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><path d="M8 12h8"/><path d="M12 8v8"/></svg>
            <span>Receive Money by QR</span>
          </li>
          <li class="action-item" @click="closeActionSheet">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            <span>Manage Schedule</span>
          </li>
          <li class="action-item" @click="closeActionSheet">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><circle cx="18" cy="5" r="3"/><circle cx="6" cy="12" r="3"/><circle cx="18" cy="19" r="3"/><line x1="8.59" y1="13.51" x2="15.42" y2="17.49"/><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"/></svg>
            <span>Share Account</span>
          </li>
          <li class="action-item" @click="goToEditNickname">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            <span>Edit Account Nickname</span>
          </li>
          <li class="action-item" @click="closeActionSheet">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            <span>Change Account Password</span>
          </li>
          <li class="action-item" @click="closeActionSheet">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="12" y1="18" x2="12" y2="12"/><polyline points="9 15 12 18 15 15"/></svg>
            <span>Download Account Statement</span>
          </li>
        </ul>
        <div style="padding: 16px;">
          <BizButton variant="primary" block @click="closeActionSheet">Close</BizButton>
        </div>
      </BizBottomSheet>
      
      <div style="height: 100px;"></div> <!-- Spacer for bottom nav -->
    </div>
      
    <!-- Bottom Navigation -->
    <BizBottomNav 
      v-model="activeTab" 
      :items="[
        { label: 'Home', value: 'home', icon: homeOutline, activeIcon: home },
        { label: 'History', value: 'history', icon: documentTextOutline, activeIcon: documentText },
        { label: 'Messages', value: 'messages', icon: chatbubbleOutline, activeIcon: chatbubble },
        { label: 'Profile', value: 'profile', icon: personOutline, activeIcon: person }
      ]"
    />

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { 
  BizUserProfile, BizIconButton, BizCompanySelector, BizActionCard, 
  BizSegment, BizSegmentButton, BizAccountListCard, BizBottomNav,
  BizSelect, BizBottomSheet, BizButton
} from '@bizmob-core/ui-framework';
import { homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble } from 'ionicons/icons';

const router = useRouter();

const userName = ref('SOM MONYROTTANA');
const userRole = ref('Master User');
const isVerified = ref(true);
const companyName = ref('CHOKCHEY FINANCE PLC,');
const companyType = ref('Individual');

const accountTab = ref('deposits');
const accountFilter = ref('All Accounts');
const currencyFilter = ref('All');

const hideDeposit1 = ref(false);
const hideDeposit2 = ref(false);
const hideDeposit3 = ref(false);

const activeTab = ref('home');

const showActionSheet = ref(false);

const openActionSheet = () => {
  showActionSheet.value = true;
};

const closeActionSheet = () => {
  showActionSheet.value = false;
};

const goToEditNickname = () => {
  showActionSheet.value = false;
  router.push('/edit-account-nickname');
};
</script>

<style scoped>
.biz-screen {
  width: 100%;
  height: 100vh;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
  background-color: var(--biz-primary, #003399);
}

.top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 60px 20px 20px;
}

.top-actions {
  display: flex;
  gap: 12px;
}

.main-card {
  background: var(--biz-background, #f4f6fa);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 24px 20px;
  min-height: calc(100vh - 120px);
}

.section-container {
  margin-bottom: 32px;
}

.section-label {
  font-size: 13px;
  color: #888;
  font-weight: 500;
}

.section-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 16px 0;
}

.section-header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.section-header-row .section-title { margin: 0; }

.see-all-link {
  font-size: 13px;
  color: #888;
  text-decoration: none;
}

.action-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.account-segment {
  margin-bottom: 16px;
  --biz-segment-bg: white;
  --biz-segment-border-color: #e9ecef;
  --biz-segment-btn-active-bg: var(--biz-primary-variant, #1a2a5e);
  border-radius: 30px;
  border: 1px solid #e9ecef;
}

.accounts-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.dev-back-btn {
  position: absolute;
  top: 16px;
  left: 16px;
  z-index: 100;
  background: rgba(255,255,255,0.2);
  border: none;
  color: white;
  padding: 8px 12px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  backdrop-filter: blur(4px);
}
.dev-back-btn svg {
  width: 16px;
  height: 16px;
}

.account-filters {
  display: flex;
  gap: 16px;
  margin-bottom: 16px;
}

.filter-col {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.filter-col label {
  font-size: 12px;
  color: #777;
  padding-left: 4px;
}

.action-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
  color: var(--biz-primary-variant, #1a2a5e);
  font-weight: 600;
  font-size: 15px;
}

.action-item:last-child {
  border-bottom: none;
}
</style>
