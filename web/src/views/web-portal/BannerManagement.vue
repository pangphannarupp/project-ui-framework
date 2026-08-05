<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Homepage Banners</h1>
            <p class="page-subtitle">Manage the featured images shown on the customer app homepage.</p>
          </div>
          <div class="header-right">
            <PPButton variant="primary">Add Banner</PPButton>
          </div>
        </div>

        <div class="content-grid">
          <!-- Live Preview -->
          <div class="preview-column">
            <h2 class="section-title">Live Preview</h2>
            <div class="preview-container">
              <PPCarousel :autoplay="true" :interval="3000">
                <PPCarouselItem v-for="banner in banners" :key="banner.id">
                  <div class="banner-preview" :style="{ backgroundImage: `url(${banner.image})` }">
                    <div class="banner-content" v-if="banner.title">
                      <h3>{{ banner.title }}</h3>
                    </div>
                  </div>
                </PPCarouselItem>
              </PPCarousel>
            </div>
          </div>

          <!-- Banner List -->
          <div class="list-column">
            <h2 class="section-title">Active Banners</h2>
            <div class="banner-list">
              <div v-for="banner in banners" :key="banner.id" class="banner-card">
                <img :src="banner.image" class="banner-thumbnail" />
                <div class="banner-details">
                  <h4>{{ banner.title || 'Untitled Banner' }}</h4>
                  <p>Link: {{ banner.link || 'None' }}</p>
                </div>
                <div class="banner-actions">
                  <PPButton variant="ghost" size="small">Edit</PPButton>
                  <PPButton variant="ghost" size="small" color="danger">Remove</PPButton>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonContent } from '@ionic/vue';
import { PPButton, PPCarousel, PPCarouselItem } from '@phanna/ui-framework';

const banners = ref([
  { id: 1, title: 'Summer Sale', image: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?q=80&w=2070&auto=format&fit=crop', link: '/category/summer' },
  { id: 2, title: 'New Arrivals', image: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=2070&auto=format&fit=crop', link: '/category/new' },
  { id: 3, title: '', image: 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?q=80&w=2070&auto=format&fit=crop', link: '' }
]);
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.page-container {
  padding: 40px;
  width: 100%;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #334155;
  margin: 0 0 16px 0;
}

.content-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 32px;
}

.preview-container {
  background: white;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.banner-preview {
  height: 300px;
  width: 100%;
  background-size: cover;
  background-position: center;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.banner-content {
  background: rgba(0,0,0,0.5);
  padding: 16px 32px;
  border-radius: 8px;
}

.banner-content h3 {
  color: white;
  margin: 0;
  font-size: 24px;
}

.banner-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.banner-card {
  display: flex;
  align-items: center;
  background: white;
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  border: 1px solid #e2e8f0;
  gap: 16px;
}

.banner-thumbnail {
  width: 120px;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
}

.banner-details {
  flex: 1;
}

.banner-details h4 {
  margin: 0 0 4px 0;
  font-size: 16px;
  color: #1e293b;
}

.banner-details p {
  margin: 0;
  font-size: 13px;
  color: #64748b;
}

.banner-actions {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

@media (max-width: 1024px) {
  .content-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .header-section {
    flex-direction: column;
    gap: 16px;
  }
  .page-container {
    padding: 20px;
  }
}
</style>
