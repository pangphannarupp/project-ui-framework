<template>
  <div class="guide-section">
    <h2>Onboarding</h2>
    <p>A step-by-step swipeable interface for introducing users to the application.</p>

    <h3>Standard Onboarding</h3>
    <div class="demo-box onboard-demo">
      <PPOnboard 
        :steps="onboardSteps" 
        @skip="handleSkip"
        @complete="handleComplete"
      />
    </div>
    
    <pre class="code-block" style="margin-top: 24px;" v-pre><code>&lt;PPOnboard 
  :steps="[
    { title: 'Welcome', description: 'Start your journey', icon: globeOutline },
    { title: 'Secure', description: 'Your data is safe', icon: lockClosedOutline }
  ]"
  @skip="onSkip"
  @complete="onComplete"
/&gt;</code></pre>
  
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
  &lt;div class="guide-section"&gt;
    &lt;h2&gt;Onboarding&lt;/h2&gt;
    &lt;p&gt;A step-by-step swipeable interface for introducing users to the application.&lt;/p&gt;

    &lt;h3&gt;Standard Onboarding&lt;/h3&gt;
    &lt;div class="demo-box onboard-demo"&gt;
      &lt;PPOnboard 
        :steps="onboardSteps" 
        @skip="handleSkip"
        @complete="handleComplete"
      /&gt;
    &lt;/div&gt;
    
    &lt;pre class="code-block" style="margin-top: 24px;"&gt;&lt;code&gt;&amp;lt;PPOnboard 
  :steps="[
    { title: 'Welcome', description: 'Start your journey', icon: globeOutline },
    { title: 'Secure', description: 'Your data is safe', icon: lockClosedOutline }
  ]"
  @skip="onSkip"
  @complete="onComplete"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
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
import { PPOnboard } from '@phanna/ui-framework';
import { rocketOutline, colorPaletteOutline, flashOutline } from 'ionicons/icons';

const onboardSteps = [
  {
    title: 'Welcome to UI Framework',
    description: 'Build modern applications with our comprehensive suite of components.',
    icon: rocketOutline
  },
  {
    title: 'Beautiful Design',
    description: 'Every component is carefully crafted to look great right out of the box.',
    icon: colorPaletteOutline
  },
  {
    title: 'Fast &amp; Responsive',
    description: 'Optimized for performance across all devices and screen sizes.',
    icon: flashOutline
  }
];

const handleSkip = () =&gt; {
  console.log('User skipped onboarding');
};

const handleComplete = () =&gt; {
  console.log('User completed onboarding');
};
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden; background: #f9fafb; }
.onboard-demo { height: 600px; max-width: 400px; margin: 0 auto; position: relative; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { PPOnboard } from '@phanna/ui-framework';
import { rocketOutline, colorPaletteOutline, flashOutline } from 'ionicons/icons';

const onboardSteps = [
  {
    title: 'Welcome to UI Framework',
    description: 'Build modern applications with our comprehensive suite of components.',
    icon: rocketOutline
  },
  {
    title: 'Beautiful Design',
    description: 'Every component is carefully crafted to look great right out of the box.',
    icon: colorPaletteOutline
  },
  {
    title: 'Fast & Responsive',
    description: 'Optimized for performance across all devices and screen sizes.',
    icon: flashOutline
  }
];

const handleSkip = () => {
  console.log('User skipped onboarding');
};

const handleComplete = () => {
  console.log('User completed onboarding');
};
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden; background: #f9fafb; }
.onboard-demo { height: 600px; max-width: 400px; margin: 0 auto; position: relative; }
</style>
