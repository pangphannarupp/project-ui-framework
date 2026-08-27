<template>
  <div class="section">
    <h3 class="section-title">Available Add-ons</h3>
    <div class="horizontal-scroll">
      <div class="add-on-card" @click="$emit('purchase', { name: 'Data Pack 1', price: 1.00 })">
        <div class="add-on-name">Data Pack 1</div>
        <div class="add-on-price"><span class="price-green">1$</span> / 7 Days</div>
      </div>
      <div class="add-on-card" @click="$emit('purchase', { name: 'Data Pack 1.5', price: 1.50 })">
        <div class="add-on-name">Data Pack 1.5</div>
        <div class="add-on-price"><span class="price-green">1.5$</span> / 7 Days</div>
      </div>
      <div class="add-on-card" @click="$emit('purchase', { name: 'Data Pack 6', price: 6.00 })">
        <div class="add-on-name">Data Pack 6</div>
        <div class="add-on-price"><span class="price-green">6$</span> / 30 Days</div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineEmits<{
  (e: 'purchase', pack: { name: string, price: number }): void;
}>();
</script>

<style scoped>
.section {
  margin-top: 1rem;
}

.section-title {
  margin: 0;
  font-size: 1rem;
  color: var(--text-main);
  margin-bottom: 1rem;
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

.add-on-card {
  background: white;
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 1rem;
  min-width: 120px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  cursor: pointer;
}

.add-on-name {
  font-weight: 600;
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
}

.add-on-price {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.price-green {
  color: var(--smart-green);
  font-weight: bold;
  font-size: 1rem;
}
</style>
