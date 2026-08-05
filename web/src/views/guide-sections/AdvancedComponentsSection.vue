<template>
  <div class="component-section">
    <h2>Advanced Data & Media Components</h2>
    <p>A collection of complex, interactive components including E-commerce cards, rich inputs, canvas drawings, and media tools.</p>

    <!-- 1. Credit Card -->
    <div style="margin-top: 40px;">
      <h3>Animated Credit Card Input (PPCreditCard)</h3>
      <p>A 3D flipping credit card UI that updates automatically as the user types.</p>
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px;">
        <PPCreditCard />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPCreditCard /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPCreditCard } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 2. Tag Input -->
    <div style="margin-top: 40px;">
      <h3>Tag Input (PPTagInput)</h3>
      <p>Type a word and press Enter to create a deletable chip/tag.</p>
      <div class="demo-box">
        <PPTagInput v-model="tags" placeholder="Add some skills..." />
        <p style="margin-top: 12px; font-size: 13px; color: #64748b;">Current Tags: {{ tags.join(', ') }}</p>
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPTagInput v-model="tags" placeholder="Add some skills..." /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPTagInput } from '@phanna/ui-framework';

const tags = ref(['Vue', 'TypeScript']);
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 3. Password Strength -->
    <div style="margin-top: 40px;">
      <h3>Password Strength Meter (PPPasswordStrength)</h3>
      <p>Provides visual feedback on password complexity rules.</p>
      <div class="demo-box" style="max-width: 400px;">
        <PPPasswordStrength v-model="password" />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPPasswordStrength v-model="password" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPPasswordStrength } from '@phanna/ui-framework';

const password = ref('');
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 4. Audio Wave -->
    <div style="margin-top: 40px;">
      <h3>Audio Waveform (PPAudioWave)</h3>
      <p>A visual representation of playing audio, similar to voice notes.</p>
      <div class="demo-box">
        <PPAudioWave />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPAudioWave :bars="30" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPAudioWave } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 5. QR Code -->
    <div style="margin-top: 40px;">
      <h3>QR Code Generator (PPQRCode)</h3>
      <p>Generates a scanable QR code for a string.</p>
      <div class="demo-box">
        <div style="margin-bottom: 16px; max-width: 300px;">
          <input type="text" v-model="qrText" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;" placeholder="Enter URL to encode" />
        </div>
        <PPQRCode :value="qrText" :size="150" downloadable />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPQRCode value="https://github.com" :size="150" downloadable /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPQRCode } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 7. Magnifier -->
    <div style="margin-top: 40px;">
      <h3>Product Image Magnifier (PPMagnifier)</h3>
      <p>Hover over the image to inspect it with a magnifying glass lens.</p>
      <div class="demo-box">
        <PPMagnifier src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Watch" />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPMagnifier 
    src="https://images.unsplash.com/photo-1523275335684.jpg" 
    :zoom="2.5" 
    :lensSize="120" 
  /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPMagnifier } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 8. Canvas -->
    <div style="margin-top: 40px;">
      <h3>Whiteboard / Draw Canvas (PPDrawCanvas)</h3>
      <p>An interactive drawing pad with color picking and erasing.</p>
      <div class="demo-box">
        <PPDrawCanvas />
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPDrawCanvas :width="600" :height="400" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPDrawCanvas } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 9. Splitter -->
    <div style="margin-top: 40px;">
      <h3>Resizable Splitter (PPSplitter)</h3>
      <p>A drag-and-drop resizable split pane.</p>
      <div class="demo-box" style="height: 300px;">
        <PPSplitter direction="horizontal" :initialSplit="50">
          <template #primary>
            <div style="padding: 20px; background: #e0f2fe; height: 100%;">Left Pane</div>
          </template>
          <template #secondary>
            <div style="padding: 20px; background: #fce7f3; height: 100%;">Right Pane</div>
          </template>
        </PPSplitter>
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPSplitter direction="horizontal" :initialSplit="50"&gt;
    &lt;template #primary&gt;
      &lt;div&gt;Left Pane&lt;/div&gt;
    &lt;/template&gt;
    &lt;template #secondary&gt;
      &lt;div&gt;Right Pane&lt;/div&gt;
    &lt;/template&gt;
  &lt;/PPSplitter&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPSplitter } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 6. Masonry Grid -->
    <div style="margin-top: 40px;">
      <h3>Masonry Grid Layout (PPMasonry)</h3>
      <p>A Pinterest-style staggered grid layout.</p>
      <div class="demo-box">
        <PPMasonry :columns="3" :gap="16">
          <div v-for="i in 9" :key="i" class="masonry-item" :style="{ height: `${Math.floor(Math.random() * 150) + 100}px` }">
            Item {{ i }}
          </div>
        </PPMasonry>
      </div>
      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPMasonry :columns="3" :gap="16"&gt;
    &lt;div v-for="item in items" :key="item.id"&gt;
      {{ item.content }}
    &lt;/div&gt;
  &lt;/PPMasonry&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPMasonry } from '@phanna/ui-framework';
const items = [...];
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- 10. Camera Capture -->
    <div style="margin-top: 40px;">
      <h3>Camera Capture (PPCameraCapture)</h3>
      <p>A camera viewer that captures photos using the device camera.</p>
      <div class="demo-box">
        <PPCameraCapture height="400" />
      </div>
    </div>

    <!-- 11. Audio Recorder -->
    <div style="margin-top: 40px;">
      <h3>Audio Recorder (PPAudioRecorder)</h3>
      <p>An interactive microphone recorder that outputs audio blobs.</p>
      <div class="demo-box">
        <PPAudioRecorder />
      </div>
    </div>

    <!-- 12. Map Viewer -->
    <div style="margin-top: 40px;">
      <h3>Map Viewer (PPMapViewer)</h3>
      <p>A map interface that renders dynamic markers.</p>
      <div class="demo-box">
        <PPMapViewer :markers="[{ top: '50%', left: '50%', label: 'Current Location' }]" />
      </div>
    </div>

    <!-- 13. Video Player -->
    <div style="margin-top: 40px;">
      <h3>Video Player (PPVideoPlayer)</h3>
      <p>A custom styled video player with timeline and speed controls.</p>
      <div class="demo-box">
        <PPVideoPlayer src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" />
      </div>
    </div>

    <!-- 14. Confetti -->
    <div style="margin-top: 40px;">
      <h3>Confetti (PPConfetti)</h3>
      <p>A celebratory micro-interaction component.</p>
      <div class="demo-box" style="display: flex; align-items: center; justify-content: center; padding: 40px;">
        <button 
          @click="showConfetti = true" 
          style="padding: 12px 24px; background: #3b82f6; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;"
        >
          Celebrate!
        </button>
        <PPConfetti v-model:active="showConfetti" />
      </div>
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
    &lt;h2&gt;Advanced Data &amp; Media Components&lt;/h2&gt;
    &lt;p&gt;A collection of complex, interactive components including E-commerce cards, rich inputs, canvas drawings, and media tools.&lt;/p&gt;

    &lt;!-- 1. Credit Card --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Animated Credit Card Input (PPCreditCard)&lt;/h3&gt;
      &lt;p&gt;A 3D flipping credit card UI that updates automatically as the user types.&lt;/p&gt;
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px;"&gt;
        &lt;PPCreditCard /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPCreditCard /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPCreditCard } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 2. Tag Input --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Tag Input (PPTagInput)&lt;/h3&gt;
      &lt;p&gt;Type a word and press Enter to create a deletable chip/tag.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPTagInput v-model="tags" placeholder="Add some skills..." /&gt;
        &lt;p style="margin-top: 12px; font-size: 13px; color: #64748b;"&gt;Current Tags: {{ tags.join(', ') }}&lt;/p&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPTagInput v-model="tags" placeholder="Add some skills..." /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPTagInput } from '@phanna/ui-framework';

const tags = ref(['Vue', 'TypeScript']);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 3. Password Strength --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Password Strength Meter (PPPasswordStrength)&lt;/h3&gt;
      &lt;p&gt;Provides visual feedback on password complexity rules.&lt;/p&gt;
      &lt;div class="demo-box" style="max-width: 400px;"&gt;
        &lt;PPPasswordStrength v-model="password" /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPPasswordStrength v-model="password" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPPasswordStrength } from '@phanna/ui-framework';

const password = ref('');
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 4. Audio Wave --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Audio Waveform (PPAudioWave)&lt;/h3&gt;
      &lt;p&gt;A visual representation of playing audio, similar to voice notes.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPAudioWave /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPAudioWave :bars="30" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPAudioWave } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 5. QR Code --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;QR Code Generator (PPQRCode)&lt;/h3&gt;
      &lt;p&gt;Generates a scanable QR code for a string.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;div style="margin-bottom: 16px; max-width: 300px;"&gt;
          &lt;input type="text" v-model="qrText" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;" placeholder="Enter URL to encode" /&gt;
        &lt;/div&gt;
        &lt;PPQRCode :value="qrText" :size="150" downloadable /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPQRCode value="https://github.com" :size="150" downloadable /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPQRCode } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 7. Magnifier --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Product Image Magnifier (PPMagnifier)&lt;/h3&gt;
      &lt;p&gt;Hover over the image to inspect it with a magnifying glass lens.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPMagnifier src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&amp;auto=format&amp;fit=crop&amp;w=600&amp;q=80" alt="Watch" /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPMagnifier 
    src="https://images.unsplash.com/photo-1523275335684.jpg" 
    :zoom="2.5" 
    :lensSize="120" 
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPMagnifier } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 8. Canvas --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Whiteboard / Draw Canvas (PPDrawCanvas)&lt;/h3&gt;
      &lt;p&gt;An interactive drawing pad with color picking and erasing.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPDrawCanvas /&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPDrawCanvas :width="600" :height="400" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPDrawCanvas } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 9. Splitter --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Resizable Splitter (PPSplitter)&lt;/h3&gt;
      &lt;p&gt;A drag-and-drop resizable split pane.&lt;/p&gt;
      &lt;div class="demo-box" style="height: 300px;"&gt;
        &lt;PPSplitter direction="horizontal" :initialSplit="50"&gt;
          &lt;template #primary&gt;
            &lt;div style="padding: 20px; background: #e0f2fe; height: 100%;"&gt;Left Pane&lt;/div&gt;
          &lt;/template&gt;
          &lt;template #secondary&gt;
            &lt;div style="padding: 20px; background: #fce7f3; height: 100%;"&gt;Right Pane&lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSplitter&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSplitter direction="horizontal" :initialSplit="50"&amp;gt;
    &amp;lt;template #primary&amp;gt;
      &amp;lt;div&amp;gt;Left Pane&amp;lt;/div&amp;gt;
    &amp;lt;/template&amp;gt;
    &amp;lt;template #secondary&amp;gt;
      &amp;lt;div&amp;gt;Right Pane&amp;lt;/div&amp;gt;
    &amp;lt;/template&amp;gt;
  &amp;lt;/PPSplitter&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPSplitter } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 6. Masonry Grid --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Masonry Grid Layout (PPMasonry)&lt;/h3&gt;
      &lt;p&gt;A Pinterest-style staggered grid layout.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPMasonry :columns="3" :gap="16"&gt;
          &lt;div v-for="i in 9" :key="i" class="masonry-item" :style="{ height: `${Math.floor(Math.random() * 150) + 100}px` }"&gt;
            Item {{ i }}
          &lt;/div&gt;
        &lt;/PPMasonry&gt;
      &lt;/div&gt;
      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPMasonry :columns="3" :gap="16"&amp;gt;
    &amp;lt;div v-for="item in items" :key="item.id"&amp;gt;
      {{ item.content }}
    &amp;lt;/div&amp;gt;
  &amp;lt;/PPMasonry&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPMasonry } from '@phanna/ui-framework';
const items = [...];
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 10. Camera Capture --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Camera Capture (PPCameraCapture)&lt;/h3&gt;
      &lt;p&gt;A camera viewer that captures photos using the device camera.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPCameraCapture height="400" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 11. Audio Recorder --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Audio Recorder (PPAudioRecorder)&lt;/h3&gt;
      &lt;p&gt;An interactive microphone recorder that outputs audio blobs.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPAudioRecorder /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 12. Map Viewer --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Map Viewer (PPMapViewer)&lt;/h3&gt;
      &lt;p&gt;A map interface that renders dynamic markers.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPMapViewer :markers="[{ top: '50%', left: '50%', label: 'Current Location' }]" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 13. Video Player --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Video Player (PPVideoPlayer)&lt;/h3&gt;
      &lt;p&gt;A custom styled video player with timeline and speed controls.&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPVideoPlayer src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- 14. Confetti --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Confetti (PPConfetti)&lt;/h3&gt;
      &lt;p&gt;A celebratory micro-interaction component.&lt;/p&gt;
      &lt;div class="demo-box" style="display: flex; align-items: center; justify-content: center; padding: 40px;"&gt;
        &lt;button 
          @click="showConfetti = true" 
          style="padding: 12px 24px; background: #3b82f6; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;"
        &gt;
          Celebrate!
        &lt;/button&gt;
        &lt;PPConfetti v-model:active="showConfetti" /&gt;
      &lt;/div&gt;
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
import { 
  PPCreditCard, 
  PPTagInput, 
  PPPasswordStrength, 
  PPAudioWave, 
  PPQRCode, 
  PPMasonry, 
  PPMagnifier, 
  PPDrawCanvas,
  PPSplitter,
  PPCameraCapture,
  PPAudioRecorder,
  PPMapViewer,
  PPVideoPlayer,
  PPConfetti
} from '@phanna/ui-framework';

const tags = ref(['Vue', 'TypeScript']);
const password = ref('');
const qrText = ref('https://github.com');
const showConfetti = ref(false);
&lt;/script&gt;

&lt;style scoped&gt;
.masonry-item {
  background: #3b82f6;
  color: white;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { 
  PPCreditCard, 
  PPTagInput, 
  PPPasswordStrength, 
  PPAudioWave, 
  PPQRCode, 
  PPMasonry, 
  PPMagnifier, 
  PPDrawCanvas,
  PPSplitter,
  PPCameraCapture,
  PPAudioRecorder,
  PPMapViewer,
  PPVideoPlayer,
  PPConfetti
} from '@phanna/ui-framework';

const tags = ref(['Vue', 'TypeScript']);
const password = ref('');
const qrText = ref('https://github.com');
const showConfetti = ref(false);
</script>

<style scoped>
.masonry-item {
  background: #3b82f6;
  color: white;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}
</style>
