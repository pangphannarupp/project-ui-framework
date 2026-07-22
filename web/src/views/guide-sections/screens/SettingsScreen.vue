<template>
  <div class="component-section">
    <h2>Settings & Profile Template</h2>
    <p>A standard user settings page with tabs, file uploads, toggles, and form inputs.</p>

    <div class="demo-box template-demo">
      <div class="settings-layout">
        <!-- Settings Header -->
        <div class="settings-header">
          <div class="header-content">
            <h3>Account Settings</h3>
            <p>Manage your profile, preferences, and security.</p>
          </div>
        </div>

        <!-- Settings Tabs -->
          <div class="settings-tab-list">
            <button 
              v-for="tab in ['Profile', 'Notifications', 'Security']" 
              :key="tab"
              :class="['tab-btn', { active: activeTab === tab }]"
              @click="activeTab = tab"
            >
              {{ tab }}
            </button>
          </div>

        <!-- Settings Body -->
        <div class="settings-body">
          
          <!-- Profile Tab -->
          <div v-if="activeTab === 'Profile'" class="tab-pane">
            <div class="profile-section">
              <div class="avatar-upload-area">
                <img src="https://i.pravatar.cc/150?u=a" alt="Avatar" class="profile-avatar" />
                <div class="upload-controls">
                  <h4>Profile Picture</h4>
                  <p>JPG, GIF or PNG. Max size of 800K</p>
                  <!-- We simulate a file upload button -->
                  <button class="pp-btn pp-btn-outline pp-btn-sm">Change Picture</button>
                </div>
              </div>
            </div>

            <hr class="divider" />

            <div class="form-grid">
              <div class="form-group half">
                <PPTextField v-model="form.firstName" label="First Name" />
              </div>
              <div class="form-group half">
                <PPTextField v-model="form.lastName" label="Last Name" />
              </div>
              <div class="form-group full">
                <PPTextField v-model="form.email" label="Email Address" type="email" />
              </div>
              <div class="form-group full">
                <PPTextField v-model="form.bio" label="Bio" placeholder="Write a few sentences about yourself." />
              </div>
            </div>

            <div class="form-actions">
              <button class="pp-btn pp-btn-primary">Save Changes</button>
            </div>
          </div>

          <!-- Notifications Tab -->
          <div v-if="activeTab === 'Notifications'" class="tab-pane">
            <div class="settings-list">
              <div class="setting-item">
                <div class="setting-info">
                  <h4>Email Notifications</h4>
                  <p>Receive daily summaries of your activity.</p>
                </div>
                <!-- Using a standard checkbox visually styled as a switch, or Biz components if imported -->
                <label class="pp-toggle">
                  <input type="checkbox" v-model="notifs.email" />
                  <span class="toggle-slider"></span>
                </label>
              </div>

              <div class="setting-item">
                <div class="setting-info">
                  <h4>Push Notifications</h4>
                  <p>Get alerted immediately when someone mentions you.</p>
                </div>
                <label class="pp-toggle">
                  <input type="checkbox" v-model="notifs.push" />
                  <span class="toggle-slider"></span>
                </label>
              </div>
              
              <div class="setting-item">
                <div class="setting-info">
                  <h4>Marketing Emails</h4>
                  <p>Receive updates about new features and promotions.</p>
                </div>
                <label class="pp-toggle">
                  <input type="checkbox" v-model="notifs.marketing" />
                  <span class="toggle-slider"></span>
                </label>
              </div>
            </div>
            
            <div class="form-actions">
              <button class="pp-btn pp-btn-primary">Update Preferences</button>
            </div>
          </div>

          <!-- Security Tab -->
          <div v-if="activeTab === 'Security'" class="tab-pane">
            <div class="form-grid">
              <div class="form-group full">
                <PPTextField v-model="pass.current" label="Current Password" type="password" />
              </div>
              <div class="form-group half">
                <PPTextField v-model="pass.new" label="New Password" type="password" />
              </div>
              <div class="form-group half">
                <PPTextField v-model="pass.confirm" label="Confirm Password" type="password" />
              </div>
            </div>
            <div class="form-actions">
              <button class="pp-btn pp-btn-primary">Change Password</button>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTextField } from '@phanna/ui-framework';

const activeTab = ref('Profile');

const form = ref({
  firstName: 'John',
  lastName: 'Doe',
  email: 'john.doe@example.com',
  bio: 'Frontend developer and UI enthusiast.'
});

const notifs = ref({
  email: true,
  push: true,
  marketing: false
});

const pass = ref({
  current: '',
  new: '',
  confirm: ''
});
</script>

<style scoped>
.template-demo {
  padding: 0;
  background: #f9fafb;
}

.settings-layout {
  display: flex;
  flex-direction: column;
  min-height: 600px;
}

.settings-header {
  background: white;
  padding: 32px 32px 0 32px;
  border-bottom: 1px solid #e5e7eb;
}

.header-content h3 {
  margin: 0 0 8px 0;
  font-size: 24px;
  color: #111827;
}

.header-content p {
  margin: 0 0 24px 0;
  color: #6b7280;
  font-size: 15px;
}

.settings-tab-list {
  display: flex;
  gap: 24px;
  border-bottom: 2px solid transparent;
}

.tab-btn {
  background: none;
  border: none;
  padding: 12px 0;
  font-size: 15px;
  font-weight: 500;
  color: #6b7280;
  cursor: pointer;
  position: relative;
}

.tab-btn:hover {
  color: #374151;
}

.tab-btn.active {
  color: #4f46e5;
}

.tab-btn.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  right: 0;
  height: 2px;
  background: #4f46e5;
  border-radius: 2px 2px 0 0;
}

.settings-body {
  padding: 32px;
  flex: 1;
}

.tab-pane {
  max-width: 640px;
  background: white;
  padding: 32px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  border: 1px solid #e5e7eb;
}

.profile-section {
  margin-bottom: 24px;
}

.avatar-upload-area {
  display: flex;
  align-items: center;
  gap: 24px;
}

.profile-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #e5e7eb;
}

.upload-controls h4 {
  margin: 0 0 4px 0;
  font-size: 15px;
  color: #111827;
}

.upload-controls p {
  margin: 0 0 12px 0;
  font-size: 13px;
  color: #6b7280;
}

.divider {
  border: 0;
  border-top: 1px solid #e5e7eb;
  margin: 24px 0;
}

.form-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.form-group.half {
  flex: 1 1 calc(50% - 10px);
}

.form-group.full {
  flex: 1 1 100%;
}

.form-actions {
  margin-top: 32px;
  display: flex;
  justify-content: flex-end;
}

.pp-btn {
  padding: 10px 16px;
  border-radius: 6px;
  font-weight: 500;
  font-size: 14px;
  cursor: pointer;
  border: none;
}

.pp-btn-sm {
  padding: 6px 12px;
  font-size: 13px;
}

.pp-btn-primary {
  background: #4f46e5;
  color: white;
}

.pp-btn-primary:hover {
  background: #4338ca;
}

.pp-btn-outline {
  background: white;
  color: #374151;
  border: 1px solid #d1d5db;
}

/* Custom quick toggle */
.settings-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.setting-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.setting-info h4 {
  margin: 0 0 4px 0;
  font-size: 15px;
  color: #111827;
}

.setting-info p {
  margin: 0;
  font-size: 14px;
  color: #6b7280;
}

.pp-toggle {
  position: relative;
  display: inline-block;
  width: 44px;
  height: 24px;
}

.pp-toggle input {
  opacity: 0;
  width: 0;
  height: 0;
}

.toggle-slider {
  position: absolute;
  cursor: pointer;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: #cbd5e1;
  transition: .3s;
  border-radius: 24px;
}

.toggle-slider:before {
  position: absolute;
  content: "";
  height: 20px;
  width: 20px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: .3s;
  border-radius: 50%;
  box-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

.pp-toggle input:checked + .toggle-slider {
  background-color: #4f46e5;
}

.pp-toggle input:checked + .toggle-slider:before {
  transform: translateX(20px);
}
</style>
