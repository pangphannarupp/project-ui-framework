<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; display: flex; flex-direction: column;">
    <PPAppBar title="Categories" />
    <div style="background: white; border-bottom: 1px solid var(--pp-border, #e2e8f0);">
      <PPTabs v-model="activeTab" variant="standard">
        <PPTabList scrollable>
          <PPTab value="for_you">For You</PPTab>
          <PPTab value="trending">Trending</PPTab>
          <PPTab value="following">Following</PPTab>
        </PPTabList>
      </PPTabs>
    </div>
    
    <div style="flex: 1; overflow-y: auto; padding: 16px; background: #f8fafc;">
      <div v-if="activeTab === 'for_you'">
        <h3 style="margin-top: 0;">For You</h3>
        <div style="display: flex; flex-direction: column; gap: 12px;">
          <div v-for="i in 3" :key="i" style="background: white; padding: 16px; border-radius: 8px; box-shadow: 0 1px 2px rgba(0,0,0,0.05);">
            Item {{ i }}
          </div>
        </div>
      </div>
      <div v-if="activeTab === 'trending'">
        <h3 style="margin-top: 0;">Trending</h3>
        <p>See what's popular right now.</p>
      </div>
      <div v-if="activeTab === 'following'">
        <h3 style="margin-top: 0;">Following</h3>
        <p>Updates from people you follow.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPAppBar, PPTabs, PPTabList, PPTab } from '@phanna/ui-framework';

const activeTab = ref('for_you');
</script>
