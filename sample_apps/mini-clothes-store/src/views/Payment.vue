<template>
  <div class="min-h-screen flex flex-col items-center justify-center p-6 text-center bg-gray-50">
    <div v-if="processing" class="space-y-6">
      <div class="w-20 h-20 border-4 border-gray-200 border-t-black rounded-full animate-spin mx-auto"></div>
      <h2 class="text-xl font-bold">Processing Payment...</h2>
      <p class="text-gray-500">Please wait while we confirm your order.</p>
    </div>

    <div v-else class="space-y-6 max-w-sm">
      <div class="w-24 h-24 bg-green-100 text-green-500 rounded-full flex items-center justify-center text-4xl mx-auto mb-6">
        ✓
      </div>
      <h1 class="text-3xl font-bold tracking-tight">Payment Successful!</h1>
      <p class="text-gray-600">Your order has been placed successfully. You will receive an email confirmation shortly.</p>
      
      <div class="bg-white p-4 rounded-xl border border-gray-100 text-left mt-8 mb-8">
        <p class="text-sm text-gray-500 mb-1">Order Number</p>
        <p class="font-bold font-mono">#ORD-{{ Math.floor(Math.random() * 1000000) }}</p>
      </div>

      <PPButton class="w-full py-4 text-lg font-bold" @click="handleDone">
        Back to Home
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { cartStore } from '../stores/cart'

const router = useRouter()
const processing = ref(true)

onMounted(() => {
  setTimeout(() => {
    processing.value = false
    cartStore.clearCart() // clear cart after successful payment
  }, 2000)
})

const handleDone = () => {
  router.push('/')
}
</script>
