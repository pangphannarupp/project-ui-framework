<template>
  <div class="browse-plans-view">
    <!-- <PPAppBar title="Smart Service" style="--pp-app-bar-bg: var(--smart-green); --pp-app-bar-color: white;">
      <template #left>
        <button class="icon-btn" @click="$router.back()">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
          </svg>
        </button>
      </template>
      <template #right>
        <div style="display:flex; gap:0.5rem">
          <button class="icon-btn">
            <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="12" y1="16" x2="12" y2="12"></line>
              <line x1="12" y1="8" x2="12.01" y2="8"></line>
            </svg>
          </button>
          <button class="icon-btn">
            <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </template>
    </PPAppBar> -->
    
    <div class="content-area">
      <div class="top-segment">
        <PPSegment v-model="planType" variant="pill" style="--pp-segment-bg: white; --pp-segment-btn-active-bg: #e6f4f1; --pp-segment-btn-active-color: var(--smart-green);">
          <PPSegmentButton value="Monthly">Monthly</PPSegmentButton>
          <PPSegmentButton value="Weekly">Weekly</PPSegmentButton>
        </PPSegment>
      </div>

      <div class="plans-list">
        <h3 class="list-title">Browse plans</h3>
        
        <template v-if="planType === 'Monthly'">
          <PlanCard 
            name="Smart 5G Data 6"
            price="6 USD"
            data="90GB"
            mins="300 mins"
            sms="300 SMS"
            validity="30 Days"
            benefits="Secure Browsing"
            logoType="5G"
          />
          <PlanCard 
            name="Smart 5G Data 10"
            price="10 USD"
            data="150GB"
            mins="500 mins"
            sms="500 SMS"
            validity="30 Days"
            benefits="Secure Browsing"
            logoType="5G"
          />
          <PlanCard 
            name="Smart 5G Data 15"
            price="15 USD"
            data="250GB"
            mins="750 mins"
            sms="750 SMS"
            validity="30 Days"
            benefits="Secure Browsing"
            logoType="5G"
          />
        </template>
        
        <template v-else>
          <PlanCard 
            name="Smart 5G Data 1.5"
            price="1.5 USD"
            data="20GB"
            mins="100 mins"
            sms="100 SMS"
            validity="7 Days"
            benefits="Secure Browsing"
            logoType="5G"
          />
          <PlanCard 
            name="Smart 5G Data 2"
            price="2 USD"
            data="30GB"
            mins="100 mins"
            sms="100 SMS"
            validity="7 Days"
            benefits="Secure Browsing"
            logoType="5G"
            recommended
          />
          <PlanCard 
            name="Smart Laor! 1.5"
            price="1.5 USD"
            data="10GB"
            mins="1000 mins"
            sms="1000 SMS"
            validity="7 Days"
            logoType="Laor"
          />
          <PlanCard 
            name="Smart Laor! Data 1.5"
            price="1.5 USD"
            data="10GB"
            mins="1000 mins"
            sms="1000 SMS"
            validity="7 Days"
            logoType="Laor"
          />
        </template>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPSegment, PPSegmentButton } from '@phanna/ui-framework';
import PlanCard from './components/PlanCard.vue';

const planType = ref('Monthly');
</script>

<style scoped>
.browse-plans-view {
  background-color: #f7f9fa;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.icon-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.content-area {
  padding: 1rem;
  flex: 1;
}

.top-segment {
  margin-bottom: 1.5rem;
}

.list-title {
  margin: 0 0 1rem 0;
  font-size: 1.1rem;
  color: var(--text-main);
}
</style>
