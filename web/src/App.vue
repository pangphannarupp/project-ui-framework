<template>
  <ion-app>
    <ion-router-outlet />
  </ion-app>
</template>

<script setup lang="ts">
import { IonApp, IonRouterOutlet } from '@ionic/vue';
import '@bizmob-core/ui-framework/style.css';
import { BizMOBApp } from '@bizmob/core';

BizMOBApp.hideSplash();
</script>

<style scoped>
/* Global styles for the app container can go here if needed */
</style>
