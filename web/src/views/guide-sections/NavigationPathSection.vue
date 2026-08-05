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
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
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
    &lt;h2&gt;Navigation Paths&lt;/h2&gt;
    &lt;p&gt;Components for guiding users through a sequence of steps or a hierarchical structure.&lt;/p&gt;

    &lt;!-- Breadcrumb --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Breadcrumbs&lt;/h3&gt;
      &lt;p&gt;A hierarchical trail of links to help users navigate back to previous pages.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;"&gt;
        &lt;PPBreadcrumb :items="breadcrumbItems1" /&gt;
        
        &lt;PPBreadcrumb :items="breadcrumbItems2" :separatorIcon="chevronForwardOutline" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Stepper --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Stepper&lt;/h3&gt;
      &lt;p&gt;A wizard component for multi-step processes.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 48px;"&gt;
        &lt;div&gt;
          &lt;h4 style="margin-top: 0; color: #64748b; font-size: 14px;"&gt;Horizontal (Clickable)&lt;/h4&gt;
          &lt;PPStepper 
            :steps="stepperItems" 
            v-model:activeStep="activeStep" 
            clickable 
          /&gt;
        &lt;/div&gt;
        
        &lt;div style="display: flex; justify-content: space-between; max-width: 400px; margin: 0 auto; width: 100%;"&gt;
          &lt;PPButton variant="outline" @click="activeStep--" :disabled="activeStep === 0"&gt;Previous&lt;/PPButton&gt;
          &lt;PPButton @click="activeStep++" :disabled="activeStep === stepperItems.length - 1"&gt;Next&lt;/PPButton&gt;
        &lt;/div&gt;

        &lt;div&gt;
          &lt;h4 style="margin-top: 0; color: #64748b; font-size: 14px;"&gt;Vertical&lt;/h4&gt;
          &lt;PPStepper 
            :steps="stepperItems" 
            :activeStep="1" 
            orientation="vertical" 
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;


    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPBreadcrumb :items="breadcrumbs" :separatorIcon="chevronForwardOutline" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPBreadcrumb } from '@phanna/ui-framework';
import { chevronForwardOutline, homeOutline } from 'ionicons/icons';

const breadcrumbs = [
  { label: 'Home', icon: homeOutline, href: '/' },
  { label: 'Settings' }
];
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
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
