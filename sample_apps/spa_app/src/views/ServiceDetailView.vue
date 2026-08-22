<template>
  <div class="detail-view">
    <PPCollapsingToolbar :expandedHeight="300" :collapsedHeight="88" v-if="service">
      <template #background>
        <img :src="service.imageUrl" alt="Service" class="hero-img" />
      </template>
      <template #start>
        <button class="icon-btn" @click="$router.back()"><ion-icon name="chevron-back-outline"></ion-icon></button>
      </template>
      <template #end>
        <button class="icon-btn action-btn"><ion-icon name="arrow-redo-outline"></ion-icon></button>
      </template>
    
      <div class="content-sheet">
      <h2 class="title">{{ service.title }}</h2>
      <div class="price-row">
        <span class="price">${{ service.price.toFixed(2) }}</span>
        <span class="original-price">${{ service.originalPrice.toFixed(2) }}</span>
        <span class="discount-badge">{{ service.discount }}</span>
      </div>
      
      <p class="description">
        {{ service.description }}
      </p>

      <div class="form-group">
        <label>Choose duration <span class="required">*</span></label>
        <div class="radio-option">
          <span>{{ service.duration }}</span>
          <input type="radio" checked />
        </div>
      </div>

      <div class="form-group row-group">
        <label>Quantity</label>
        <div class="quantity-selector">
          <button @click="quantity > 1 && quantity--"><ion-icon name="remove-outline"></ion-icon></button>
          <span>{{ quantity }}</span>
          <button @click="quantity++"><ion-icon name="add-outline"></ion-icon></button>
        </div>
      </div>

        <button class="primary-btn" @click="$router.push(`/service/${service.id}/datetime`)">Continue</button>
      </div>
    </PPCollapsingToolbar>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { services } from '../data/mockData'

const route = useRoute()
const service = computed(() => services.find(s => s.id === route.params.id))
const quantity = ref(1)
</script>

<style scoped>
.detail-view {
  background-color: #f7f7f7;
  height: 100vh;
}
.icon-btn {
  background: rgba(0,0,0,0.4);
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 20px;
  cursor: pointer;
}
.content-sheet {
  background: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  margin-top: -24px;
  padding: 24px;
  flex: 1;
  z-index: 1;
  position: relative;
  display: flex;
  flex-direction: column;
}
.title {
  font-size: 22px;
  margin-bottom: 8px;
}
.price-row {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}
.price {
  color: #ff1493;
  font-weight: bold;
  font-size: 18px;
}
.original-price {
  text-decoration: line-through;
  color: #999;
}
.discount-badge {
  background: #ff1493;
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: bold;
}
.description {
  color: #444;
  line-height: 1.5;
  margin-bottom: 32px;
}
.form-group {
  margin-bottom: 24px;
}
.form-group label {
  display: block;
  font-weight: 600;
  margin-bottom: 12px;
}
.required {
  color: #ff1493;
}
.radio-option {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #eee;
  padding: 16px;
  border-radius: 12px;
}
.radio-option input[type="radio"] {
  width: 20px;
  height: 20px;
  accent-color: #a38d7c;
}
.row-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}
.row-group label {
  margin-bottom: 0;
}
.quantity-selector {
  display: flex;
  align-items: center;
  gap: 16px;
}
.quantity-selector button {
  background: #f0f0f0;
  border: none;
  width: 32px;
  height: 32px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  color: #a38d7c;
  cursor: pointer;
}
.primary-btn {
  background: #b5a092;
  color: white;
  border: none;
  padding: 16px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: bold;
  width: 100%;
  cursor: pointer;
  margin-top: auto;
}
</style>
