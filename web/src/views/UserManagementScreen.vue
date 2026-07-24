<template>
  <ion-page>
    <div class="pp-screen user-management-screen">
      
      <!-- Top header area -->
      <div class="um-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>
        <div class="header-content">
          <div class="text-content">
            <h1 class="header-title">User Management</h1>
            <p class="header-subtitle">View and manage user status</p>
          </div>
          <div class="header-graphic">
            <svg viewBox="0 0 48 48" width="48" height="48" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M24 24C28.4183 24 32 20.4183 32 16C32 11.5817 28.4183 8 24 8C19.5817 8 16 11.5817 16 16C16 20.4183 19.5817 24 24 24Z" fill="#8cb4f1"/>
              <path d="M40 40H8C8 31.1634 15.1634 24 24 24C28.0121 24 31.6789 25.4776 34.4716 27.9392C37.8925 30.9546 40 35.2443 40 40Z" fill="#8cb4f1"/>
              <path d="M40 32C40 36.4183 36.4183 40 32 40C27.5817 40 24 36.4183 24 32C24 27.5817 27.5817 24 32 24C36.4183 24 40 27.5817 40 32Z" fill="#c3d5f4"/>
              <circle cx="32" cy="32" r="8" fill="#eef5ff" />
              <path d="M36.5 32c0-.28-.02-.56-.05-.83l1.83-1.43c.16-.13.21-.36.1-.55l-1.73-3c-.11-.19-.34-.26-.54-.18l-2.15.87c-.45-.34-.94-.63-1.47-.85l-.32-2.3c-.03-.22-.22-.38-.45-.38h-3.46c-.22 0-.42.16-.45.38l-.32 2.3c-.53.22-1.02.51-1.47.85l-2.15-.87c-.2-.08-.43-.01-.54.18l-1.73 3c-.11.19-.06.42.1.55l1.83 1.43c-.03.27-.05.55-.05.83s.02.56.05.83l-1.83 1.43c-.16.13-.21.36-.1.55l1.73 3c.11.19.34.26.54.18l2.15-.87c.45.34.94.63 1.47.85l.32 2.3c.03.22.22.38.45.38h3.46c.22 0 .42-.16.45-.38l.32-2.3c.53-.22 1.02-.51 1.47-.85l2.15.87c.2.08.43.01.54-.18l1.73-3c.11-.19.06-.42-.1-.55l-1.83-1.43c.03-.27.05-.55.05-.83zM32 35c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3z" fill="#7a97ce"/>
            </svg>
          </div>
        </div>
      </div>

      <!-- Main card area -->
      <div class="um-card">
        
        <!-- Info Banner -->
        <div class="web-access-banner">
          <div class="banner-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
              <line x1="8" y1="21" x2="16" y2="21"></line>
              <line x1="12" y1="17" x2="12" y2="21"></line>
            </svg>
          </div>
          <div class="banner-text">
            <h4>Manage Access on Web</h4>
            <p>Creating new users or managing access permission is only available on web only.</p>
          </div>
        </div>

        <!-- Company Selector -->
        <div class="section-container">
          <div class="section-label">Now Managing</div>
          <PPCompanySelector 
            companyName="TWILIGHT FINANCE CO., LTD"
            companyType="Corporate"
          >
            <template #logo>
              <div class="custom-logo">W</div>
            </template>
          </PPCompanySelector>
        </div>

        <!-- Segment Tabs -->
        <PPScrollSegment class="filter-segment">
          <PPScrollSegmentButton :isActive="true">All</PPScrollSegmentButton>
          
          <PPScrollSegmentButton>
            <template #icon>
              <svg viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                <path d="M9 12l2 2 4-4" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"></path>
              </svg>
            </template>
            Master User
          </PPScrollSegmentButton>
          
          <PPScrollSegmentButton>
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect>
                <line x1="12" y1="18" x2="12.01" y2="18"></line>
              </svg>
            </template>
            fast payments
          </PPScrollSegmentButton>
          
          <PPScrollSegmentButton>
            <template #icon>
              <svg viewBox="0 0 24 24" fill="currentColor" color="#7a52cc">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                <path d="M9 12l2 2 4-4" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"></path>
              </svg>
            </template>
            Approver
          </PPScrollSegmentButton>
        </PPScrollSegment>

        <!-- Search Input -->
        <div class="search-container">
          <div class="custom-search">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="search-icon">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
            <input type="text" placeholder="Search" />
          </div>
        </div>

        <!-- Users List -->
        <div class="users-list">
          <PPUserCard 
            name="SOM MONYROTTANA"
            phone="+855 13 456 789"
            status="Active"
            :isMaster="true"
            
            
          />
          
          <PPUserCard 
            name="SOPHEA BORAMEY"
            phone="+855 13 456 789"
            status="Inactive"
            
          />
          
          <PPUserCard 
            name="CHAN TY"
            phone="+855 12 345 789"
            status="Pending"
            
          />
          
          <PPUserCard 
            name="PAK PUTHEK"
            phone="+855 12 345 789"
            status="Active"
            
          />
          
          <PPUserCard 
            name="CHY LEANGCHHAY"
            phone="+855 12 345 789"
            status="Locked"
            
          />
          
          <PPUserCard 
            name="OR SOVANNARY"
            phone="+855 12 345 789"
            status="Active"
            
          />
        </div>

      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { 
  PPCompanySelector, 
  PPScrollSegment, 
  PPScrollSegmentButton, 
  PPInput, 
  PPUserCard 
} from '@phanna/ui-framework';

const router = useRouter();
</script>

<style scoped>
.user-management-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--pp-primary-color, var(--pp-primary, #003399));
}

/* Header */
.um-header {
  padding: 56px 24px 24px 24px;
  color: white;
}

.back-btn {
  background: transparent;
  border: none;
  color: white;
  padding: 0;
  margin-bottom: 24px;
  cursor: pointer;
}

.back-btn svg {
  width: 24px;
  height: 24px;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.header-title {
  font-size: 24px;
  font-weight: 700;
  margin: 0 0 8px 0;
}

.header-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.header-graphic {
  font-size: 40px;
  line-height: 1;
}

/* Main Card */
.um-card {
  flex: 1;
  background-color: #f7f9fc;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.web-access-banner {
  display: flex;
  gap: 16px;
  background-color: #f0f5ff;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 24px;
}

.banner-icon {
  color: #3b63cc;
  flex-shrink: 0;
}

.banner-icon svg {
  width: 24px;
  height: 24px;
}

.banner-text h4 {
  font-size: 14px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 4px 0;
}

.banner-text p {
  font-size: 13px;
  color: #666;
  margin: 0;
  line-height: 1.4;
}

.section-label {
  font-size: 13px;
  color: #888;
  margin-bottom: 8px;
}

.section-container {
  margin-bottom: 16px;
}

/* .filter-segment {
  background-color: #eef1f6; 
  border-radius: 18px;
  margin-bottom: 16px;
  padding: 0px;
} */

.filter-segment {
  --pp-scroll-segment-btn-border-color:transparent;
  --pp-scroll-segment-btn-active-border-color:transparent;
  --pp-scroll-segment-btn-shadow:0px;
}

.search-container {
  margin-bottom: 16px;
}

.custom-search {
  display: flex;
  align-items: center;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 10px 16px;
  gap: 12px;
}

.custom-search input {
  border: none;
  background: transparent;
  outline: none;
  flex: 1;
  font-size: 15px;
  color: #333;
}

.custom-search input::placeholder {
  color: #999;
}

.search-icon {
  width: 20px;
  height: 20px;
  color: #888;
}

.custom-logo {
  width: 40px;
  height: 40px;
  background-color: #3b63cc;
  color: white;
  font-weight: 700;
  font-size: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.users-list {
  display: flex;
  flex-direction: column;
}
</style>
