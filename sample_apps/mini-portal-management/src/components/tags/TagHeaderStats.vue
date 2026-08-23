<script setup lang="ts">
defineProps<{
  totalTags: number
  featuredCount: number
}>()
</script>

<template>
  <div class="header-card glass-panel">
    <div class="header-left">
      <div class="header-badge">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:4px;"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
        <span>Taxonomy & Discovery</span>
      </div>
      <h2>App Discoverability Tags</h2>
      <p>Configure search keywords, promotional highlight badges, and indexing tags linked across mini application instances.</p>
    </div>
    <div class="header-stats">
      <div class="stat-pill">
        <div class="stat-icon-wrapper cyan">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
        </div>
        <div>
          <strong>{{ totalTags }}</strong>
          <small>Total Tags</small>
        </div>
      </div>
      <div class="stat-pill">
        <div class="stat-icon-wrapper amber">
          <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
        </div>
        <div>
          <strong>{{ featuredCount }}</strong>
          <small>Featured in Search</small>
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
  max-width: 560px;
}

.header-badge {
  display: inline-flex;
  align-items: center;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  color: #38bdf8;
  background: rgba(56, 189, 248, 0.12);
  border: 1px solid rgba(56, 189, 248, 0.3);
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

.stat-icon-wrapper.cyan {
  background: rgba(6, 182, 212, 0.15);
  color: #06b6d4;
}

.stat-icon-wrapper.amber {
  background: rgba(245, 158, 11, 0.15);
  color: #f59e0b;
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
