<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: url('https://picsum.photos/400/800?random=100') center/cover;">
    
    <!-- Gradient overlay for text readability -->
    <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.1), rgba(0,0,0,0.8));"></div>
    
    <div style="position: absolute; bottom: 0; left: 0; right: 0; padding: 32px; color: white;">
      <h1 style="color: white; font-size: 32px; margin: 0 0 12px 0; font-weight: 700; line-height: 1.1;">Explore the World</h1>
      <p style="color: white; font-size: 16px; opacity: 0.9; margin: 0 0 32px 0; line-height: 1.5;">Discover new places and experiences tailored just for you.</p>
      
      <PPButton variant="primary" block style="height: 54px; font-size: 18px; font-weight: 600; border-radius: 27px;">
        Get Started
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPButton } from '@phanna/ui-framework';
</script>
