<script setup lang="ts">
import { ref, computed } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockUsers, type PortalUser } from '../data/mockData'

const users = ref<PortalUser[]>([...mockUsers])
const searchQuery = ref('')
const selectedRole = ref('All')

const roles = ['All', 'Super Admin', 'Operator', 'Developer', 'Auditor']

const filteredUsers = computed(() => {
  return users.value.filter(u => {
    const matchRole = selectedRole.value === 'All' || u.role === selectedRole.value
    const matchSearch = u.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        u.email.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchRole && matchSearch
  })
})

const toggleUserStatus = (user: PortalUser) => {
  user.status = user.status === 'active' ? 'suspended' : 'active'
}
</script>

<template>
  <AdminLayout>
    <div class="users-view">
      <div class="header-card glass-panel">
        <div class="header-text">
          <h2>Portal Administrator & Operator Accounts</h2>
          <p>Configure role-based permissions, API scopes, and administrative session policies.</p>
        </div>
        <div class="header-actions">
          <div class="search-box">
            <span>🔍</span>
            <input type="text" v-model="searchQuery" placeholder="Search team members..." />
          </div>
          <button class="btn btn-primary">+ Invite Team Member</button>
        </div>
      </div>

      <div class="card glass-panel">
        <div class="table-container">
          <table class="portal-table">
            <thead>
              <tr>
                <th>USER</th>
                <th>ROLE</th>
                <th>STATUS</th>
                <th>MANAGED APPS</th>
                <th>LAST LOGIN</th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="u in filteredUsers" :key="u.id">
                <td>
                  <div class="user-cell">
                    <img :src="u.avatar" class="avatar-cell" />
                    <div>
                      <strong>{{ u.name }}</strong>
                      <small class="text-muted">{{ u.email }}</small>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="role-badge" :class="u.role.toLowerCase().replace(' ', '-')">
                    {{ u.role }}
                  </span>
                </td>
                <td>
                  <span class="status-pill" :class="u.status">{{ u.status }}</span>
                </td>
                <td><strong>{{ u.assignedApps }}</strong> mini apps</td>
                <td class="font-mono text-muted">{{ u.lastLogin }}</td>
                <td>
                  <div class="actions">
                    <button @click="toggleUserStatus(u)" class="small-btn" :class="{ 'danger': u.status === 'active' }">
                      {{ u.status === 'active' ? 'Suspend' : 'Activate' }}
                    </button>
                    <button class="small-btn">Edit Roles</button>
                  </div>
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
.users-view {
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

.header-text h2 {
  font-size: 20px;
  color: #fff;
  margin-bottom: 4px;
}

.header-text p {
  color: #94a3b8;
  font-size: 13px;
}

.header-actions {
  display: flex;
  gap: 12px;
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

.btn-primary {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
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

.user-cell {
  display: flex;
  align-items: center;
  gap: 12px;
}

.avatar-cell {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  object-fit: cover;
}

.user-cell strong {
  display: block;
  font-size: 14px;
}

.role-badge {
  font-size: 11px;
  padding: 3px 10px;
  border-radius: 20px;
  font-weight: 600;
  background: #1f2937;
  color: #cbd5e1;
}

.role-badge.super-admin {
  background: rgba(99, 102, 241, 0.2);
  color: #a5b4fc;
  border: 1px solid rgba(99, 102, 241, 0.3);
}

.status-pill {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 12px;
  text-transform: capitalize;
}

.status-pill.active { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.status-pill.suspended { background: rgba(239, 68, 68, 0.15); color: #ef4444; }

.actions {
  display: flex;
  gap: 8px;
}

.small-btn {
  padding: 5px 10px;
  font-size: 12px;
  background: #1f2937;
  border: 1px solid #374151;
  color: #cbd5e1;
  border-radius: 6px;
  cursor: pointer;
}

.small-btn.danger {
  color: #f87171;
  border-color: rgba(239, 68, 68, 0.4);
}
</style>
