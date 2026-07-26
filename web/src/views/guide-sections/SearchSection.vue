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
      <pre class="code-block"><code>&lt;template&gt;
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
  </div>
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
