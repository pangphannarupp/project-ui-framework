<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Support Tickets</h1>
            <p class="page-subtitle">Track and resolve customer inquiries.</p>
          </div>
          <div class="header-right">
            <PPButton variant="primary">New Ticket</PPButton>
          </div>
        </div>

        <div class="kanban-wrapper">
          <PPKanbanBoard 
            v-model="kanbanColumns" 
          />
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonContent } from '@ionic/vue';
import { PPKanbanBoard, PPButton } from '@phanna/ui-framework';

const kanbanColumns = ref([
  { 
    id: 'open', 
    title: 'Open',
    cards: [
      { id: 'TCK-001', title: 'Where is my order?', description: 'Customer asking for tracking update on ORD-1004.' },
      { id: 'TCK-002', title: 'Received damaged item', description: 'Headphones arrived broken in the box.' }
    ]
  },
  { 
    id: 'in-progress', 
    title: 'In Progress',
    cards: [
      { id: 'TCK-003', title: 'Refund request', description: 'Processing refund for returned keyboard.' }
    ]
  },
  { 
    id: 'waiting', 
    title: 'Waiting on Customer',
    cards: [
      { id: 'TCK-004', title: 'Missing pieces', description: 'Asked customer to send a picture of the package.' }
    ]
  },
  { 
    id: 'resolved', 
    title: 'Resolved',
    cards: [
      { id: 'TCK-005', title: 'Address change', description: 'Updated shipping address for ORD-1002.' }
    ]
  }
]);


</script>

<style scoped>
ion-content {
  --background: transparent;
}

.page-container {
  padding: 40px;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 32px;
  flex-shrink: 0;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.kanban-wrapper {
  flex: 1;
  min-height: 500px;
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  padding: 24px;
  overflow-x: auto;
}

@media (max-width: 768px) {
  .header-section {
    flex-direction: column;
    gap: 16px;
  }
  .page-container {
    padding: 20px;
  }
}
</style>
