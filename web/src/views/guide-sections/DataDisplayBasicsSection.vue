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
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
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

  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Data Display Basics&lt;/h2&gt;
    &lt;p&gt;Essential components for displaying small pieces of information like tags, notifications, and user profiles.&lt;/p&gt;

    &lt;!-- Avatars --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Avatar &amp; Avatar Group&lt;/h3&gt;
      &lt;p&gt;Display user profiles with images, icons, or fallback initials.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;"&gt;
        &lt;div style="display: flex; gap: 16px; align-items: center;"&gt;
          &lt;PPAvatar name="John Doe" size="lg" /&gt;
          &lt;PPAvatar name="Alice Smith" size="md" bgColor="#3b82f6" textColor="white" /&gt;
          &lt;PPAvatar :icon="personOutline" shape="square" size="sm" bgColor="#10b981" textColor="white" /&gt;
          &lt;PPAvatar :icon="starOutline" shape="rounded" size="xs" bgColor="#f59e0b" textColor="white" /&gt;
        &lt;/div&gt;
        
        &lt;div&gt;
          &lt;p style="margin-bottom: 8px; color: #64748b; font-size: 14px;"&gt;Avatar Group&lt;/p&gt;
          &lt;PPAvatarGroup :items="avatarGroupItems" :max="3" size="lg" /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Badges --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Badges&lt;/h3&gt;
      &lt;p&gt;Notification counts and status dots attached to elements.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; gap: 32px; align-items: center;"&gt;
        &lt;PPBadge :value="5" color="danger"&gt;
          &lt;ion-icon :icon="notificationsOutline" style="font-size: 32px; color: #475569;" /&gt;
        &lt;/PPBadge&gt;
        
        &lt;PPBadge :value="99" :max="10" color="primary"&gt;
          &lt;ion-icon :icon="mailOutline" style="font-size: 32px; color: #475569;" /&gt;
        &lt;/PPBadge&gt;

        &lt;PPBadge dot color="success" placement="top-right"&gt;
          &lt;PPAvatar name="Online User" size="md" /&gt;
        &lt;/PPBadge&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Chips --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Chips&lt;/h3&gt;
      &lt;p&gt;Compact elements representing an input, attribute, or action.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; flex-wrap: wrap; gap: 12px;"&gt;
        &lt;PPChip color="primary" variant="solid"&gt;Solid Primary&lt;/PPChip&gt;
        &lt;PPChip color="success" variant="outline" closable&gt;Outline Success&lt;/PPChip&gt;
        &lt;PPChip color="warning" variant="soft" :icon="warningOutline"&gt;Soft Warning&lt;/PPChip&gt;
        &lt;PPChip color="danger" variant="solid" closable&gt;Danger Closable&lt;/PPChip&gt;
        &lt;PPChip color="info" size="sm"&gt;Small Info&lt;/PPChip&gt;
        &lt;PPChip color="default" size="lg"&gt;Large Default&lt;/PPChip&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Dividers --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Dividers&lt;/h3&gt;
      &lt;p&gt;Separates content logically.&lt;/p&gt;
      
      &lt;div class="demo-box"&gt;
        &lt;p style="color: #64748b;"&gt;Content above&lt;/p&gt;
        &lt;PPDivider /&gt;
        &lt;p style="color: #64748b;"&gt;Content below&lt;/p&gt;
        
        &lt;PPDivider variant="dashed" color="#3b82f6"&gt;OR&lt;/PPDivider&gt;
        
        &lt;div style="display: flex; align-items: center; justify-content: center; color: #64748b; height: 40px;"&gt;
          Left &lt;PPDivider orientation="vertical" /&gt; Right
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;div style="display: flex; gap: 16px;"&amp;gt;
    &amp;lt;PPAvatar name="John Doe" size="lg" /&amp;gt;
    
    &amp;lt;PPBadge :value="5" color="danger"&amp;gt;
      &amp;lt;ion-icon :icon="notificationsOutline" style="font-size: 32px;" /&amp;gt;
    &amp;lt;/PPBadge&amp;gt;

    &amp;lt;PPChip color="primary" variant="soft" :icon="starOutline"&amp;gt;
      Premium
    &amp;lt;/PPChip&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPAvatar, PPBadge, PPChip } from '@phanna/ui-framework';
import { notificationsOutline, starOutline } from 'ionicons/icons';
import { IonIcon } from '@ionic/vue';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
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
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
