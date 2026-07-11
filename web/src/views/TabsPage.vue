<template>
	<ion-page>
		<ion-tabs>
			<ion-router-outlet></ion-router-outlet>
			<liquid-glass-tab-bar slot="bottom" />
		</ion-tabs>
	</ion-page>
</template>

<script setup lang="ts">
import { BizMOBApp } from '@bizmob/core';
import { IonTabs, IonPage, IonRouterOutlet } from '@ionic/vue';
import LiquidGlassTabBar from '@/components/LiquidGlassTabBar.vue';

BizMOBApp.hideSplash();

</script>

<style scoped>
/* Any tab page specific styling */
</style>
