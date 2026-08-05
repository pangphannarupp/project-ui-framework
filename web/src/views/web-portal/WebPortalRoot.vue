<template>
  <ion-page>
    <WebPortalLayout>
      <ion-router-outlet :animated="false" />
    </WebPortalLayout>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonRouterOutlet } from '@ionic/vue';
import WebPortalLayout from '@/components/web-portal/WebPortalLayout.vue';
</script>
