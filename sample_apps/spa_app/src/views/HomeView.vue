<template>
  <div class="home">
    <PPCollapsingToolbar :expandedHeight="250" :collapsedHeight="88">
      <template #background>
        <img src="https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=800&q=80" alt="Spa" class="hero-img" />
      </template>
      <template #start>
        <button class="icon-btn" @click="() => handleExit()" aria-label="Exit App"><ion-icon name="close-outline"></ion-icon></button>
      </template>
      <template #end>
        <button class="icon-btn" @click="$router.push('/search')"><ion-icon name="search-outline"></ion-icon></button>
      </template>

      <div class="content-sheet">
      <div class="spa-info">
        <div class="logo">
          <span>AS</span>
        </div>
        <div class="details">
          <h2>Anantara Spa</h2>
          <p v-if="userName">Welcome, {{ userName }}</p>
          <p v-else>Beauty & Wellness</p>
        </div>
        <ion-icon name="information-circle-outline" class="info-icon"></ion-icon>
      </div>
      <p class="description">
        Step into the world of Anantara Spa in Siem Reap.
        Experience authentic local wellness with an inspired journey through Khmer healing traditions.
        Explore Khmer massages drawn from centuries.
      </p>

      <h3 class="section-title">Our offerings</h3>
      <div class="tabs">
        <div 
          class="tab" 
          :class="{ active: selectedCategory === 'ALL' }" 
          @click="selectedCategory = 'ALL'"
        >ALL</div>
        <div 
          class="tab" 
          :class="{ active: selectedCategory === 'BODY MASSAGE' }" 
          @click="selectedCategory = 'BODY MASSAGE'"
        >BODY MASSAGE</div>
        <div 
          class="tab" 
          :class="{ active: selectedCategory === 'FACIAL TREATMENT' }" 
          @click="selectedCategory = 'FACIAL TREATMENT'"
        >FACIAL TREATMENT</div>
        <div 
          class="tab" 
          :class="{ active: selectedCategory === 'WELLNESS' }" 
          @click="selectedCategory = 'WELLNESS'"
        >WELLNESS</div>
      </div>

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
    </PPCollapsingToolbar>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { services } from '../data/mockData'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp

const selectedCategory = ref('ALL')
const userName = ref('')
const userPhone = ref('')

const handleExit = (showConfirm = true) => {
  MiniApp.exit(typeof showConfirm === 'boolean' ? showConfirm : true)
}

const filteredServices = computed(() => {
  if (selectedCategory.value === 'ALL') {
    return services
  }
  return services.filter(s => s.category === selectedCategory.value)
})

onMounted(async () => {
  try {
    const profile = await MiniApp.getUserProfile({ appKey: 'SPA_MINIAPP_CLIENT_KEY' })
    if (profile && profile.name) {
      userName.value = profile.name
    }
    if (profile && profile.phoneNumber) {
      userPhone.value = profile.phoneNumber
    }
  } catch (err: any) {
    console.error('Failed to get user profile:', err)
  }
})
</script>

<style scoped>
.home {
  height: 100vh;
  background-color: #f7f7f7;
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
}

.spa-info {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
}

.logo {
  width: 48px;
  height: 48px;
  border-radius: 24px;
  background: #f0f0f0;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
}

.details h2 {
  font-size: 20px;
  margin: 0;
}
.details p {
  color: #666;
  margin: 0;
  font-size: 14px;
}

.info-icon {
  margin-left: auto;
  font-size: 24px;
  color: #999;
}

.description {
  color: #444;
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 24px;
}

.section-title {
  font-size: 18px;
  margin-bottom: 16px;
}

.tabs {
  display: flex;
  gap: 16px;
  overflow-x: auto;
  margin-bottom: 24px;
  border-bottom: 1px solid #eee;
}

.tab {
  font-size: 13px;
  font-weight: 500;
  color: #666;
  padding-bottom: 8px;
  white-space: nowrap;
  cursor: pointer;
}

.tab.active {
  color: #000;
  border-bottom: 2px solid #a38d7c;
}

.services-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.service-card {
  cursor: pointer;
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
