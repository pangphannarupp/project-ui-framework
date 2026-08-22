<template>
  <div class="search-view">
    <div class="header">
      <button class="icon-btn" @click="$router.back()"><ion-icon name="chevron-back-outline"></ion-icon></button>
      <div class="search-input">
        <input type="text" placeholder="Search service name" autofocus v-model="searchQuery" />
      </div>
    </div>
    
    <div class="content">
      <h3 class="section-title">Our offerings</h3>
      <div class="services-grid">
        <div class="service-card" v-for="service in filteredServices" :key="service.id" @click="$router.push('/service/' + service.id)">
          <div class="image-wrapper">
            <img :src="service.imageUrl" :alt="service.title" />
            <div class="discount-badge">{{ service.discount }}</div>
          </div>
          <h4>{{ service.title }}</h4>
          <p class="duration">{{ service.duration }}</p>
          <div class="price-row">
            <span class="price" v-if="service.title.includes('From')">From ${{ service.price.toFixed(2) }}</span>
            <span class="price" v-else>${{ service.price.toFixed(2) }}</span>
            <span class="original-price">${{ service.originalPrice.toFixed(2) }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { services } from '../data/mockData'

const searchQuery = ref('')

const filteredServices = computed(() => {
  if (!searchQuery.value) return services
  const query = searchQuery.value.toLowerCase()
  return services.filter(s => s.title.toLowerCase().includes(query))
})
</script>

<style scoped>
.search-view {
  background: white;
  min-height: 100vh;
}
.header {
  display: flex;
  align-items: center;
  padding: 16px;
  gap: 16px;
}
.icon-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
}
.search-input {
  flex: 1;
  background: #f0f0f0;
  border-radius: 20px;
  padding: 8px 16px;
}
.search-input input {
  width: 100%;
  border: none;
  background: transparent;
  outline: none;
  font-size: 16px;
}
.content {
  padding: 16px;
}
.section-title {
  margin-bottom: 16px;
}
.services-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}
.image-wrapper {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 8px;
  aspect-ratio: 4/3;
}
.image-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.discount-badge {
  position: absolute;
  bottom: 8px;
  left: 8px;
  background: #ff1493;
  color: white;
  padding: 4px 8px;
  border-radius: 8px;
  font-size: 10px;
  font-weight: bold;
}
.service-card h4 {
  font-size: 14px;
  margin: 0 0 4px 0;
  font-weight: 600;
}
.duration {
  font-size: 12px;
  color: #999;
  margin: 0 0 4px 0;
}
.price-row {
  display: flex;
  align-items: center;
  gap: 8px;
}
.price {
  color: #ff1493;
  font-weight: 600;
  font-size: 14px;
}
.original-price {
  text-decoration: line-through;
  color: #999;
  font-size: 12px;
}
</style>
