<template>
  <div class="guide-section">
    <h2>Cards Collection</h2>
    <p>Various specialized card components used to display user and account data.</p>

    <h3>User Profile Card</h3>
    <div class="demo-box">
      <BizUserProfile 
        name="John Doe" 
        email="john@example.com" 
        avatar="https://i.pravatar.cc/150?u=a042581f4e29026704d" 
      />
    </div>

    <h3>Verification Card</h3>
    <div class="demo-box">
      <BizVerificationCard 
        title="Identity Verification"
        description="Verify your identity to unlock all features."
        status="pending"
      />
    </div>

    <h3>Upgrade Card</h3>
    <div class="demo-box">
      <BizUpgradeCard 
        title="Upgrade to Pro"
        description="Get access to premium features and unlimited storage."
        price="$9.99/mo"
      />
    </div>

  </div>
</template>

<script setup lang="ts">
import { BizUserProfile, BizVerificationCard, BizUpgradeCard } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; display: flex; flex-direction: column; gap: 16px; }
</style>
