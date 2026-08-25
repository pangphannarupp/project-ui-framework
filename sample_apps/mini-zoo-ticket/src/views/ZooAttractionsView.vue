<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import ZooHeader from '../components/ZooHeader.vue';
import { ZOO_ZONES, ANIMAL_LIST, DAILY_SHOWS } from '../data/animals';

const router = useRouter()
const selectedZoneFilter = ref('ALL');
const searchQuery = ref('');

const filteredAnimals = () => {
  return ANIMAL_LIST.filter(a => {
    const matchesZone = selectedZoneFilter.value === 'ALL' || a.zoneId === selectedZoneFilter.value;
    const matchesSearch = a.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          a.species.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          a.origin.toLowerCase().includes(searchQuery.value.toLowerCase());
    return matchesZone && matchesSearch;
  });
};
</script>

<template>
  <div class="attractions-page">
    <ZooHeader />

    <!-- Header Banner -->
    <div class="attractions-banner">
      <div class="max-container banner-content">
        <span class="banner-tag">PARK GUIDE & DISCOVERY</span>
        <h1 class="banner-title">Park Zones, Wildlife & Shows</h1>
        <p class="banner-sub">Explore all animal habitats, daily feeding times, and show amphitheaters.</p>
      </div>
    </div>

    <div class="max-container main-content">
      <!-- Park Map & Highlights -->
      <section class="guide-section">
        <div class="section-title-row">
          <div>
            <span class="sub-label">FACILITIES & STOPS</span>
            <h2 class="section-heading">Interactive Safari Map</h2>
          </div>
          <button class="btn-book-float" @click="router.push('/book')">
            🎟️ Buy Admission Tickets
          </button>
        </div>

        <div class="park-map-visual">
          <div class="map-interactive-layer">
            <div class="map-stop stop-entrance">
              <span class="stop-icon">🚪</span>
              <span class="stop-tag">Main Gate</span>
            </div>
            <div class="map-stop stop-savanna">
              <span class="stop-icon">🦁</span>
              <span class="stop-tag">Savanna Plains</span>
            </div>
            <div class="map-stop stop-rainforest">
              <span class="stop-icon">🐯</span>
              <span class="stop-tag">Rainforest</span>
            </div>
            <div class="map-stop stop-aviary">
              <span class="stop-icon">🦜</span>
              <span class="stop-tag">Bird Aviary</span>
            </div>
            <div class="map-stop stop-aqua">
              <span class="stop-icon">🐧</span>
              <span class="stop-tag">Penguin Cove</span>
            </div>
            <div class="map-stop stop-tram">
              <span class="stop-icon">🚋</span>
              <span class="stop-tag">Safari Tram</span>
            </div>
            <div class="map-stop stop-cafe">
              <span class="stop-icon">☕</span>
              <span class="stop-tag">Savanna Cafe</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Daily Shows & Timetable -->
      <section class="guide-section">
        <div class="section-title-row">
          <div>
            <span class="sub-label">SCHEDULE</span>
            <h2 class="section-heading">Live Performances & Presentations</h2>
          </div>
        </div>

        <div class="shows-full-grid">
          <div v-for="show in DAILY_SHOWS" :key="show.id" class="show-full-card">
            <div class="show-badge-icon">{{ show.icon }}</div>
            <div class="show-details-col">
              <div class="show-meta">
                <span class="badge-time">⏰ {{ show.time }}</span>
                <span class="badge-duration">⏱️ {{ show.duration }}</span>
              </div>
              <h3 class="show-name">{{ show.title }}</h3>
              <span class="show-venue">📍 {{ show.location }}</span>
              <p class="show-text">{{ show.description }}</p>
            </div>
          </div>
        </div>
      </section>

      <!-- Wildlife Directory -->
      <section class="guide-section">
        <div class="section-title-row">
          <div>
            <span class="sub-label">ANIMAL ENCYCLOPEDIA</span>
            <h2 class="section-heading">Resident Animals ({{ ANIMAL_LIST.length }} Featured)</h2>
          </div>
        </div>

        <!-- Filter and Search Bar -->
        <div class="filter-search-bar">
          <div class="search-input-wrap">
            <span class="search-icon">🔍</span>
            <input 
              type="text" 
              v-model="searchQuery" 
              placeholder="Search animal by name, diet, or country..." 
              class="search-field"
            />
          </div>

          <div class="zone-pills-row">
            <button 
              class="zone-filter-pill" 
              :class="{ active: selectedZoneFilter === 'ALL' }"
              @click="selectedZoneFilter = 'ALL'"
            >
              All Zones
            </button>
            <button 
              v-for="z in ZOO_ZONES" 
              :key="z.id" 
              class="zone-filter-pill"
              :class="{ active: selectedZoneFilter === z.id }"
              @click="selectedZoneFilter = z.id"
            >
              {{ z.icon }} {{ z.name.split(' ')[0] }}
            </button>
          </div>
        </div>

        <!-- Animal Cards Grid -->
        <div class="animal-cards-grid">
          <div v-for="animal in filteredAnimals()" :key="animal.id" class="animal-card">
            <div class="card-avatar-circle">
              <span>{{ animal.avatar }}</span>
            </div>
            
            <div class="animal-card-body">
              <div class="card-status-pill" :class="animal.status.toLowerCase().replace(/\s+/g, '-')">
                {{ animal.status }}
              </div>
              <h3 class="animal-card-name">{{ animal.name }}</h3>
              <span class="animal-latin">{{ animal.scientificName }}</span>

              <div class="animal-meta-tags">
                <span class="meta-pill">🌍 {{ animal.origin }}</span>
                <span class="meta-pill">🥗 {{ animal.diet }}</span>
              </div>

              <div class="animal-funfact">
                <strong>💡 Fun Fact:</strong> {{ animal.funFact }}
              </div>

              <div class="animal-feeding-foot">
                <span class="feed-clock">🕒 Feeding & Talk:</span>
                <span class="feed-time">{{ animal.feedingTime }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<style scoped>
.attractions-page {
  min-height: 100vh;
  background-color: #f8fafc;
  padding-bottom: 5rem;
}

.max-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1.25rem;
}

.attractions-banner {
  background: linear-gradient(135deg, #064e3b 0%, #047857 60%, #0f172a 100%);
  color: white;
  padding: 2.5rem 0;
  margin-bottom: 2rem;
}

.banner-tag {
  font-size: 0.75rem;
  font-weight: 800;
  color: #34d399;
  letter-spacing: 0.1em;
  display: block;
}

.banner-title {
  font-size: 2.2rem;
  font-weight: 900;
  margin-bottom: 0.4rem;
}

.banner-sub {
  font-size: 0.95rem;
  color: #cbd5e1;
}

.main-content {
  display: flex;
  flex-direction: column;
  gap: 3.5rem;
}

.section-title-row {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-bottom: 1.5rem;
  gap: 1rem;
  flex-wrap: wrap;
}

.sub-label {
  font-size: 0.75rem;
  font-weight: 800;
  color: #059669;
  letter-spacing: 0.1em;
  display: block;
}

.section-heading {
  font-size: 1.6rem;
  font-weight: 800;
  color: #0f172a;
}

.btn-book-float {
  background: #10b981;
  color: white;
  border: none;
  font-weight: 700;
  padding: 0.65rem 1.25rem;
  border-radius: 12px;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* Map visual */
.park-map-visual {
  background: linear-gradient(135deg, #dcfce7 0%, #d1fae5 50%, #fef3c7 100%);
  border: 2px dashed #86efac;
  border-radius: 24px;
  min-height: 280px;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
}

.map-interactive-layer {
  position: relative;
  width: 100%;
  height: 280px;
}

.map-stop {
  position: absolute;
  background: #ffffff;
  padding: 6px 12px;
  border-radius: 999px;
  border: 1.5px solid #cbd5e1;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.825rem;
  font-weight: 700;
  color: #0f172a;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  transition: transform 0.2s ease;
}

.map-stop:hover {
  transform: scale(1.1);
  border-color: #10b981;
}

.stop-entrance { top: 75%; left: 10%; }
.stop-savanna { top: 25%; left: 25%; }
.stop-rainforest { top: 20%; left: 65%; }
.stop-aviary { top: 60%; left: 70%; }
.stop-aqua { top: 65%; left: 42%; }
.stop-tram { top: 45%; left: 12%; }
.stop-cafe { top: 40%; left: 45%; }

/* Shows list */
.shows-full-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 1.5rem;
}

.show-full-card {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 20px;
  padding: 1.5rem;
  display: flex;
  gap: 1.25rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
}

.show-badge-icon {
  width: 54px;
  height: 54px;
  border-radius: 16px;
  background: #ecfdf5;
  border: 1px solid #a7f3d0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  flex-shrink: 0;
}

.show-details-col {
  display: flex;
  flex-direction: column;
}

.show-meta {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.4rem;
}

.badge-time, .badge-duration {
  font-size: 0.725rem;
  font-weight: 700;
  color: #047857;
  background: #f0fdf4;
  padding: 2px 6px;
  border-radius: 6px;
}

.show-name {
  font-size: 1.05rem;
  font-weight: 800;
  color: #0f172a;
  margin-bottom: 2px;
}

.show-venue {
  font-size: 0.8rem;
  color: #64748b;
  font-weight: 600;
  margin-bottom: 6px;
}

.show-text {
  font-size: 0.85rem;
  color: #475569;
  line-height: 1.4;
}

/* Wildlife Directory */
.filter-search-bar {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 2rem;
}

.search-input-wrap {
  position: relative;
  display: flex;
  align-items: center;
}

.search-icon {
  position: absolute;
  left: 14px;
  font-size: 1.1rem;
}

.search-field {
  width: 100%;
  padding: 0.8rem 1rem 0.8rem 2.75rem;
  border-radius: 14px;
  border: 1.5px solid #cbd5e1;
  font-size: 0.95rem;
  font-family: inherit;
  outline: none;
  background: #ffffff;
}

.search-field:focus {
  border-color: #10b981;
}

.zone-pills-row {
  display: flex;
  gap: 0.5rem;
  overflow-x: auto;
  padding-bottom: 4px;
}

.zone-filter-pill {
  background: #ffffff;
  border: 1px solid #cbd5e1;
  padding: 0.5rem 1rem;
  border-radius: 999px;
  font-size: 0.85rem;
  font-weight: 700;
  color: #475569;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.15s ease;
}

.zone-filter-pill.active {
  background: #059669;
  color: white;
  border-color: #059669;
}

.animal-cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}

.animal-card {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 20px;
  padding: 1.5rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
  display: flex;
  flex-direction: column;
}

.card-avatar-circle {
  width: 56px;
  height: 56px;
  border-radius: 16px;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  margin-bottom: 1rem;
}

.card-status-pill {
  font-size: 0.7rem;
  font-weight: 800;
  width: fit-content;
  padding: 2px 8px;
  border-radius: 6px;
  margin-bottom: 6px;
}

.card-status-pill.least-concern { background: #dcfce7; color: #166534; }
.card-status-pill.vulnerable { background: #fef3c7; color: #92400e; }
.card-status-pill.endangered { background: #fee2e2; color: #991b1b; }

.animal-card-name {
  font-size: 1.15rem;
  font-weight: 800;
  color: #0f172a;
}

.animal-latin {
  font-size: 0.8rem;
  color: #64748b;
  font-style: italic;
  margin-bottom: 0.75rem;
  display: block;
}

.animal-meta-tags {
  display: flex;
  gap: 0.4rem;
  flex-wrap: wrap;
  margin-bottom: 1rem;
}

.meta-pill {
  background: #f1f5f9;
  padding: 3px 8px;
  border-radius: 6px;
  font-size: 0.75rem;
  color: #334155;
  font-weight: 600;
}

.animal-funfact {
  background: #f8fafc;
  padding: 0.75rem;
  border-radius: 10px;
  font-size: 0.8rem;
  color: #475569;
  line-height: 1.4;
  margin-bottom: 1rem;
  flex-grow: 1;
}

.animal-feeding-foot {
  border-top: 1px solid #f1f5f9;
  padding-top: 0.75rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 0.8rem;
}

.feed-clock {
  color: #64748b;
  font-weight: 600;
}

.feed-time {
  color: #059669;
  font-weight: 700;
}
</style>
