<template>
  <div class="guide-section">
    <h2>Cards Collection</h2>
    <p>Various specialized card components used to display user and account data.</p>

    <h3>User Profile Card</h3>
    <div class="demo-box">
      <PPUserProfile 
        userName="John Doe" 
        email="john@example.com" 
        avatarUrl="https://i.pravatar.cc/150?u=a042581f4e29026704d" 
      />
    </div>

    <h3>Verification Card</h3>
    <div class="demo-box">
      <PPVerificationCard 
        title="Identity Verification"
        description="Verify your identity to unlock all features."
        status="pending"
      />
    </div>

    <h3>Upgrade Card</h3>
    <div class="demo-box">
      <PPUpgradeCard 
        title="Upgrade to Pro"
        description="Get access to premium features and unlimited storage."
        price="$9.99/mo"
      />
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
  &lt;div class="guide-section"&gt;
    &lt;h2&gt;Cards Collection&lt;/h2&gt;
    &lt;p&gt;Various specialized card components used to display user and account data.&lt;/p&gt;

    &lt;h3&gt;User Profile Card&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPUserProfile 
        userName="John Doe" 
        email="john@example.com" 
        avatarUrl="https://i.pravatar.cc/150?u=a042581f4e29026704d" 
      /&gt;
    &lt;/div&gt;

    &lt;h3&gt;Verification Card&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPVerificationCard 
        title="Identity Verification"
        description="Verify your identity to unlock all features."
        status="pending"
      /&gt;
    &lt;/div&gt;

    &lt;h3&gt;Upgrade Card&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPUpgradeCard 
        title="Upgrade to Pro"
        description="Get access to premium features and unlimited storage."
        price="$9.99/mo"
      /&gt;
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
import { PPUserProfile, PPVerificationCard, PPUpgradeCard } from '@phanna/ui-framework';
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; display: flex; flex-direction: column; gap: 16px; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { PPUserProfile, PPVerificationCard, PPUpgradeCard } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; display: flex; flex-direction: column; gap: 16px; }
</style>
