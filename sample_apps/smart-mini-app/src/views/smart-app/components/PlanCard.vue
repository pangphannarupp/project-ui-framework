<template>
  <div class="plan-card">
    <div class="card-tag" v-if="recommended">Recommended</div>
    
    <div class="card-header">
      <div class="logo">
        <span v-if="logoType === '5G'">Smart<br>5G Data</span>
        <span v-else-if="logoType === 'Laor'">SMART<br><span style="color:#E91E63">LAOR!</span></span>
      </div>
      <div class="plan-name">{{ name }}</div>
      <div class="plan-price">{{ price }}</div>
    </div>
    
    <div class="plan-data">
      <div class="label">Internet Data <span class="icon">⇌</span></div>
      <div class="data-value">{{ data }}</div>
    </div>
    
    <div class="plan-features">
      <div class="feature">
        <div class="f-val">{{ mins }}</div>
        <div class="f-lbl">On-net Calls</div>
      </div>
      <div class="feature">
        <div class="f-val">{{ sms }}</div>
        <div class="f-lbl">On-net SMS</div>
      </div>
      <div class="feature">
        <div class="f-val">{{ validity }}</div>
        <div class="f-lbl">Auto Renewal</div>
      </div>
    </div>
    
    <div class="plan-benefits" v-if="benefits">
      <div class="b-lbl">Another Benefit</div>
      <div class="b-val"><span class="icon">🛡️</span> {{ benefits }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  name: string;
  price: string;
  data: string;
  mins: string;
  sms: string;
  validity: string;
  logoType?: '5G' | 'Laor';
  recommended?: boolean;
  benefits?: string;
}>();
</script>

<style scoped>
.plan-card {
  background: white;
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 1rem;
  margin-bottom: 1rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  position: relative;
}

.card-tag {
  position: absolute;
  top: -10px;
  left: 12px;
  background-color: #007766;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: bold;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.logo {
  font-size: 0.6rem;
  font-weight: bold;
  background-color: var(--smart-green);
  color: white;
  border-radius: 4px;
  padding: 4px;
  text-align: center;
  line-height: 1.1;
  width: 42px;
}

.plan-name {
  font-weight: bold;
  font-size: 1.1rem;
  flex: 1;
}

.plan-price {
  font-weight: bold;
  color: var(--text-main);
  font-size: 0.95rem;
}

.label {
  color: var(--text-secondary);
  font-size: 0.85rem;
  margin-bottom: 0.25rem;
}

.data-value {
  font-weight: bold;
  font-size: 1.5rem;
  color: var(--smart-green);
  margin-bottom: 1rem;
}

.plan-features {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 1rem;
}

.f-val {
  font-weight: bold;
  font-size: 0.85rem;
}

.f-lbl {
  color: var(--text-secondary);
  font-size: 0.75rem;
}

.plan-benefits {
  border-top: 1px solid #eee;
  padding-top: 0.75rem;
}

.b-lbl {
  color: var(--smart-green);
  font-weight: bold;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}

.b-val {
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
</style>
