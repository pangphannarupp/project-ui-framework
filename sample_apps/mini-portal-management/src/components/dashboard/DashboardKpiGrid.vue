<script setup lang="ts">
defineProps<{
  kpis: {
    title: string
    value: string
    change: string
    icon: string
    positive: boolean
  }[]
}>()
</script>

<template>
  <div class="kpi-grid">
    <div v-for="kpi in kpis" :key="kpi.title" class="kpi-card glass-panel">
      <div class="kpi-header">
        <div class="kpi-icon-svg">
          <svg v-if="kpi.icon === 'apps'" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#60a5fa" stroke-width="2"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
          <svg v-else-if="kpi.icon === 'users'" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#34d399" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
          <svg v-else-if="kpi.icon === 'card'" viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#f472b6" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
          <svg v-else viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#fbbf24" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
        </div>
        <PPChip
          :label="kpi.change"
          :color="kpi.positive ? 'success' : 'danger'"
          variant="soft"
          size="sm"
        />
      </div>
      <div class="kpi-body">
        <h3>{{ kpi.value }}</h3>
        <p>{{ kpi.title }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px;
}

.kpi-card {
  padding: 20px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.kpi-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.kpi-icon-svg {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  background: #1e293b;
  border: 1px solid #374151;
  display: flex;
  align-items: center;
  justify-content: center;
}

.kpi-body h3 {
  font-size: 24px;
  font-weight: 700;
  color: #fff;
}

.kpi-body p {
  font-size: 13px;
  color: #94a3b8;
  margin-top: 4px;
}
</style>
