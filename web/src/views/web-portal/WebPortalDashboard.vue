<template>
  <ion-page>
    <ion-content>
    <div class="dashboard">
        <div class="welcome-section">
          <h1 class="greeting">Welcome back, Alex! 👋</h1>
          <p class="subtitle">Here's what's happening with your projects today.</p>
        </div>

        <div class="stats-grid">
          <PPActionCard 
            title="Total Revenue" 
            subtitle="$24,592" 
            badgeColor="teal"
          >
            <template #icon>💰</template>
          </PPActionCard>
          <PPActionCard 
            title="Active Users" 
            subtitle="1,432" 
            badgeColor="blue"
          >
            <template #icon>👨‍💻</template>
          </PPActionCard>
          <PPActionCard 
            title="Bounce Rate" 
            subtitle="24.5%" 
            badgeColor="orange"
          >
            <template #icon>📉</template>
          </PPActionCard>
        </div>

        <div class="recent-activity">
          <h2 style="margin-bottom: 24px; color: #1e293b; font-size: 20px; font-weight: 600;">Recent Activity</h2>
          
          <PPTimeline direction="vertical" align="left" animated>
            <PPTimelineItem timestamp="2 hours ago" type="primary" size="large">
              <template #icon>📝</template>
              <div>
                <strong style="color: #1e293b">New project 'Alpha' created</strong> by Sarah M.
              </div>
            </PPTimelineItem>
            
            <PPTimelineItem timestamp="5 hours ago" type="success" size="large">
              <template #icon>✅</template>
              <div>
                <strong style="color: #1e293b">System update completed</strong> successfully.
              </div>
            </PPTimelineItem>
            
            <PPTimelineItem timestamp="1 day ago" type="warning" size="large">
              <template #icon>⚠️</template>
              <div>
                <strong style="color: #1e293b">Server load warning</strong> detected on Node-3.
              </div>
            </PPTimelineItem>
          </PPTimeline>
        </div>
      </div>
  </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent } from '@ionic/vue';
import { PPActionCard, PPTimeline, PPTimelineItem } from '@phanna/ui-framework';
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.dashboard {
  padding: clamp(16px, 3vw, 40px);
  width: 100%;
}

.welcome-section {
  margin-bottom: 40px;
  animation: fadeInDown 0.8s ease-out forwards;
}

.greeting {
  font-size: 36px;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: #1e293b;
}

.subtitle {
  color: #64748b;
  font-size: 16px;
  margin: 0;
}

/* Stats Grid */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
  margin-bottom: 48px;
}

/* Recent Activity */
.recent-activity {
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  padding: 32px;
  opacity: 0;
  animation: fadeInUp 0.8s ease-out 0.4s forwards;
}

/* Animations */
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeInDown {
  from { opacity: 0; transform: translateY(-20px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
