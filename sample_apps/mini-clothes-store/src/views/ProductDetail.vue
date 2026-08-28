<template>
  <div class="pb-20" v-if="product">
    <div class="relative w-full aspect-[4/5] bg-gray-100">
      <PPIconButton 
        icon="chevron-back-outline" 
        variant="ghost" 
        class="absolute top-4 left-4 z-10 bg-white/50 backdrop-blur-md rounded-full"
        @click="$router.back()"
      />
      <img :src="product.image" :alt="product.name" class="w-full h-full object-cover" />
    </div>

    <div class="p-4 space-y-4">
      <div class="flex justify-between items-start">
        <div>
          <h1 class="text-2xl font-bold">{{ product.name }}</h1>
          <p class="text-gray-500">{{ product.category }}</p>
        </div>
        <p class="text-2xl font-bold">${{ product.price.toFixed(2) }}</p>
      </div>

      <div class="space-y-2">
        <h3 class="font-semibold text-lg">Description</h3>
        <p class="text-gray-600 leading-relaxed">{{ product.description }}</p>
      </div>
      
      <!-- Size selector mock -->
      <div class="space-y-2 pt-4">
        <div class="flex justify-between">
            <h3 class="font-semibold">Size</h3>
            <span class="text-sm text-gray-500 underline">Size Guide</span>
        </div>
        <div class="flex gap-2">
            <button 
                v-for="size in ['S', 'M', 'L', 'XL']" 
                :key="size"
                class="w-12 h-12 rounded-full border border-gray-300 flex items-center justify-center font-medium hover:border-black hover:bg-black hover:text-white transition-colors"
            >
                {{ size }}
            </button>
        </div>
      </div>
    </div>

    <!-- Fixed Add to Cart Bottom Bar -->
    <div class="fixed bottom-0 w-full max-w-md mx-auto left-0 right-0 bg-white border-t p-4 z-30">
      <PPButton class="w-full py-4 text-lg font-bold" @click="handleAddToCart">
        Add to Cart
      </PPButton>
    </div>
    
    <!-- Success Toast Mock -->
    <div v-if="showToast" class="fixed top-20 left-1/2 -translate-x-1/2 bg-black text-white px-4 py-2 rounded-full shadow-lg z-50 flex items-center gap-2 animate-bounce">
      <span>✅</span> Added to cart
    </div>
  </div>
  <div v-else class="p-8 text-center">
    Product not found.
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { PPButton, PPIconButton } from '@phanna/ui-framework'
import { cartStore, type Product } from '../stores/cart'

const route = useRoute()
const showToast = ref(false)

const product = computed<Product | undefined>(() => {
  const products = (window as any).mockProducts as Product[] || []
  return products.find(p => p.id === route.params.id)
})

const handleAddToCart = () => {
  if (product.value) {
    cartStore.addToCart(product.value)
    showToast.value = true
    setTimeout(() => { showToast.value = false }, 2000)
  }
}
</script>
