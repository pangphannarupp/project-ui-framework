<template>
  <div class="p-4 pb-24">
    <div class="flex items-center gap-3 mb-6">
      <PPIconButton icon="chevron-back-outline" variant="ghost" @click="$router.back()" />
      <h1 class="text-2xl font-bold">Checkout</h1>
    </div>

    <div class="space-y-6">
      <section>
        <h2 class="text-lg font-bold mb-4">Shipping Address</h2>
        <div class="space-y-4">
          <PPTextField label="Full Name" placeholder="John Doe" />
          <PPTextField label="Address" placeholder="123 Main St" />
          <div class="grid grid-cols-2 gap-4">
            <PPTextField label="City" placeholder="New York" />
            <PPTextField label="Zip Code" placeholder="10001" />
          </div>
        </div>
      </section>

      <section>
        <h2 class="text-lg font-bold mb-4">Payment Method</h2>
        <div class="space-y-3">
          <label class="flex items-center justify-between p-4 border rounded-xl cursor-pointer hover:bg-gray-50 border-black bg-gray-50">
            <div class="flex items-center gap-3">
              <span class="text-2xl">💳</span>
              <span class="font-medium">Credit Card</span>
            </div>
            <input type="radio" name="payment" checked class="w-5 h-5 accent-black" />
          </label>
          <label class="flex items-center justify-between p-4 border rounded-xl cursor-pointer hover:bg-gray-50">
            <div class="flex items-center gap-3">
              <span class="text-2xl">📱</span>
              <span class="font-medium">Apple Pay</span>
            </div>
            <input type="radio" name="payment" class="w-5 h-5 accent-black" />
          </label>
        </div>
      </section>
      
      <section v-if="cartStore.items.length > 0">
        <h2 class="text-lg font-bold mb-4">Order Summary</h2>
        <div class="space-y-2">
            <div v-for="item in cartStore.items" :key="item.id" class="flex justify-between text-sm">
                <span>{{ item.quantity }}x {{ item.name }}</span>
                <span>${{ (item.price * item.quantity).toFixed(2) }}</span>
            </div>
        </div>
      </section>
    </div>

    <div class="fixed bottom-0 w-full max-w-md mx-auto left-0 right-0 bg-white border-t p-4 z-30">
      <div class="flex justify-between items-center mb-4">
        <span class="text-gray-500 font-medium">Total to Pay</span>
        <span class="text-xl font-bold">${{ (cartStore.total + 5).toFixed(2) }}</span>
      </div>
      <PPButton class="w-full py-4 text-lg font-bold" @click="$router.push('/payment')">
        Place Order
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPTextField, PPButton, PPIconButton } from '@phanna/ui-framework'
import { cartStore } from '../stores/cart'
</script>
