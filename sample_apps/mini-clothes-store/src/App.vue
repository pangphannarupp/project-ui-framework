<template>
  <div class="min-h-screen bg-gray-50 text-gray-900 pb-20">
    <header class="bg-white shadow-sm sticky top-0 z-10 p-4 flex justify-between items-center">
      <h1 class="text-xl font-bold tracking-tight">StyleStore</h1>
      <div class="flex gap-2">
        <PPIconButton
          icon="cart-outline"
          variant="ghost"
          @click="$router.push('/cart')"
        />
      </div>
    </header>

    <main class="max-w-md mx-auto">
      <router-view />
    </main>

    <!-- Bottom Navigation -->
    <nav class="fixed bottom-0 w-full bg-white border-t flex justify-around p-3 pb-6 max-w-md mx-auto left-0 right-0 z-20">
      <button 
        class="flex flex-col items-center flex-1 text-gray-500 hover:text-black transition-colors"
        :class="{ 'text-black font-semibold': $route.path === '/' }"
        @click="$router.push('/')"
      >
        <span class="text-xl mb-1">🏠</span>
        <span class="text-xs">Home</span>
      </button>
      <button 
        class="flex flex-col items-center flex-1 text-gray-500 hover:text-black transition-colors"
        :class="{ 'text-black font-semibold': $route.path === '/cart' }"
        @click="$router.push('/cart')"
      >
        <span class="text-xl mb-1">🛒</span>
        <span class="text-xs">Cart</span>
      </button>
      <button 
        class="flex flex-col items-center flex-1 text-gray-500 hover:text-black transition-colors"
      >
        <span class="text-xl mb-1">👤</span>
        <span class="text-xs">Profile</span>
      </button>
    </nav>
  </div>
</template>

<script setup lang="ts">
import { PPIconButton } from '@phanna/ui-framework'
</script>
