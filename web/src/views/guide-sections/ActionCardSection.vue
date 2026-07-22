<template>
<div class="guide-section">
        <h2>4. PPActionCard Colors</h2>
        <div style="background: #f4f5f8; padding: 20px; border-radius: 12px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
          
          <div class="variant-group">
            <h3>Pink Badge</h3>
            <PPActionCard title="Approval" subtitle="Pending" badgeCount="5" badgeColor="pink" />
            <pre class="code-block"><code>&lt;PPActionCard 
  title="Approval" 
  badgeColor="pink" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Orange Badge</h3>
            <PPActionCard title="Payment" subtitle="Due" badgeCount="2" badgeColor="orange" />
            <pre class="code-block"><code>&lt;PPActionCard 
  title="Payment" 
  badgeColor="orange" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Teal Badge</h3>
            <PPActionCard title="Transfer" subtitle="Done" badgeCount="1" badgeColor="teal" />
            <pre class="code-block"><code>&lt;PPActionCard 
  title="Transfer" 
  badgeColor="teal" 
/&gt;</code></pre>
          </div>

          <div class="variant-group">
            <h3>Blue Badge</h3>
            <PPActionCard title="Send" badgeColor="blue" />
            <pre class="code-block"><code>&lt;PPActionCard 
  title="Send" 
  badgeColor="blue" 
/&gt;</code></pre>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPActionCard } from '@phanna/ui-framework';
</script>
