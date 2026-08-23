<script setup lang="ts">
defineProps<{
  totalCategories: number
  activeCount: number
  totalApps: number
}>()
</script>

<template>
  <div class="header-card glass-panel">
    <div class="header-left">
      <div class="header-badge">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:4px;"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
        <span>Taxonomy Management</span>
      </div>
      <h2>Mini App Categories</h2>
      <p>Register, categorize, and prioritize mini app classifications displayed across mobile client directories.</p>
    </div>
    <div class="header-stats">
      <div class="stat-pill">
        <div class="stat-icon-wrapper amber">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
        </div>
        <div>
          <strong>{{ totalCategories }}</strong>
          <small>Total Categories</small>
        </div>
      </div>
      <div class="stat-pill">
        <div class="stat-icon-wrapper emerald">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
        </div>
        <div>
          <strong>{{ activeCount }}</strong>
          <small>Active</small>
        </div>
      </div>
      <div class="stat-pill">
        <div class="stat-icon-wrapper blue">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
        </div>
        <div>
          <strong>{{ totalApps }}</strong>
          <small>Linked Apps</small>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.header-card {
  padding: 24px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.header-left h2 {
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  margin-top: 4px;
}

.header-left p {
  color: #94a3b8;
  font-size: 13px;
  margin-top: 4px;
  max-width: 540px;
}

.header-badge {
  display: inline-flex;
  align-items: center;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  color: #60a5fa;
  background: rgba(59, 130, 246, 0.12);
  border: 1px solid rgba(59, 130, 246, 0.3);
  padding: 3px 8px;
  border-radius: 6px;
  letter-spacing: 0.5px;
}

.header-stats {
  display: flex;
  gap: 12px;
}

.stat-pill {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 10px 16px;
  border-radius: 12px;
}

.stat-icon-wrapper {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-icon-wrapper.amber {
  background: rgba(245, 158, 11, 0.15);
  color: #f59e0b;
}

.stat-icon-wrapper.emerald {
  background: rgba(16, 185, 129, 0.15);
  color: #10b981;
}

.stat-icon-wrapper.blue {
  background: rgba(59, 130, 246, 0.15);
  color: #60a5fa;
}

.stat-pill strong {
  display: block;
  font-size: 16px;
  color: #fff;
}

.stat-pill small {
  font-size: 11px;
  color: #94a3b8;
}
</style>
