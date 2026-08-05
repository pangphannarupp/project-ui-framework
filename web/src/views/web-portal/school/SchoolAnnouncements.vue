<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Noticeboard</h1>
            <p class="page-subtitle">School announcements, events, and news.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="addOutline" />
            </template>
            Create Announcement
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search announcements..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="audienceFilter" 
              :options="audienceOptions"
              placeholder="All Audiences"
            />
          </div>
        </div>

        <!-- Announcements Feed -->
        <div class="announcements-feed">
          <div v-for="announcement in filteredAnnouncements" :key="announcement.id" class="announcement-card">
            
            <div class="announcement-header">
              <div class="author-info">
                <div class="author-avatar">{{ announcement.author.charAt(0) }}</div>
                <div>
                  <div class="author-name">{{ announcement.author }}</div>
                  <div class="announcement-meta">
                    <span>{{ announcement.date }}</span>
                    <span class="dot">•</span>
                    <span class="audience-badge" :class="announcement.audience.toLowerCase().replace(' ', '-')">
                      {{ announcement.audience }}
                    </span>
                  </div>
                </div>
              </div>
              <div class="announcement-actions">
                <button class="icon-btn"><ion-icon :icon="createOutline" /></button>
                <button class="icon-btn danger"><ion-icon :icon="trashOutline" /></button>
              </div>
            </div>

            <h2 class="announcement-title">{{ announcement.title }}</h2>
            <div class="announcement-content" v-html="announcement.content"></div>

            <div class="announcement-footer" v-if="announcement.attachments?.length">
              <div class="attachment-label">Attachments:</div>
              <div class="attachment-list">
                <div v-for="file in announcement.attachments" :key="file.name" class="attachment-chip">
                  <ion-icon :icon="documentOutline" />
                  {{ file.name }}
                </div>
              </div>
            </div>

          </div>

          <div v-if="filteredAnnouncements.length === 0" class="empty-state">
            <ion-icon :icon="megaphoneOutline" class="empty-icon" />
            <h3>No Announcements Found</h3>
            <p>Try adjusting your search or filters.</p>
          </div>
        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { 
  addOutline, 
  createOutline, 
  trashOutline,
  documentOutline,
  megaphoneOutline
} from 'ionicons/icons';
import { PPButton, PPSearch, PPSelect } from '@phanna/ui-framework';

// State
const searchQuery = ref('');
const audienceFilter = ref('');

// Options
const audienceOptions = [
  { label: 'All Audiences', value: '' },
  { label: 'All School', value: 'All School' },
  { label: 'Teachers Only', value: 'Teachers Only' },
  { label: 'Students Only', value: 'Students Only' },
];

// Mock Data
const announcements = ref([
  { 
    id: 1, 
    author: 'Principal Figgins', 
    date: 'Oct 15, 2023 at 09:00 AM', 
    audience: 'All School',
    title: 'Upcoming Science Fair Registration', 
    content: '<p>Dear Students and Teachers,</p><p>Registration for the annual science fair is now open. Please submit your project proposals to Dr. House by the end of the week.</p>',
    attachments: [{ name: 'Registration_Form.pdf' }]
  },
  { 
    id: 2, 
    author: 'Admin Team', 
    date: 'Oct 14, 2023 at 02:30 PM', 
    audience: 'Teachers Only',
    title: 'Staff Meeting Reminder', 
    content: '<p>Don\'t forget our monthly staff meeting in the main hall this Friday at 3:30 PM. We will be discussing the new curriculum guidelines.</p>',
  },
  { 
    id: 3, 
    author: 'Coach Sylvester', 
    date: 'Oct 12, 2023 at 11:15 AM', 
    audience: 'Students Only',
    title: 'Cheerleading Tryouts Moved', 
    content: '<p>Due to gym maintenance, tryouts will be held on the outdoor field instead. Bring appropriate shoes.</p>',
  }
]);

// Computed
const filteredAnnouncements = computed(() => {
  return announcements.value.filter(ann => {
    const matchesSearch = ann.title.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          ann.content.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesAudience = audienceFilter.value === '' || ann.audience === audienceFilter.value;
    return matchesSearch && matchesAudience;
  });
});
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.user-management-container {
  padding: clamp(16px, 3vw, 40px);
  width: 100%;
  max-width: 1000px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: #1e293b;
}

.page-subtitle {
  font-size: 16px;
  color: #64748b;
  margin: 0;
}

.filter-section {
  display: flex;
  gap: 16px;
  margin-bottom: 32px;
}

.search-box {
  flex: 1;
}

.select-box {
  width: 200px;
}

/* Feed */
.announcements-feed {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.announcement-card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  border: 1px solid #e2e8f0;
}

.announcement-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.author-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.author-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: #f1f5f9;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: 600;
  color: #3b82f6;
}

.author-name {
  font-weight: 600;
  color: #0f172a;
}

.announcement-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #64748b;
  margin-top: 4px;
}

.audience-badge {
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 600;
  background: #f1f5f9;
}

.audience-badge.all-school { background: #eff6ff; color: #3b82f6; }
.audience-badge.teachers-only { background: #fef2f2; color: #ef4444; }
.audience-badge.students-only { background: #f0fdf4; color: #10b981; }

.announcement-actions {
  display: flex;
  gap: 8px;
}

.icon-btn {
  width: 32px;
  height: 32px;
  border-radius: 6px;
  border: none;
  background: transparent;
  color: #64748b;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
}

.icon-btn:hover {
  background: #f1f5f9;
  color: #0f172a;
}

.icon-btn.danger:hover {
  background: #fef2f2;
  color: #ef4444;
}

.announcement-title {
  font-size: 20px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 12px 0;
}

.announcement-content {
  color: #475569;
  line-height: 1.6;
}

.announcement-footer {
  margin-top: 24px;
  padding-top: 16px;
  border-top: 1px solid #e2e8f0;
}

.attachment-label {
  font-size: 13px;
  font-weight: 600;
  color: #64748b;
  margin-bottom: 8px;
}

.attachment-list {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.attachment-chip {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 13px;
  color: #3b82f6;
  cursor: pointer;
  transition: all 0.2s;
}

.attachment-chip:hover {
  background: #eff6ff;
  border-color: #bfdbfe;
}

.empty-state {
  text-align: center;
  padding: 64px 24px;
  background: white;
  border-radius: 12px;
  border: 1px dashed #cbd5e1;
  color: #64748b;
}

.empty-icon {
  font-size: 48px;
  color: #94a3b8;
  margin-bottom: 16px;
}
</style>
