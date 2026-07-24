<template>
  <nav class="pp-breadcrumb" aria-label="breadcrumb">
    <ol class="breadcrumb-list">
      <li 
        v-for="(item, index) in items" 
        :key="index"
        class="breadcrumb-item"
        :class="{ 'is-active': index === items.length - 1 }"
      >
        <span v-if="index > 0" class="breadcrumb-separator">
          <slot name="separator">
            <ion-icon v-if="separatorIcon" :icon="separatorIcon" />
            <span v-else>{{ separator }}</span>
          </slot>
        </span>
        
        <a 
          v-if="item.href && index !== items.length - 1" 
          :href="item.href" 
          class="breadcrumb-link"
          @click.prevent="handleClick(item, index)"
        >
          <ion-icon v-if="item.icon" :icon="item.icon" class="item-icon" />
          {{ item.label }}
        </a>
        <span v-else class="breadcrumb-text">
          <ion-icon v-if="item.icon" :icon="item.icon" class="item-icon" />
          {{ item.label }}
        </span>
      </li>
    </ol>
  </nav>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';

export interface BreadcrumbItem {
  label: string;
  href?: string;
  icon?: any;
}

withDefaults(defineProps<{
  items: BreadcrumbItem[];
  separator?: string;
  separatorIcon?: any;
}>(), {
  separator: '/'
});

const emit = defineEmits(['click']);

const handleClick = (item: BreadcrumbItem, index: number) => {
  emit('click', { item, index });
};
</script>

<style scoped>
.pp-breadcrumb {
  display: flex;
  font-size: 14px;
}

.breadcrumb-list {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  list-style: none;
  padding: 0;
  margin: 0;
}

.breadcrumb-item {
  display: flex;
  align-items: center;
}

.breadcrumb-separator {
  margin: 0 8px;
  color: #94a3b8;
  display: flex;
  align-items: center;
  font-size: 0.9em;
}

.breadcrumb-link {
  color: #64748b;
  text-decoration: none;
  display: flex;
  align-items: center;
  transition: color 0.2s ease;
  cursor: pointer;
}

.breadcrumb-link:hover {
  color: #3b82f6;
}

.breadcrumb-text {
  color: #1e293b;
  font-weight: 500;
  display: flex;
  align-items: center;
}

.item-icon {
  margin-right: 4px;
  font-size: 1.1em;
}
</style>
