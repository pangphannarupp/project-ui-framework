<template>
  <div class="component-section">
    <h2>Data Display Basics</h2>
    <p>Essential components for displaying small pieces of information like tags, notifications, and user profiles.</p>

    <!-- Avatars -->
    <div style="margin-top: 32px;">
      <h3>Avatar & Avatar Group</h3>
      <p>Display user profiles with images, icons, or fallback initials.</p>
      
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <div style="display: flex; gap: 16px; align-items: center;">
          <PPAvatar name="John Doe" size="lg" />
          <PPAvatar name="Alice Smith" size="md" bgColor="#3b82f6" textColor="white" />
          <PPAvatar :icon="personOutline" shape="square" size="sm" bgColor="#10b981" textColor="white" />
          <PPAvatar :icon="starOutline" shape="rounded" size="xs" bgColor="#f59e0b" textColor="white" />
        </div>
        
        <div>
          <p style="margin-bottom: 8px; color: #64748b; font-size: 14px;">Avatar Group</p>
          <PPAvatarGroup :items="avatarGroupItems" :max="3" size="lg" />
        </div>
      </div>
    </div>

    <!-- Badges -->
    <div style="margin-top: 32px;">
      <h3>Badges</h3>
      <p>Notification counts and status dots attached to elements.</p>
      
      <div class="demo-box" style="display: flex; gap: 32px; align-items: center;">
        <PPBadge :value="5" color="danger">
          <ion-icon :icon="notificationsOutline" style="font-size: 32px; color: #475569;" />
        </PPBadge>
        
        <PPBadge :value="99" :max="10" color="primary">
          <ion-icon :icon="mailOutline" style="font-size: 32px; color: #475569;" />
        </PPBadge>

        <PPBadge dot color="success" placement="top-right">
          <PPAvatar name="Online User" size="md" />
        </PPBadge>
      </div>
    </div>

    <!-- Chips -->
    <div style="margin-top: 32px;">
      <h3>Chips</h3>
      <p>Compact elements representing an input, attribute, or action.</p>
      
      <div class="demo-box" style="display: flex; flex-wrap: wrap; gap: 12px;">
        <PPChip color="primary" variant="solid">Solid Primary</PPChip>
        <PPChip color="success" variant="outline" closable>Outline Success</PPChip>
        <PPChip color="warning" variant="soft" :icon="warningOutline">Soft Warning</PPChip>
        <PPChip color="danger" variant="solid" closable>Danger Closable</PPChip>
        <PPChip color="info" size="sm">Small Info</PPChip>
        <PPChip color="default" size="lg">Large Default</PPChip>
      </div>
    </div>

    <!-- Dividers -->
    <div style="margin-top: 32px;">
      <h3>Dividers</h3>
      <p>Separates content logically.</p>
      
      <div class="demo-box">
        <p style="color: #64748b;">Content above</p>
        <PPDivider />
        <p style="color: #64748b;">Content below</p>
        
        <PPDivider variant="dashed" color="#3b82f6">OR</PPDivider>
        
        <div style="display: flex; align-items: center; justify-content: center; color: #64748b; height: 40px;">
          Left <PPDivider orientation="vertical" /> Right
        </div>
      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;div style="display: flex; gap: 16px;"&gt;
    &lt;PPAvatar name="John Doe" size="lg" /&gt;
    
    &lt;PPBadge :value="5" color="danger"&gt;
      &lt;ion-icon :icon="notificationsOutline" style="font-size: 32px;" /&gt;
    &lt;/PPBadge&gt;

    &lt;PPChip color="primary" variant="soft" :icon="starOutline"&gt;
      Premium
    &lt;/PPChip&gt;
  &lt;/div&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPAvatar, PPBadge, PPChip } from '@phanna/ui-framework';
import { notificationsOutline, starOutline } from 'ionicons/icons';
import { IonIcon } from '@ionic/vue';
&lt;/script&gt;</code></pre>
    </div>

  </div>
</template>

<script setup lang="ts">
import { notificationsOutline, mailOutline, personOutline, starOutline, warningOutline } from 'ionicons/icons';
import { PPAvatar, PPAvatarGroup, PPBadge, PPChip, PPDivider } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';

const avatarGroupItems = [
  { name: 'Adam' },
  { name: 'Bob', bgColor: '#3b82f6', textColor: 'white' },
  { name: 'Charlie', bgColor: '#10b981', textColor: 'white' },
  { name: 'David' },
  { name: 'Eve' }
];
</script>
