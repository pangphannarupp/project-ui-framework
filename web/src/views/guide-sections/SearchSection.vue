<template>
  <div class="component-section">
    <h2>Search Component</h2>
    <p>A comprehensive search component that supports real-time results and search history.</p>

    <div class="demo-grid" style="display: flex; gap: 24px; flex-wrap: wrap;">
      
      <!-- Basic Search -->
      <div class="demo-box" style="flex: 1; min-width: 300px;">
        <h3>Search with History</h3>
        <p style="font-size: 14px; color: #666; margin-bottom: 16px;">Try typing "vue" or focusing to see history.</p>
        <PPSearch
          v-model="query1"
          :results="filteredResults1"
          :history="searchHistory"
          @search="handleSearch1"
          @clear-history="clearHistory"
          @remove-history-item="removeHistoryItem"
        />
        
        <div v-if="lastSearch1" style="margin-top: 16px; font-size: 14px; color: #003399;">
          Last searched: <strong>{{ lastSearch1 }}</strong>
        </div>
      </div>

      <!-- Loading State -->
      <div class="demo-box" style="flex: 1; min-width: 300px;">
        <h3>Simulated API Search</h3>
        <p style="font-size: 14px; color: #666; margin-bottom: 16px;">Types something to trigger loading state.</p>
        <PPSearch
          v-model="query2"
          :results="filteredResults2"
          :loading="isLoading"
          placeholder="Search users..."
          @search="handleSearch2"
        >
          <!-- Custom Result Template -->
          <template #result="{ item }">
            <div style="display: flex; align-items: center; gap: 12px; width: 100%;">
              <div style="width: 32px; height: 32px; background: #e2e8f0; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; color: #64748b;">
                {{ item.label.charAt(0) }}
              </div>
              <div style="display: flex; flex-direction: column;">
                <span style="font-size: 15px; color: #1e293b;">{{ item.label }}</span>
                <span style="font-size: 12px; color: #94a3b8;">{{ item.role }}</span>
              </div>
            </div>
          </template>
        </PPSearch>
      </div>


      <!-- Basic Filter Search (No History) -->
      <div class="demo-box" style="flex: 1; min-width: 300px;">
        <h3>Filter List</h3>
        <p style="font-size: 14px; color: #666; margin-bottom: 16px;">Search with results but no history state.</p>
        <PPSearch
          v-model="query3"
          :results="filteredResults3"
          placeholder="Filter framework..."
          @search="handleSearch3"
        />
        <div style="margin-top: 16px; font-size: 14px; color: #003399;" v-if="lastSearch3">
          Selected: <strong>{{ lastSearch3 }}</strong>
        </div>
      </div>

      <!-- Simple Search Input (No Dropdown) -->
      <div class="demo-box" style="flex: 1; min-width: 300px;">
        <h3>Simple Search Input</h3>
        <p style="font-size: 14px; color: #666; margin-bottom: 16px;">Just the styled input, no dropdown menu.</p>
        <PPSearch
          v-model="query4"
          placeholder="Type to search..."
          @search="handleSearch4"
        />
        <div style="margin-top: 16px; font-size: 14px; color: #003399;" v-if="query4">
          Current query: <strong>{{ query4 }}</strong>
        </div>
      </div>

    </div>

    <!-- Code Example -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPSearch
    v-model="query"
    :results="searchResults"
    :history="searchHistory"
    @search="onSearch"
    @clear-history="onClearHistory"
  /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPSearch } from '@phanna/ui-framework';

const query = ref('');
const searchHistory = ref(['React', 'Vue', 'Angular']);
const searchResults = ref([
  { label: 'Vue 3 Framework', id: 1 },
  { label: 'React Native', id: 2 }
]);

const onSearch = (item) => {
  const term = typeof item === 'object' ? item.label : item;
  if (!searchHistory.value.includes(term)) {
    searchHistory.value.unshift(term);
  }
};

const onClearHistory = () => {
  searchHistory.value = [];
};
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
    &lt;h2&gt;Search Component&lt;/h2&gt;
    &lt;p&gt;A comprehensive search component that supports real-time results and search history.&lt;/p&gt;

    &lt;div class="demo-grid" style="display: flex; gap: 24px; flex-wrap: wrap;"&gt;
      
      &lt;!-- Basic Search --&gt;
      &lt;div class="demo-box" style="flex: 1; min-width: 300px;"&gt;
        &lt;h3&gt;Search with History&lt;/h3&gt;
        &lt;p style="font-size: 14px; color: #666; margin-bottom: 16px;"&gt;Try typing "vue" or focusing to see history.&lt;/p&gt;
        &lt;PPSearch
          v-model="query1"
          :results="filteredResults1"
          :history="searchHistory"
          @search="handleSearch1"
          @clear-history="clearHistory"
          @remove-history-item="removeHistoryItem"
        /&gt;
        
        &lt;div v-if="lastSearch1" style="margin-top: 16px; font-size: 14px; color: #003399;"&gt;
          Last searched: &lt;strong&gt;{{ lastSearch1 }}&lt;/strong&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;!-- Loading State --&gt;
      &lt;div class="demo-box" style="flex: 1; min-width: 300px;"&gt;
        &lt;h3&gt;Simulated API Search&lt;/h3&gt;
        &lt;p style="font-size: 14px; color: #666; margin-bottom: 16px;"&gt;Types something to trigger loading state.&lt;/p&gt;
        &lt;PPSearch
          v-model="query2"
          :results="filteredResults2"
          :loading="isLoading"
          placeholder="Search users..."
          @search="handleSearch2"
        &gt;
          &lt;!-- Custom Result Template --&gt;
          &lt;template #result="{ item }"&gt;
            &lt;div style="display: flex; align-items: center; gap: 12px; width: 100%;"&gt;
              &lt;div style="width: 32px; height: 32px; background: #e2e8f0; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; color: #64748b;"&gt;
                {{ item.label.charAt(0) }}
              &lt;/div&gt;
              &lt;div style="display: flex; flex-direction: column;"&gt;
                &lt;span style="font-size: 15px; color: #1e293b;"&gt;{{ item.label }}&lt;/span&gt;
                &lt;span style="font-size: 12px; color: #94a3b8;"&gt;{{ item.role }}&lt;/span&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPSearch&gt;
      &lt;/div&gt;


      &lt;!-- Basic Filter Search (No History) --&gt;
      &lt;div class="demo-box" style="flex: 1; min-width: 300px;"&gt;
        &lt;h3&gt;Filter List&lt;/h3&gt;
        &lt;p style="font-size: 14px; color: #666; margin-bottom: 16px;"&gt;Search with results but no history state.&lt;/p&gt;
        &lt;PPSearch
          v-model="query3"
          :results="filteredResults3"
          placeholder="Filter framework..."
          @search="handleSearch3"
        /&gt;
        &lt;div style="margin-top: 16px; font-size: 14px; color: #003399;" v-if="lastSearch3"&gt;
          Selected: &lt;strong&gt;{{ lastSearch3 }}&lt;/strong&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;!-- Simple Search Input (No Dropdown) --&gt;
      &lt;div class="demo-box" style="flex: 1; min-width: 300px;"&gt;
        &lt;h3&gt;Simple Search Input&lt;/h3&gt;
        &lt;p style="font-size: 14px; color: #666; margin-bottom: 16px;"&gt;Just the styled input, no dropdown menu.&lt;/p&gt;
        &lt;PPSearch
          v-model="query4"
          placeholder="Type to search..."
          @search="handleSearch4"
        /&gt;
        &lt;div style="margin-top: 16px; font-size: 14px; color: #003399;" v-if="query4"&gt;
          Current query: &lt;strong&gt;{{ query4 }}&lt;/strong&gt;
        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;

    &lt;!-- Code Example --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSearch
    v-model="query"
    :results="searchResults"
    :history="searchHistory"
    @search="onSearch"
    @clear-history="onClearHistory"
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPSearch } from '@phanna/ui-framework';

const query = ref('');
const searchHistory = ref(['React', 'Vue', 'Angular']);
const searchResults = ref([
  { label: 'Vue 3 Framework', id: 1 },
  { label: 'React Native', id: 2 }
]);

const onSearch = (item) =&gt; {
  const term = typeof item === 'object' ? item.label : item;
  if (!searchHistory.value.includes(term)) {
    searchHistory.value.unshift(term);
  }
};

const onClearHistory = () =&gt; {
  searchHistory.value = [];
};
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
import { ref, computed, watch } from 'vue';
import { PPSearch } from '@phanna/ui-framework';

// Demo 1 State
const query1 = ref('');
const lastSearch1 = ref('');
const searchHistory = ref(['Vue Components', 'Ionic Framework', 'Vite Plugin']);
const allResults = [
  'Vue Components',
  'Vue Router',
  'Vuex',
  'Pinia',
  'Vite',
  'Vitest',
  'Ionic Framework',
  'Capacitor',
];

const filteredResults1 = computed(() =&gt; {
  if (!query1.value) return [];
  const q = query1.value.toLowerCase();
  return allResults.filter(r =&gt; r.toLowerCase().includes(q));
});

const handleSearch1 = (item: any) =&gt; {
  const term = typeof item === 'object' ? item.label : item;
  lastSearch1.value = term;
  
  if (!searchHistory.value.includes(term)) {
    searchHistory.value.unshift(term);
    if (searchHistory.value.length &gt; 5) searchHistory.value.pop();
  }
};

const clearHistory = () =&gt; {
  searchHistory.value = [];
};

const removeHistoryItem = ({ index }: { index: number }) =&gt; {
  searchHistory.value.splice(index, 1);
};

// Demo 2 State
const query2 = ref('');
const isLoading = ref(false);
const filteredResults2 = ref&lt;any[]&gt;([]);

const users = [
  { label: 'Alice Smith', role: 'Admin', id: 1 },
  { label: 'Bob Johnson', role: 'Editor', id: 2 },
  { label: 'Charlie Brown', role: 'Viewer', id: 3 },
  { label: 'Diana Prince', role: 'Admin', id: 4 },
];

let timeoutId: any;
watch(query2, (newVal) =&gt; {
  if (timeoutId) clearTimeout(timeoutId);
  if (!newVal) {
    filteredResults2.value = [];
    isLoading.value = false;
    return;
  }
  
  isLoading.value = true;
  timeoutId = setTimeout(() =&gt; {
    const q = newVal.toLowerCase();
    filteredResults2.value = users.filter(u =&gt; u.label.toLowerCase().includes(q) || u.role.toLowerCase().includes(q));
    isLoading.value = false;
  }, 800);
});

const handleSearch2 = (item: any) =&gt; {
  console.log('Selected user:', item);
};

// Demo 3 State
const query3 = ref('');
const lastSearch3 = ref('');
const filteredResults3 = computed(() =&gt; {
  if (!query3.value) return [];
  const q = query3.value.toLowerCase();
  return ['Vue', 'React', 'Angular', 'Svelte', 'SolidJS', 'AlpineJS'].filter(r =&gt; r.toLowerCase().includes(q));
});
const handleSearch3 = (item: any) =&gt; {
  lastSearch3.value = item;
};

// Demo 4 State
const query4 = ref('');
const handleSearch4 = (val: string) =&gt; {
  console.log('Search triggered with:', val);
};
&lt;/script&gt;

&lt;style scoped&gt;
.demo-box {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 24px;
}
.code-block {
  background: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';
import { PPSearch } from '@phanna/ui-framework';

// Demo 1 State
const query1 = ref('');
const lastSearch1 = ref('');
const searchHistory = ref(['Vue Components', 'Ionic Framework', 'Vite Plugin']);
const allResults = [
  'Vue Components',
  'Vue Router',
  'Vuex',
  'Pinia',
  'Vite',
  'Vitest',
  'Ionic Framework',
  'Capacitor',
];

const filteredResults1 = computed(() => {
  if (!query1.value) return [];
  const q = query1.value.toLowerCase();
  return allResults.filter(r => r.toLowerCase().includes(q));
});

const handleSearch1 = (item: any) => {
  const term = typeof item === 'object' ? item.label : item;
  lastSearch1.value = term;
  
  if (!searchHistory.value.includes(term)) {
    searchHistory.value.unshift(term);
    if (searchHistory.value.length > 5) searchHistory.value.pop();
  }
};

const clearHistory = () => {
  searchHistory.value = [];
};

const removeHistoryItem = ({ index }: { index: number }) => {
  searchHistory.value.splice(index, 1);
};

// Demo 2 State
const query2 = ref('');
const isLoading = ref(false);
const filteredResults2 = ref<any[]>([]);

const users = [
  { label: 'Alice Smith', role: 'Admin', id: 1 },
  { label: 'Bob Johnson', role: 'Editor', id: 2 },
  { label: 'Charlie Brown', role: 'Viewer', id: 3 },
  { label: 'Diana Prince', role: 'Admin', id: 4 },
];

let timeoutId: any;
watch(query2, (newVal) => {
  if (timeoutId) clearTimeout(timeoutId);
  if (!newVal) {
    filteredResults2.value = [];
    isLoading.value = false;
    return;
  }
  
  isLoading.value = true;
  timeoutId = setTimeout(() => {
    const q = newVal.toLowerCase();
    filteredResults2.value = users.filter(u => u.label.toLowerCase().includes(q) || u.role.toLowerCase().includes(q));
    isLoading.value = false;
  }, 800);
});

const handleSearch2 = (item: any) => {
  console.log('Selected user:', item);
};

// Demo 3 State
const query3 = ref('');
const lastSearch3 = ref('');
const filteredResults3 = computed(() => {
  if (!query3.value) return [];
  const q = query3.value.toLowerCase();
  return ['Vue', 'React', 'Angular', 'Svelte', 'SolidJS', 'AlpineJS'].filter(r => r.toLowerCase().includes(q));
});
const handleSearch3 = (item: any) => {
  lastSearch3.value = item;
};

// Demo 4 State
const query4 = ref('');
const handleSearch4 = (val: string) => {
  console.log('Search triggered with:', val);
};
</script>

<style scoped>
.demo-box {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 24px;
}
.code-block {
  background: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
}
</style>
