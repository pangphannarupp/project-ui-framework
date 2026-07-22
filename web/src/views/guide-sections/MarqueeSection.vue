<template>
  <div class="component-section">
    <h2>Marquee</h2>
    <p>An infinitely scrolling marquee component for showcasing testimonials, logos, or news items seamlessly.</p>

    <!-- Basic Text Marquee -->
    <div class="demo-box">
      <h3>Basic Text Marquee</h3>
      <p class="helper-text">Hover to pause the scrolling.</p>
      <div class="demo-content">
        <PPMarquee duration="20s" style="background: #1976d2; color: white; padding: 12px; font-weight: 500; border-radius: 4px;">
          <span style="margin-right: 48px;">🚀 New Version 2.0 Released!</span>
          <span style="margin-right: 48px;">✨ Brand new components added</span>
          <span style="margin-right: 48px;">🐞 Bug fixes and performance improvements</span>
          <span style="margin-right: 48px;">🎉 Join our community discord</span>
        </PPMarquee>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPMarquee duration="20s"&gt;
  &lt;span style="margin-right: 48px;"&gt;🚀 New Version 2.0 Released!&lt;/span&gt;
  &lt;span style="margin-right: 48px;"&gt;✨ Brand new components added&lt;/span&gt;
&lt;/PPMarquee&gt;</code></pre>
    </div>

    <!-- Partner Logos Marquee with Fade -->
    <div class="demo-box">
      <h3>Partner Logos with Edge Fade</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;">
          <label><input type="checkbox" v-model="reverseDir"> Reverse Direction (Right)</label>
        </div>
        <PPMarquee 
          :fade="true" 
          :direction="reverseDir ? 'right' : 'left'"
          duration="25s"
        >
          <div 
            v-for="logo in logos" 
            :key="logo.id" 
            class="logo-card"
          >
            {{ logo.icon }} {{ logo.name }}
          </div>
        </PPMarquee>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPMarquee :fade="true" direction="right" duration="25s"&gt;
  &lt;div v-for="logo in logos" :key="logo.id" class="logo-card"&gt;
    {{ logo.icon }} {{ logo.name }}
  &lt;/div&gt;
&lt;/PPMarquee&gt;</code></pre>
    </div>

    <!-- Vertical Marquee -->
    <div class="demo-box">
      <h3>Vertical Marquee</h3>
      <div class="demo-content">
        <div style="height: 300px; border: 1px solid #e0e0e0; border-radius: 8px; background: #fafafa; padding: 16px 0;">
          <PPMarquee :vertical="true" :fade="true" direction="up" duration="15s">
            <div 
              v-for="user in users" 
              :key="user.id" 
              class="user-card"
            >
              <div class="avatar">{{ user.avatar }}</div>
              <div>
                <div style="font-weight: 600; font-size: 14px; color: #333;">{{ user.name }}</div>
                <div style="font-size: 12px; color: #666;">{{ user.role }}</div>
              </div>
            </div>
          </PPMarquee>
        </div>
      </div>
      <pre class="code-block" v-pre><code>&lt;div style="height: 300px;"&gt;
  &lt;PPMarquee :vertical="true" :fade="true" direction="up" duration="15s"&gt;
    &lt;div v-for="user in users" :key="user.id" class="user-card"&gt;
      &lt;!-- Content --&gt;
    &lt;/div&gt;
  &lt;/PPMarquee&gt;
&lt;/div&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPMarquee } from '@phanna/ui-framework';

const reverseDir = ref(false);

const logos = ref([
  { id: 1, name: 'Acme Corp', icon: '🏢' },
  { id: 2, name: 'Global Tech', icon: '🌍' },
  { id: 3, name: 'Innovate AI', icon: '🤖' },
  { id: 4, name: 'CloudSync', icon: '☁️' },
  { id: 5, name: 'FastPay', icon: '💳' },
  { id: 6, name: 'SecureNet', icon: '🛡️' }
]);

const users = ref([
  { id: 1, name: 'Alice Smith', role: 'Software Engineer', avatar: '👩‍💻' },
  { id: 2, name: 'Bob Johnson', role: 'Product Manager', avatar: '👨‍💼' },
  { id: 3, name: 'Charlie Davis', role: 'UX Designer', avatar: '🎨' },
  { id: 4, name: 'Diana Prince', role: 'Data Scientist', avatar: '📊' },
  { id: 5, name: 'Ethan Hunt', role: 'Security Ops', avatar: '🕵️' }
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

.logo-card {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 24px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-right: 24px;
  font-weight: 600;
  color: #444;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  min-width: 150px;
}

.user-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 16px;
  margin-left: 24px;
  margin-right: 24px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.avatar {
  font-size: 24px;
  background: #f0f0f0;
  border-radius: 50%;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
