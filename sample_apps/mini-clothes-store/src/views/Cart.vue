<template>
  <div class="p-4 flex flex-col min-h-[calc(100vh-140px)]">
    <h1 class="text-2xl font-bold mb-6">Your Cart</h1>

    <div v-if="cartStore.items.length === 0" class="flex-1 flex flex-col items-center justify-center text-gray-500 space-y-4">
      <span class="text-6xl">🛍️</span>
      <p>Your cart is empty.</p>
      <PPButton variant="outline" @click="$router.push('/')">Continue Shopping</PPButton>
    </div>

    <div v-else class="flex-1 space-y-4">
      <div v-for="item in cartStore.items" :key="item.id" class="flex gap-4 p-3 bg-white rounded-xl shadow-sm border border-gray-100">
        <div class="w-20 h-24 bg-gray-100 rounded-lg overflow-hidden flex-shrink-0">
          <img :src="item.image" :alt="item.name" class="w-full h-full object-cover" />
        </div>
        <div class="flex-1 flex flex-col justify-between py-1">
          <div>
            <h3 class="font-semibold line-clamp-1">{{ item.name }}</h3>
            <p class="text-gray-500 text-sm">${{ item.price.toFixed(2) }}</p>
          </div>
          <div class="flex justify-between items-center mt-2">
            <div class="flex items-center gap-3 bg-gray-100 rounded-full px-2 py-1">
              <button class="w-6 h-6 flex items-center justify-center font-bold text-gray-600" @click="cartStore.updateQuantity(item.id, item.quantity - 1)">-</button>
              <span class="text-sm font-semibold min-w-[20px] text-center">{{ item.quantity }}</span>
              <button class="w-6 h-6 flex items-center justify-center font-bold text-gray-600" @click="cartStore.updateQuantity(item.id, item.quantity + 1)">+</button>
            </div>
            <p class="font-bold">${{ (item.price * item.quantity).toFixed(2) }}</p>
          </div>
        </div>
      </div>
      
      <div class="pt-6 mt-6 border-t border-gray-200">
          <div class="flex justify-between text-gray-500 mb-2">
              <span>Subtotal</span>
              <span>${{ cartStore.total.toFixed(2) }}</span>
          </div>
          <div class="flex justify-between text-gray-500 mb-2">
              <span>Shipping</span>
              <span>$5.00</span>
          </div>
          <div class="flex justify-between font-bold text-lg mt-4 pt-4 border-t">
              <span>Total</span>
              <span>${{ (cartStore.total + 5).toFixed(2) }}</span>
          </div>
      </div>
    </div>

    <div class="mt-6 pt-4 bg-gray-50 sticky bottom-20 z-10" v-if="cartStore.items.length > 0">
      <PPButton class="w-full py-4 text-lg font-bold shadow-lg" @click="$router.push('/checkout')">
        Proceed to Checkout
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPButton } from '@phanna/ui-framework'
import { cartStore } from '../stores/cart'
</script>
