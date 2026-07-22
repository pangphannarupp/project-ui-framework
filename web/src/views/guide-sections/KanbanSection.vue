<template>
  <div class="component-section">
    <h2>Drag-and-Drop Kanban Board</h2>
    <p>A beautiful, fully interactive Kanban board for project management and state flows. Drag cards within columns or across different columns natively.</p>

    <!-- Basic Kanban Board -->
    <div class="demo-box">
      <h3>Basic Kanban Board</h3>
      <p class="helper-text">Using the default card layout.</p>
      
      <div class="demo-content">
        <PPKanbanBoard 
          v-model="basicBoard" 
          @move-card="handleCardMove"
        />
      </div>

      <pre class="code-block" v-pre><code>&lt;PPKanbanBoard 
  v-model="basicBoard" 
  @move-card="handleCardMove"
/&gt;</code></pre>
    </div>

    <!-- Custom Cards -->
    <div class="demo-box">
      <h3>Custom Cards (via Slots)</h3>
      <p class="helper-text">You can completely replace the UI of the card by using the <code>#card</code> slot.</p>
      
      <div class="demo-content">
        <PPKanbanBoard v-model="customBoard">
          <template #card="{ card }">
            <div class="custom-card">
              <div class="card-header">
                <span class="card-tag" :class="card.priority">{{ card.priority }}</span>
                <span class="card-date">{{ card.date }}</span>
              </div>
              <h4>{{ card.title }}</h4>
              <p class="card-desc">{{ card.description }}</p>
              <div class="card-footer">
                <div class="avatar-group">
                  <img v-for="user in card.users" :key="user" :src="`https://i.pravatar.cc/150?u=${user}`" class="card-avatar" />
                </div>
                <span class="card-comments">💬 {{ card.comments }}</span>
              </div>
            </div>
          </template>
        </PPKanbanBoard>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPKanbanBoard } from '@phanna/ui-framework';

const basicBoard = ref([
  {
    id: 'col-1',
    title: 'To Do',
    cards: [
      { id: 1, text: 'Research competitors' },
      { id: 2, text: 'Design database schema' },
      { id: 3, text: 'Create wireframes' }
    ]
  },
  {
    id: 'col-2',
    title: 'In Progress',
    cards: [
      { id: 4, text: 'Setup project repo' },
      { id: 5, text: 'Implement authentication' }
    ]
  },
  {
    id: 'col-3',
    title: 'Done',
    cards: [
      { id: 6, text: 'Write product requirements' },
      { id: 7, text: 'Initial meeting with client' }
    ]
  }
]);

const customBoard = ref([
  {
    id: 'backlog',
    title: 'Backlog',
    cards: [
      { 
        id: 101, 
        title: 'Fix responsive layout on mobile',
        description: 'The navigation bar overlaps with content on screens smaller than 375px.',
        priority: 'high',
        date: 'Oct 12',
        users: ['alice', 'bob'],
        comments: 3
      },
      { 
        id: 102, 
        title: 'Update dependencies',
        description: 'Upgrade Vue to 3.4 and Vite to v5.',
        priority: 'low',
        date: 'Oct 15',
        users: ['charlie'],
        comments: 0
      }
    ]
  },
  {
    id: 'review',
    title: 'In Review',
    cards: [
      { 
        id: 103, 
        title: 'Add Drag and Drop Kanban Board',
        description: 'Implement a fully featured Kanban board component with animations.',
        priority: 'medium',
        date: 'Oct 14',
        users: ['dave', 'eve'],
        comments: 12
      }
    ]
  }
]);

const handleCardMove = (payload: any) => {
  console.log('Card moved!', payload);
};
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
  margin-top: 24px;
}

/* Custom Card Styles */
.custom-card {
  background: white;
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06);
  border: 1px solid #e5e7eb;
}

.card-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}

.card-tag {
  font-size: 11px;
  text-transform: uppercase;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 4px;
}

.card-tag.high { background: #fee2e2; color: #991b1b; }
.card-tag.medium { background: #fef3c7; color: #92400e; }
.card-tag.low { background: #d1fae5; color: #065f46; }

.card-date {
  font-size: 12px;
  color: #6b7280;
}

.custom-card h4 {
  margin: 0 0 8px 0;
  font-size: 15px;
  color: #111827;
}

.card-desc {
  font-size: 13px;
  color: #4b5563;
  margin: 0 0 16px 0;
  line-height: 1.4;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatar-group {
  display: flex;
}

.card-avatar {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  border: 2px solid white;
  margin-left: -8px;
}

.card-avatar:first-child {
  margin-left: 0;
}

.card-comments {
  font-size: 12px;
  color: #6b7280;
}
</style>
