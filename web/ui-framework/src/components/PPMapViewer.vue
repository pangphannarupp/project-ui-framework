<template>
  <div class="pp-map-viewer" :style="{ height: containerHeight }">
    <!-- Static Map Image Background -->
    <div 
      class="map-background" 
      :style="{ backgroundImage: `url(${mapImageUrl})` }"
    ></div>
    
    <!-- Custom Map Controls -->
    <div v-if="showControls" class="map-controls">
      <div class="control-group">
        <button class="map-btn" @click="$emit('zoom-in')"><ion-icon :icon="addOutline" /></button>
        <div class="divider"></div>
        <button class="map-btn" @click="$emit('zoom-out')"><ion-icon :icon="removeOutline" /></button>
      </div>
      <button class="map-btn locate-btn" @click="$emit('locate')"><ion-icon :icon="locateOutline" /></button>
    </div>
    
    <!-- Render Markers -->
    <div class="markers-layer">
      <div 
        v-for="(marker, index) in markers" 
        :key="index"
        class="marker-pin"
        :style="{ top: marker.top || '50%', left: marker.left || '50%' }"
        @click="$emit('marker-click', marker)"
      >
        <ion-icon :icon="location" :style="{ color: marker.color || '#ef4444' }" />
        <div v-if="marker.label" class="marker-label">{{ marker.label }}</div>
      </div>
    </div>
    
    <!-- Slot for absolute positioned overlays (like bottom sheets) -->
    <div class="map-overlays">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { addOutline, removeOutline, locateOutline, location } from 'ionicons/icons';

interface Marker {
  id?: string | number;
  top?: string;
  left?: string;
  color?: string;
  label?: string;
  data?: any;
}

interface Props {
  height?: string | number;
  latitude?: number;
  longitude?: number;
  zoom?: number;
  markers?: Marker[];
  showControls?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  height: 400,
  latitude: 37.7749,
  longitude: -122.4194,
  zoom: 12,
  markers: () => [],
  showControls: true
});

defineEmits(['zoom-in', 'zoom-out', 'locate', 'marker-click']);

const containerHeight = computed(() => {
  return typeof props.height === 'number' ? `${props.height}px` : props.height;
});

// Since we are mocking the map engine to keep the framework zero-dependency,
// we use a static map image. In a real implementation, you would swap this div
// with a Leaflet map container or Google Maps API instance.
const mapImageUrl = computed(() => {
  // Mock image based on coords
  return `https://picsum.photos/1000/1000?random=map_${props.latitude}_${props.longitude}`;
});
</script>

<style scoped>
.pp-map-viewer {
  width: 100%;
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  background: #e2e8f0;
}

.map-background {
  position: absolute;
  top: -10%;
  left: -10%;
  right: -10%;
  bottom: -10%;
  background-position: center;
  background-size: cover;
  filter: saturate(0.8) contrast(1.1); /* Map-like aesthetic for the random image */
  pointer-events: none;
}

.map-controls {
  position: absolute;
  right: 16px;
  bottom: 24px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  z-index: 10;
}

.control-group {
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.map-btn {
  background: white;
  border: none;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  color: #334155;
  cursor: pointer;
  padding: 0;
}
.map-btn:hover {
  background: #f8fafc;
}
.map-btn:active {
  background: #f1f5f9;
}

.locate-btn {
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  color: var(--pp-primary, #3b82f6);
}

.divider {
  height: 1px;
  background: #e2e8f0;
  width: 100%;
}

.markers-layer {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
}

.marker-pin {
  position: absolute;
  transform: translate(-50%, -100%);
  pointer-events: auto;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: center;
  transition: transform 0.2s ease;
}
.marker-pin:hover {
  transform: translate(-50%, -100%) scale(1.1);
}
.marker-pin ion-icon {
  font-size: 36px;
  filter: drop-shadow(0 2px 4px rgba(0,0,0,0.4));
}
.marker-label {
  background: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  color: #0f172a;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  margin-top: -4px;
  white-space: nowrap;
}

.map-overlays {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none; /* Let clicks pass through to map unless caught by children */
}
.map-overlays > * {
  pointer-events: auto;
}
</style>
