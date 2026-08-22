<template>
  <div class="datetime-view">
    <div class="hero" :style="{ backgroundImage: 'url(' + service?.imageUrl + ')' }">
      <div class="overlay"></div>
      <div class="header-actions">
        <button class="icon-btn" @click="$router.back()"><ion-icon name="chevron-back-outline"></ion-icon></button>
        <button class="icon-btn"><ion-icon name="search-outline"></ion-icon></button>
      </div>
    </div>
    
    <div class="content-sheet" v-if="service">
      <h2 class="title">Choose Date & Time</h2>
      <p class="subtitle"><ion-icon name="location-outline"></ion-icon> Anantara Spa</p>
      
      <div class="selected-services">
        <p class="section-label">Selected services</p>
        <div class="service-item">
          <img :src="service.imageUrl" alt="service" />
          <div class="service-details">
            <h4>{{ service.duration }} | {{ service.title }}</h4>
            <p>{{ service.price.toFixed(2) }} USD</p>
          </div>
          <button class="delete-btn"><ion-icon name="trash-outline"></ion-icon></button>
        </div>
        <button class="add-more-btn"><ion-icon name="add-outline"></ion-icon> Add more service</button>
      </div>

      <div class="form-group">
        <label>Select date <span class="required">*</span></label>
        <div class="horizontal-list">
          <div 
            v-for="d in dates" 
            :key="d.date"
            class="date-card" 
            :class="{ active: selectedDate === d.date }"
            @click="selectedDate = d.date"
          >
            <span class="day">{{ d.day }}</span>
            <span class="date">{{ d.date }}</span>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label>Select time <span class="required">*</span></label>
        <div class="horizontal-list">
          <div 
            v-for="t in times" 
            :key="t"
            class="time-card" 
            :class="{ active: selectedTime === t }"
            @click="selectedTime = t"
          >{{ t }}</div>
        </div>
      </div>

      <div class="policy-card">
        <h4><ion-icon name="warning-outline"></ion-icon> Cancellation policy</h4>
        <ul>
          <li><ion-icon name="calendar-outline"></ion-icon> Reschedule anytime up to 2 hours prior.</li>
          <li><ion-icon name="cash-outline"></ion-icon> Full refund if you change your mind within 1 hour.</li>
        </ul>
      </div>

      <button 
        class="primary-btn" 
        :disabled="!selectedDate || !selectedTime"
        @click="$router.push('/checkout')"
      >Confirm & Pay</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { services } from '../data/mockData'

const route = useRoute()
const service = computed(() => services.find(s => s.id === route.params.id))

const dates = [
  { day: 'Thu', date: 'Aug 13' },
  { day: 'Fri', date: 'Aug 14' },
  { day: 'Sat', date: 'Aug 15' },
  { day: 'Sun', date: 'Aug 16' },
  { day: 'Mon', date: 'Aug 17' },
]

const times = ['10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM']

const selectedDate = ref('')
const selectedTime = ref('')
</script>

<style scoped>
.datetime-view {
  background-color: #f7f7f7;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
.hero {
  position: relative;
  height: 200px;
  background-size: cover;
  background-position: center;
}
.overlay {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.3);
}
.header-actions {
  position: absolute;
  top: 40px;
  left: 20px;
  right: 20px;
  display: flex;
  justify-content: space-between;
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
  font-size: 20px;
  margin-bottom: 4px;
}
.subtitle {
  color: #666;
  display: flex;
  align-items: center;
  gap: 4px;
  margin-bottom: 24px;
  font-size: 14px;
}
.section-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 12px;
}
.selected-services {
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 24px;
}
.service-item {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}
.service-item img {
  width: 50px;
  height: 50px;
  border-radius: 8px;
  object-fit: cover;
}
.service-details h4 {
  font-size: 14px;
  margin: 0 0 4px 0;
}
.service-details p {
  margin: 0;
  font-size: 14px;
  color: #333;
}
.delete-btn {
  margin-left: auto;
  background: none;
  border: none;
  color: #ff4d4f;
  font-size: 18px;
  cursor: pointer;
}
.add-more-btn {
  background: none;
  border: none;
  color: #999;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  cursor: pointer;
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
.horizontal-list {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding-bottom: 8px;
}
.date-card, .time-card {
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 12px 16px;
  text-align: center;
  cursor: pointer;
  white-space: nowrap;
}
.date-card {
  display: flex;
  flex-direction: column;
}
.date-card .day {
  font-size: 12px;
  color: #666;
}
.date-card .date {
  font-weight: 500;
}
.date-card.active, .time-card.active {
  border-color: #a38d7c;
  background: #faf7f5;
  color: #a38d7c;
}
.policy-card {
  background: #fff0e6;
  padding: 16px;
  border-radius: 12px;
  margin-bottom: 24px;
}
.policy-card h4 {
  color: #ff7a45;
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 0 0 12px 0;
}
.policy-card ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
.policy-card li {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #666;
  margin-bottom: 8px;
}
.primary-btn {
  background: #000;
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
.primary-btn:disabled {
  background: #eee;
  cursor: not-allowed;
}
</style>
