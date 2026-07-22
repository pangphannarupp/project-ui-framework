<template>
  <div class="guide-section">
    <h2>Action Sheets</h2>
    <p>A collection of specific action sheets used across the application.</p>

    <h3>Country Code Sheet</h3>
    <div class="demo-box">
      <ion-button @click="isCountryOpen = true">Select Country</ion-button>
      <PPCountryCodeSheet
        :is-open="isCountryOpen"
        @did-dismiss="isCountryOpen = false"
        @select="onCountrySelect"
      />
    </div>

    <h3>Language Sheet</h3>
    <div class="demo-box">
      <ion-button @click="isLanguageOpen = true">Select Language</ion-button>
      <PPLanguageSheet
        :is-open="isLanguageOpen"
        @did-dismiss="isLanguageOpen = false"
        @select="onLanguageSelect"
      />
    </div>

    <h3>Sort Sheet</h3>
    <div class="demo-box">
      <ion-button @click="isSortOpen = true">Sort Options</ion-button>
      <PPSortSheet
        :is-open="isSortOpen"
        @did-dismiss="isSortOpen = false"
        @select="onSortSelect"
      />
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonButton } from '@ionic/vue';
import { PPCountryCodeSheet, PPLanguageSheet, PPSortSheet } from '@phanna/ui-framework';

const isCountryOpen = ref(false);
const isLanguageOpen = ref(false);
const isSortOpen = ref(false);

const onCountrySelect = (code: any) => console.log('Country:', code);
const onLanguageSelect = (lang: any) => console.log('Language:', lang);
const onSortSelect = (sort: any) => console.log('Sort:', sort);
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
