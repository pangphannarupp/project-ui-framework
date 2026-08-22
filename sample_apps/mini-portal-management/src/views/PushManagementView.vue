<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockPushCampaigns, type PushCampaign } from '../data/mockData'

const campaigns = ref<PushCampaign[]>([...mockPushCampaigns])

const newPush = ref({
  title: '',
  message: '',
  targetApp: 'Coffee Pickup',
  targetAudience: 'All Users',
  scheduledAt: ''
})

const appsList = [
  'All Apps (Broadcast)',
  'Coffee Pickup',
  'Smart Mini App Hub',
  'Cinema Ticket Booking',
  'EV Charge Station',
  'Mini POS Merchant'
]

const audiences = [
  'All Active Users',
  'Tier >= Gold Members',
  'Users inactive for 14 days',
  'Cart Abandoners in last 24h'
]

const isSending = ref(false)

const handleSendPush = () => {
  if (!newPush.value.title || !newPush.value.message) return

  isSending.value = true
  setTimeout(() => {
    campaigns.value.unshift({
      id: `push-${Date.now()}`,
      title: newPush.value.title,
      message: newPush.value.message,
      targetApp: newPush.value.targetApp,
      targetAudience: newPush.value.targetAudience,
      sentAt: 'Just now',
      sentCount: 12500,
      openRate: '0.0%',
      status: 'Sent'
    })
    isSending.value = false
    newPush.value = {
      title: '',
      message: '',
      targetApp: 'Coffee Pickup',
      targetAudience: 'All Users',
      scheduledAt: ''
    }
  }, 800)
}
</script>

<template>
  <AdminLayout>
    <div class="push-view">
      <div class="push-grid">
        <!-- Composer Form -->
        <div class="card glass-panel composer-card">
          <div class="card-header">
            <h3>⚡ Compose Push Notification</h3>
            <small>Dispatch notifications via Firebase Cloud Messaging & Apple APNs</small>
          </div>

          <form @submit.prevent="handleSendPush" class="push-form">
            <div class="form-group">
              <label>Target Mini Application</label>
              <select v-model="newPush.targetApp">
                <option v-for="a in appsList" :key="a" :value="a">{{ a }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Audience Segment</label>
              <select v-model="newPush.targetAudience">
                <option v-for="aud in audiences" :key="aud" :value="aud">{{ aud }}</option>
              </select>
            </div>

            <div class="form-group">
              <label>Notification Title</label>
              <input type="text" v-model="newPush.title" placeholder="e.g. ⚡ Flash Deal for Lunch" required />
            </div>

            <div class="form-group">
              <label>Notification Body / Message</label>
              <textarea v-model="newPush.message" rows="3" placeholder="Enter message text..." required></textarea>
            </div>

            <!-- Preview Box -->
            <div class="preview-box">
              <span class="preview-label">Mobile Lockscreen Preview:</span>
              <div class="mobile-notification">
                <div class="notif-header">
                  <span>⚡ Mini Portal • {{ newPush.targetApp || 'Mini App' }}</span>
                  <small>now</small>
                </div>
                <strong>{{ newPush.title || 'Notification Headline' }}</strong>
                <p>{{ newPush.message || 'Notification preview text will appear right here.' }}</p>
              </div>
            </div>

            <button type="submit" class="btn btn-primary send-btn" :disabled="isSending">
              <span v-if="isSending">Dispatching via Edge Push Nodes...</span>
              <span v-else>🚀 Broadcast Notification Now</span>
            </button>
          </form>
        </div>

        <!-- History & Metrics -->
        <div class="card glass-panel history-card">
          <div class="card-header">
            <h3>Push Campaign History</h3>
            <small>Delivery telemetry and engagement tracking</small>
          </div>

          <div class="campaign-list">
            <div v-for="c in campaigns" :key="c.id" class="campaign-item">
              <div class="campaign-top">
                <strong>{{ c.title }}</strong>
                <span class="status-pill" :class="c.status.toLowerCase()">{{ c.status }}</span>
              </div>
              <p class="campaign-msg">{{ c.message }}</p>
              <div class="campaign-meta">
                <span>🎯 {{ c.targetApp }}</span>
                <span>👥 {{ (c.sentCount).toLocaleString() }} sent</span>
                <span>📈 {{ c.openRate }} Open Rate</span>
                <span class="text-muted">🕒 {{ c.sentAt }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.push-view {
  display: flex;
  flex-direction: column;
}

.push-grid {
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 24px;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
}

.card-header h3 {
  font-size: 16px;
  color: #fff;
  margin-bottom: 4px;
}

.card-header small {
  color: #94a3b8;
  font-size: 12px;
}

.push-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 13px;
  color: #cbd5e1;
  font-weight: 500;
}

.form-group input,
.form-group select,
.form-group textarea {
  background: #0f172a;
  border: 1px solid #374151;
  padding: 10px 12px;
  border-radius: 8px;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.preview-box {
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 14px;
  border-radius: 10px;
}

.preview-label {
  display: block;
  font-size: 11px;
  color: #64748b;
  margin-bottom: 8px;
  text-transform: uppercase;
}

.mobile-notification {
  background: #1e293b;
  border: 1px solid #334155;
  border-radius: 10px;
  padding: 12px;
}

.notif-header {
  display: flex;
  justify-content: space-between;
  font-size: 11px;
  color: #94a3b8;
  margin-bottom: 4px;
}

.mobile-notification strong {
  display: block;
  font-size: 13px;
  color: #fff;
  margin-bottom: 2px;
}

.mobile-notification p {
  font-size: 12px;
  color: #cbd5e1;
  line-height: 1.4;
}

.send-btn {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  border: none;
  padding: 12px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  margin-top: 8px;
}

.campaign-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
  margin-top: 16px;
}

.campaign-item {
  background: #0f172a;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
}

.campaign-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.campaign-top strong {
  font-size: 14px;
  color: #fff;
}

.campaign-msg {
  font-size: 13px;
  color: #cbd5e1;
  margin-bottom: 12px;
}

.campaign-meta {
  display: flex;
  gap: 14px;
  font-size: 12px;
  color: #94a3b8;
  flex-wrap: wrap;
}

.status-pill {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 12px;
  font-weight: 600;
}
.status-pill.sent { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.status-pill.scheduled { background: rgba(59, 130, 246, 0.15); color: #60a5fa; }

@media (max-width: 1000px) {
  .push-grid { grid-template-columns: 1fr; }
}
</style>
