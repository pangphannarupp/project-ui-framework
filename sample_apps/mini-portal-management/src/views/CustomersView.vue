<script setup lang="ts">
import { ref, computed } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockCustomers, type Customer } from '../data/mockData'

const customers = ref<Customer[]>([...mockCustomers])
const searchQuery = ref('')
const selectedTier = ref('All')

const tiers = ['All', 'Platinum', 'Gold', 'Silver', 'Standard']

const filteredCustomers = computed(() => {
  return customers.value.filter(c => {
    const matchTier = selectedTier.value === 'All' || c.tier === selectedTier.value
    const matchSearch = c.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        c.phone.includes(searchQuery.value) ||
                        c.email.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchTier && matchSearch
  })
})

const getKycBadge = (status: string) => {
  if (status === 'Verified') return 'badge-verified'
  if (status === 'Pending') return 'badge-pending'
  return 'badge-rejected'
}
</script>

<template>
  <AdminLayout>
    <div class="customers-view">
      <div class="header-card glass-panel">
        <div>
          <h2>End-User Customers & Mini App Consumers</h2>
          <p>Inspect customer KYC tiering, spending volume, and linked mini app authorization states.</p>
        </div>
        <div class="header-controls">
          <div class="tier-pills">
            <button
              v-for="t in tiers"
              :key="t"
              class="tier-btn"
              :class="{ 'active': selectedTier === t }"
              @click="selectedTier = t"
            >
              {{ t }}
            </button>
          </div>
          <div class="search-box">
            <span>🔍</span>
            <input type="text" v-model="searchQuery" placeholder="Search phone, name..." />
          </div>
        </div>
      </div>

      <div class="card glass-panel">
        <div class="table-container">
          <table class="portal-table">
            <thead>
              <tr>
                <th>CUSTOMER</th>
                <th>PHONE NUMBER</th>
                <th>KYC STATUS</th>
                <th>MEMBERSHIP TIER</th>
                <th>TOTAL SPENT</th>
                <th>LINKED MINI APPS</th>
                <th>JOINED</th>
                <th>ACTION</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="c in filteredCustomers" :key="c.id">
                <td>
                  <strong>{{ c.name }}</strong>
                  <small class="block text-muted">{{ c.email }}</small>
                </td>
                <td class="font-mono">{{ c.phone }}</td>
                <td>
                  <span class="kyc-badge" :class="getKycBadge(c.kycStatus)">
                    {{ c.kycStatus }}
                  </span>
                </td>
                <td>
                  <span class="tier-pill" :class="c.tier.toLowerCase()">{{ c.tier }}</span>
                </td>
                <td class="font-medium text-green">{{ c.totalSpent }}</td>
                <td><strong>{{ c.usedAppsCount }}</strong> apps</td>
                <td class="font-mono text-muted">{{ c.joinedDate }}</td>
                <td>
                  <button class="small-btn">View Profile</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.customers-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.header-card {
  padding: 24px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-card h2 {
  font-size: 20px;
  color: #fff;
  margin-bottom: 4px;
}

.header-card p {
  color: #94a3b8;
  font-size: 13px;
}

.header-controls {
  display: flex;
  gap: 12px;
  align-items: center;
}

.tier-pills {
  display: flex;
  gap: 6px;
}

.tier-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #9ca3af;
  padding: 6px 12px;
  border-radius: 16px;
  font-size: 12px;
  cursor: pointer;
}

.tier-btn.active {
  background: #3b82f6;
  color: #fff;
  border-color: #3b82f6;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #0f172a;
  border: 1px solid #374151;
  padding: 8px 12px;
  border-radius: 8px;
}

.search-box input {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 20px;
}

.table-container {
  overflow-x: auto;
}

.portal-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.portal-table th {
  font-size: 11px;
  color: #64748b;
  padding: 12px;
  border-bottom: 1px solid #1f2937;
}

.portal-table td {
  padding: 14px 12px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #e2e8f0;
}

.block { display: block; }
.text-muted { color: #64748b; }
.text-green { color: #10b981; }

.kyc-badge {
  font-size: 11px;
  padding: 3px 8px;
  border-radius: 6px;
  font-weight: 600;
}
.badge-verified { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.badge-pending { background: rgba(245, 158, 11, 0.15); color: #f59e0b; }
.badge-rejected { background: rgba(239, 68, 68, 0.15); color: #ef4444; }

.tier-pill {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 12px;
  font-weight: 600;
}
.tier-pill.platinum { background: rgba(168, 85, 247, 0.2); color: #c084fc; }
.tier-pill.gold { background: rgba(234, 179, 8, 0.2); color: #facc15; }
.tier-pill.silver { background: rgba(148, 163, 184, 0.2); color: #cbd5e1; }
.tier-pill.standard { background: rgba(100, 116, 139, 0.2); color: #94a3b8; }

.small-btn {
  padding: 5px 12px;
  font-size: 12px;
  background: #1f2937;
  border: 1px solid #374151;
  color: #cbd5e1;
  border-radius: 6px;
  cursor: pointer;
}
</style>
