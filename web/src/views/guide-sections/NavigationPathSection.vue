<template>
  <div class="component-section">
    <h2>Navigation Paths</h2>
    <p>Components for guiding users through a sequence of steps or a hierarchical structure.</p>

    <!-- Breadcrumb -->
    <div style="margin-top: 32px;">
      <h3>Breadcrumbs</h3>
      <p>A hierarchical trail of links to help users navigate back to previous pages.</p>
      
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <PPBreadcrumb :items="breadcrumbItems1" />
        
        <PPBreadcrumb :items="breadcrumbItems2" :separatorIcon="chevronForwardOutline" />
      </div>
    </div>

    <!-- Stepper -->
    <div style="margin-top: 32px;">
      <h3>Stepper</h3>
      <p>A wizard component for multi-step processes.</p>
      
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 48px;">
        <div>
          <h4 style="margin-top: 0; color: #64748b; font-size: 14px;">Horizontal (Clickable)</h4>
          <PPStepper 
            :steps="stepperItems" 
            v-model:activeStep="activeStep" 
            clickable 
          />
        </div>
        
        <div style="display: flex; justify-content: space-between; max-width: 400px; margin: 0 auto; width: 100%;">
          <PPButton variant="outline" @click="activeStep--" :disabled="activeStep === 0">Previous</PPButton>
          <PPButton @click="activeStep++" :disabled="activeStep === stepperItems.length - 1">Next</PPButton>
        </div>

        <div>
          <h4 style="margin-top: 0; color: #64748b; font-size: 14px;">Vertical</h4>
          <PPStepper 
            :steps="stepperItems" 
            :activeStep="1" 
            orientation="vertical" 
          />
        </div>
      </div>
    </div>


    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPBreadcrumb :items="breadcrumbs" :separatorIcon="chevronForwardOutline" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPBreadcrumb } from '@phanna/ui-framework';
import { chevronForwardOutline, homeOutline } from 'ionicons/icons';

const breadcrumbs = [
  { label: 'Home', icon: homeOutline, href: '/' },
  { label: 'Settings' }
];
&lt;/script&gt;</code></pre>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPBreadcrumb, PPStepper, PPButton } from '@phanna/ui-framework';
import { folderOutline, imageOutline, imagesOutline, chevronForwardOutline } from 'ionicons/icons';

const breadcrumbItems1 = [
  { label: 'Home', href: '#' },
  { label: 'Dashboard', href: '#' },
  { label: 'Reports' }
];

const breadcrumbItems2 = [
  { label: 'Library', icon: folderOutline, href: '#' },
  { label: 'Images', icon: imageOutline, href: '#' },
  { label: 'Vacation 2026', icon: imagesOutline }
];

const activeStep = ref(1);

const stepperItems = [
  { title: 'Account Setup', description: 'Create your credentials' },
  { title: 'Personal Info', description: 'Address and details' },
  { title: 'Payment', description: 'Add credit card' },
  { title: 'Review', description: 'Confirm your order' }
];
</script>
