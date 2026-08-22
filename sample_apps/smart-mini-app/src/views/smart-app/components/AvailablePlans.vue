<template>
  <div class="section">
    <div class="section-header">
      <h3 class="section-title">Available plans</h3>
      <router-link to="/smart/browse-plans" class="browse-link">Browse all →</router-link>
    </div>
    
    <div class="horizontal-scroll">
      <div class="plan-card">
        <div class="plan-name">Smart 5G Data 6</div>
        <div class="plan-price"><span class="price-green">6 USD</span> / Monthly</div>
      </div>
      <div class="plan-card">
        <div class="plan-name">Smart 5G Data 10</div>
        <div class="plan-price"><span class="price-green">10 USD</span> / Monthly</div>
      </div>
      <div class="plan-card">
        <div class="plan-name">Smart 5G Data 15</div>
        <div class="plan-price"><span class="price-green">15 USD</span> / Monthly</div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Stateless component for displaying a scrollable list of available plans
</script>

<style scoped>
.section {
  margin-top: 1rem;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.section-title {
  margin: 0;
  font-size: 1rem;
  color: var(--text-main);
  margin-bottom: 0; /* overridden from header layout */
}

.browse-link {
  color: var(--smart-green);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.9rem;
}

.horizontal-scroll {
  display: flex;
  gap: 1rem;
  overflow-x: auto;
  padding-bottom: 0.5rem;
  /* hide scrollbar */
  scrollbar-width: none;
  -ms-overflow-style: none;
}
.horizontal-scroll::-webkit-scrollbar {
  display: none;
}

.plan-card {
  background: white;
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 1rem;
  min-width: 140px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.plan-name {
  font-weight: 600;
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
}

.plan-price {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.price-green {
  color: var(--smart-green);
  font-weight: bold;
  font-size: 1rem;
}
</style>
