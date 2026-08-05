<template>
  <div class="component-section">
    <h2>Icons Collection</h2>
    <p>A comprehensive set of SVG icons provided by Ionicons. Click any icon to copy its import name.</p>
    

    <div style="margin: 20px 0;">
      <input 
        type="text" 
        v-model="searchQuery" 
        placeholder="Search icons... (e.g., arrow, home, user)" 
        class="icon-search-input" 
      />
    </div>

    <div class="icons-grid">
      <div 
        v-for="(iconObj, iconName) in filteredIcons" 
        :key="iconName" 
        class="icon-card"
        @click="copyIconName(iconName as string)"
      >
        <ion-icon :icon="iconObj" class="icon-svg"></ion-icon>
        <div class="icon-name">{{ String(iconName) }}</div>
      </div>
    </div>
    
    <div v-if="Object.keys(filteredIcons).length === 0" class="no-results">
      No icons found matching "{{ searchQuery }}"
    </div>
    
    <div v-if="showCopiedToast" class="toast">
      Copied "{{ copiedName }}" to clipboard!
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
    &lt;h2&gt;Icons Collection&lt;/h2&gt;
    &lt;p&gt;A comprehensive set of SVG icons provided by Ionicons. Click any icon to copy its import name.&lt;/p&gt;
    

    &lt;div style="margin: 20px 0;"&gt;
      &lt;input 
        type="text" 
        v-model="searchQuery" 
        placeholder="Search icons... (e.g., arrow, home, user)" 
        class="icon-search-input" 
      /&gt;
    &lt;/div&gt;

    &lt;div class="icons-grid"&gt;
      &lt;div 
        v-for="(iconObj, iconName) in filteredIcons" 
        :key="iconName" 
        class="icon-card"
        @click="copyIconName(iconName as string)"
      &gt;
        &lt;ion-icon :icon="iconObj" class="icon-svg"&gt;&lt;/ion-icon&gt;
        &lt;div class="icon-name"&gt;{{ String(iconName) }}&lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;div v-if="Object.keys(filteredIcons).length === 0" class="no-results"&gt;
      No icons found matching "{{ searchQuery }}"
    &lt;/div&gt;
    
    &lt;div v-if="showCopiedToast" class="toast"&gt;
      Copied "{{ copiedName }}" to clipboard!
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
import { ref, computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import * as ionIcons from 'ionicons/icons';

const searchQuery = ref('');
const showCopiedToast = ref(false);
const copiedName = ref('');

// Filter icons based on search query
const filteredIcons = computed(() =&gt; {
  const query = searchQuery.value.toLowerCase();
  const result: Record&lt;string, string&gt; = {};
  
  for (const [name, icon] of Object.entries(ionIcons)) {
    if (typeof icon === 'string' &amp;&amp; name.toLowerCase().includes(query)) {
      result[name] = icon;
    }
  }
  
  return result;
});

const copyIconName = (name: string) =&gt; {
  navigator.clipboard.writeText(name);
  copiedName.value = name;
  showCopiedToast.value = true;
  
  setTimeout(() =&gt; {
    showCopiedToast.value = false;
  }, 2000);
};
&lt;/script&gt;

&lt;style scoped&gt;
.icon-search-input {
  width: 100%;
  max-width: 400px;
  padding: 12px 16px;
  border: 1px solid #cbd5e1;
  border-radius: 8px;
  font-size: 14px;
  background: white;
  color: #334155;
  outline: none;
  transition: border-color 0.2s;
}

.icon-search-input:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.icons-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
  gap: 16px;
}

.icon-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px 12px;
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.icon-card:hover {
  background: #f8fafc;
  border-color: #3b82f6;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
}

.icon-svg {
  font-size: 32px;
  color: #475569;
  margin-bottom: 12px;
  transition: color 0.2s;
}

.icon-card:hover .icon-svg {
  color: #3b82f6;
}

.icon-name {
  font-size: 11px;
  color: #64748b;
  text-align: center;
  word-break: break-word;
  line-height: 1.4;
}

.no-results {
  padding: 40px;
  text-align: center;
  color: #64748b;
  font-style: italic;
}

.toast {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: #1e293b;
  color: white;
  padding: 12px 24px;
  border-radius: 30px;
  font-size: 14px;
  font-weight: 500;
  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
  z-index: 1000;
  animation: fadeUp 0.3s ease-out forwards;
}

@keyframes fadeUp {
  from { opacity: 0; transform: translate(-50%, 20px); }
  to { opacity: 1; transform: translate(-50%, 0); }
}


&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import * as ionIcons from 'ionicons/icons';

const searchQuery = ref('');
const showCopiedToast = ref(false);
const copiedName = ref('');

// Filter icons based on search query
const filteredIcons = computed(() => {
  const query = searchQuery.value.toLowerCase();
  const result: Record<string, string> = {};
  
  for (const [name, icon] of Object.entries(ionIcons)) {
    if (typeof icon === 'string' && name.toLowerCase().includes(query)) {
      result[name] = icon;
    }
  }
  
  return result;
});

const copyIconName = (name: string) => {
  navigator.clipboard.writeText(name);
  copiedName.value = name;
  showCopiedToast.value = true;
  
  setTimeout(() => {
    showCopiedToast.value = false;
  }, 2000);
};
</script>

<style scoped>
.icon-search-input {
  width: 100%;
  max-width: 400px;
  padding: 12px 16px;
  border: 1px solid #cbd5e1;
  border-radius: 8px;
  font-size: 14px;
  background: white;
  color: #334155;
  outline: none;
  transition: border-color 0.2s;
}

.icon-search-input:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.icons-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
  gap: 16px;
}

.icon-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px 12px;
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.icon-card:hover {
  background: #f8fafc;
  border-color: #3b82f6;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1);
}

.icon-svg {
  font-size: 32px;
  color: #475569;
  margin-bottom: 12px;
  transition: color 0.2s;
}

.icon-card:hover .icon-svg {
  color: #3b82f6;
}

.icon-name {
  font-size: 11px;
  color: #64748b;
  text-align: center;
  word-break: break-word;
  line-height: 1.4;
}

.no-results {
  padding: 40px;
  text-align: center;
  color: #64748b;
  font-style: italic;
}

.toast {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: #1e293b;
  color: white;
  padding: 12px 24px;
  border-radius: 30px;
  font-size: 14px;
  font-weight: 500;
  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
  z-index: 1000;
  animation: fadeUp 0.3s ease-out forwards;
}

@keyframes fadeUp {
  from { opacity: 0; transform: translate(-50%, 20px); }
  to { opacity: 1; transform: translate(-50%, 0); }
}


</style>
