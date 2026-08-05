<template>
  <div class="component-section">
    <h2>Carousel</h2>
    <p>A highly performant touch-friendly slider component using native CSS scroll snapping. Supports autoplay, pagination, multi-item views, and multiple variants (standard, story, reel).</p>

    <!-- Standard Image Carousel -->
    <div class="demo-box">
      <h3>Standard Image Carousel</h3>
      <p class="helper-text">1 item per view, dots, arrows, and looping enabled.</p>
      <div class="demo-content">
        <PPCarousel variant="standard" :loop="true" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
          <PPCarouselItem v-for="i in 5" :key="i">
            <div class="slide-image-placeholder" :style="{ background: `hsl(${i * 60}, 70%, 50%)` }">
              <h2>Slide {{ i }}</h2>
            </div>
          </PPCarouselItem>
        </PPCarousel>
      </div>
      <pre class="code-block" v-pre><code>&lt;!-- variant can be 'standard' (default), 'story', or 'reel' --&gt;
&lt;PPCarousel variant="standard" :loop="true"&gt;
  &lt;PPCarouselItem v-for="i in 5" :key="i"&gt;
    &lt;!-- Your content here --&gt;
  &lt;/PPCarouselItem&gt;
&lt;/PPCarousel&gt;</code></pre>
    </div>

    <!-- Autoplay Cards Carousel -->
    <div class="demo-box">
      <h3>Multi-Item Autoplay Slider</h3>
      <p class="helper-text">3 items per view with a 2000ms autoplay interval. (Pauses on hover)</p>
      <div class="demo-content">
        <PPCarousel :itemsPerView="3" :autoplay="true" :interval="2000" gap="16px" :showDots="false">
          <PPCarouselItem v-for="item in cards" :key="item.id">
            <div class="product-card">
              <div class="product-image">{{ item.icon }}</div>
              <div class="product-details">
                <h4>{{ item.title }}</h4>
                <p>{{ item.desc }}</p>
              </div>
            </div>
          </PPCarouselItem>
        </PPCarousel>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPCarousel 
  :itemsPerView="3" 
  :autoplay="true" 
  :interval="2000" 
  gap="16px"
&gt;
  &lt;PPCarouselItem v-for="item in cards" :key="item.id"&gt;
    &lt;div class="product-card"&gt;...&lt;/div&gt;
  &lt;/PPCarouselItem&gt;
&lt;/PPCarousel&gt;</code></pre>
    </div>

    <!-- Story Carousel -->
    <div class="demo-box">
      <h3>Story Carousel</h3>
      <p class="helper-text">Instagram-style story carousel with progress bars.</p>
      <div class="demo-content">
        <PPCarousel variant="story" :autoplay="true" :interval="3000" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 300px; height: 500px; margin: 0 auto;">
          <PPCarouselItem v-for="i in 3" :key="`story-${i}`">
            <div class="slide-image-placeholder full-height" :style="{ background: `hsl(${i * 80 + 100}, 70%, 50%)` }">
              <h2>Story {{ i }}</h2>
            </div>
          </PPCarouselItem>
        </PPCarousel>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPCarousel variant="story" :autoplay="true" :interval="3000"&gt;
  &lt;PPCarouselItem v-for="i in 3" :key="i"&gt;
    &lt;!-- Story content here --&gt;
  &lt;/PPCarouselItem&gt;
&lt;/PPCarousel&gt;</code></pre>
    </div>

    <!-- Reel Carousel -->
    <div class="demo-box">
      <h3>Reel Carousel</h3>
      <p class="helper-text">TikTok-style vertical scrolling reel.</p>
      <div class="demo-content">
        <PPCarousel variant="reel" :showDots="false" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 300px; height: 500px; margin: 0 auto;">
          <PPCarouselItem v-for="i in 4" :key="`reel-${i}`">
            <div class="slide-image-placeholder full-height" :style="{ background: `hsl(${i * 40 + 200}, 70%, 50%)` }">
              <div>
                <h2>Reel {{ i }}</h2>
                <p style="font-size: 14px; opacity: 0.8">Swipe up or down</p>
              </div>
            </div>
          </PPCarouselItem>
        </PPCarousel>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPCarousel variant="reel" :showDots="false"&gt;
  &lt;PPCarouselItem v-for="i in 4" :key="i"&gt;
    &lt;!-- Reel content here --&gt;
  &lt;/PPCarouselItem&gt;
&lt;/PPCarousel&gt;</code></pre>
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
    &lt;h2&gt;Carousel&lt;/h2&gt;
    &lt;p&gt;A highly performant touch-friendly slider component using native CSS scroll snapping. Supports autoplay, pagination, multi-item views, and multiple variants (standard, story, reel).&lt;/p&gt;

    &lt;!-- Standard Image Carousel --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Standard Image Carousel&lt;/h3&gt;
      &lt;p class="helper-text"&gt;1 item per view, dots, arrows, and looping enabled.&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPCarousel variant="standard" :loop="true" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);"&gt;
          &lt;PPCarouselItem v-for="i in 5" :key="i"&gt;
            &lt;div class="slide-image-placeholder" :style="{ background: `hsl(${i * 60}, 70%, 50%)` }"&gt;
              &lt;h2&gt;Slide {{ i }}&lt;/h2&gt;
            &lt;/div&gt;
          &lt;/PPCarouselItem&gt;
        &lt;/PPCarousel&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;!-- variant can be 'standard' (default), 'story', or 'reel' --&amp;gt;
&amp;lt;PPCarousel variant="standard" :loop="true"&amp;gt;
  &amp;lt;PPCarouselItem v-for="i in 5" :key="i"&amp;gt;
    &amp;lt;!-- Your content here --&amp;gt;
  &amp;lt;/PPCarouselItem&amp;gt;
&amp;lt;/PPCarousel&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Autoplay Cards Carousel --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Multi-Item Autoplay Slider&lt;/h3&gt;
      &lt;p class="helper-text"&gt;3 items per view with a 2000ms autoplay interval. (Pauses on hover)&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPCarousel :itemsPerView="3" :autoplay="true" :interval="2000" gap="16px" :showDots="false"&gt;
          &lt;PPCarouselItem v-for="item in cards" :key="item.id"&gt;
            &lt;div class="product-card"&gt;
              &lt;div class="product-image"&gt;{{ item.icon }}&lt;/div&gt;
              &lt;div class="product-details"&gt;
                &lt;h4&gt;{{ item.title }}&lt;/h4&gt;
                &lt;p&gt;{{ item.desc }}&lt;/p&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/PPCarouselItem&gt;
        &lt;/PPCarousel&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPCarousel 
  :itemsPerView="3" 
  :autoplay="true" 
  :interval="2000" 
  gap="16px"
&amp;gt;
  &amp;lt;PPCarouselItem v-for="item in cards" :key="item.id"&amp;gt;
    &amp;lt;div class="product-card"&amp;gt;...&amp;lt;/div&amp;gt;
  &amp;lt;/PPCarouselItem&amp;gt;
&amp;lt;/PPCarousel&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Story Carousel --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Story Carousel&lt;/h3&gt;
      &lt;p class="helper-text"&gt;Instagram-style story carousel with progress bars.&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPCarousel variant="story" :autoplay="true" :interval="3000" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 300px; height: 500px; margin: 0 auto;"&gt;
          &lt;PPCarouselItem v-for="i in 3" :key="`story-${i}`"&gt;
            &lt;div class="slide-image-placeholder full-height" :style="{ background: `hsl(${i * 80 + 100}, 70%, 50%)` }"&gt;
              &lt;h2&gt;Story {{ i }}&lt;/h2&gt;
            &lt;/div&gt;
          &lt;/PPCarouselItem&gt;
        &lt;/PPCarousel&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPCarousel variant="story" :autoplay="true" :interval="3000"&amp;gt;
  &amp;lt;PPCarouselItem v-for="i in 3" :key="i"&amp;gt;
    &amp;lt;!-- Story content here --&amp;gt;
  &amp;lt;/PPCarouselItem&amp;gt;
&amp;lt;/PPCarousel&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Reel Carousel --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Reel Carousel&lt;/h3&gt;
      &lt;p class="helper-text"&gt;TikTok-style vertical scrolling reel.&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPCarousel variant="reel" :showDots="false" style="border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 300px; height: 500px; margin: 0 auto;"&gt;
          &lt;PPCarouselItem v-for="i in 4" :key="`reel-${i}`"&gt;
            &lt;div class="slide-image-placeholder full-height" :style="{ background: `hsl(${i * 40 + 200}, 70%, 50%)` }"&gt;
              &lt;div&gt;
                &lt;h2&gt;Reel {{ i }}&lt;/h2&gt;
                &lt;p style="font-size: 14px; opacity: 0.8"&gt;Swipe up or down&lt;/p&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/PPCarouselItem&gt;
        &lt;/PPCarousel&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPCarousel variant="reel" :showDots="false"&amp;gt;
  &amp;lt;PPCarouselItem v-for="i in 4" :key="i"&amp;gt;
    &amp;lt;!-- Reel content here --&amp;gt;
  &amp;lt;/PPCarouselItem&amp;gt;
&amp;lt;/PPCarousel&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPCarousel, PPCarouselItem } from '@phanna/ui-framework';

const cards = ref([
  { id: 1, title: 'Analytics', desc: 'View your data instantly', icon: '📊' },
  { id: 2, title: 'Cloud Sync', desc: 'Secure reliable storage', icon: '☁️' },
  { id: 3, title: 'Security', desc: 'Enterprise-grade protection', icon: '🔒' },
  { id: 4, title: 'Fast Pay', desc: 'Zero transaction fees', icon: '💸' },
  { id: 5, title: 'Mobile App', desc: 'Available on iOS/Android', icon: '📱' },
  { id: 6, title: 'Support', desc: '24/7 dedicated assistance', icon: '📞' }
]);
&lt;/script&gt;

&lt;style scoped&gt;
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
}

.slide-image-placeholder {
  width: 100%;
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 24px;
  text-shadow: 0 2px 4px rgba(0,0,0,0.3);
  text-align: center;
}

.slide-image-placeholder.full-height {
  height: 100%;
}

.product-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  text-align: center;
  height: 100%;
  display: flex;
  flex-direction: column;
  transition: transform 0.2s, box-shadow 0.2s;
  cursor: pointer;
}
.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0,0,0,0.06);
}
.product-image {
  font-size: 48px;
  margin-bottom: 16px;
}
.product-details h4 {
  margin: 0 0 8px 0;
  font-size: 16px;
  color: #333;
}
.product-details p {
  margin: 0;
  font-size: 13px;
  color: #666;
  line-height: 1.4;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPCarousel, PPCarouselItem } from '@phanna/ui-framework';

const cards = ref([
  { id: 1, title: 'Analytics', desc: 'View your data instantly', icon: '📊' },
  { id: 2, title: 'Cloud Sync', desc: 'Secure reliable storage', icon: '☁️' },
  { id: 3, title: 'Security', desc: 'Enterprise-grade protection', icon: '🔒' },
  { id: 4, title: 'Fast Pay', desc: 'Zero transaction fees', icon: '💸' },
  { id: 5, title: 'Mobile App', desc: 'Available on iOS/Android', icon: '📱' },
  { id: 6, title: 'Support', desc: '24/7 dedicated assistance', icon: '📞' }
]);
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
}

.slide-image-placeholder {
  width: 100%;
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 24px;
  text-shadow: 0 2px 4px rgba(0,0,0,0.3);
  text-align: center;
}

.slide-image-placeholder.full-height {
  height: 100%;
}

.product-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  text-align: center;
  height: 100%;
  display: flex;
  flex-direction: column;
  transition: transform 0.2s, box-shadow 0.2s;
  cursor: pointer;
}
.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0,0,0,0.06);
}
.product-image {
  font-size: 48px;
  margin-bottom: 16px;
}
.product-details h4 {
  margin: 0 0 8px 0;
  font-size: 16px;
  color: #333;
}
.product-details p {
  margin: 0;
  font-size: 13px;
  color: #666;
  line-height: 1.4;
}
</style>
