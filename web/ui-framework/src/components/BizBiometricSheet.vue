<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="biometric-sheet-content">
      
      <!-- Shield Icon -->
      <div class="shield-wrapper">
        <div class="shield-bg-light">
          <div class="shield-bg-dark">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="shield-icon">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="currentColor" stroke="none"></path>
              <polyline points="9 12 11 14 15 10" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></polyline>
            </svg>
          </div>
        </div>
      </div>

      <!-- Title & Subtitle -->
      <h2 class="bio-title">Unlock faster with {{ titleName }}</h2>
      <p class="bio-subtitle">
        Skip PIN entry and securely access your PPCBank smartBiz account using {{ subtitleName }}.
      </p>

      <!-- Selection Cards -->
      <div class="cards-container" :class="{ 'is-both': type === 'both' }">
        <!-- Face ID Card -->
        <div class="bio-card" v-if="type === 'both' || type === 'face'">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="bio-icon">
            <path d="M7 3H5a2 2 0 0 0-2 2v2M17 3h2a2 2 0 0 1 2 2v2M3 17v2a2 2 0 0 0 2 2h2M21 17v2a2 2 0 0 1-2 2h-2"></path>
            <circle cx="12" cy="12" r="3"></circle>
            <path d="M9 16c1.5 1 4.5 1 6 0"></path>
            <circle cx="9" cy="9" r="1"></circle>
            <circle cx="15" cy="9" r="1"></circle>
          </svg>
          <div class="card-title">Face ID</div>
          <div class="card-desc">Use facial recognition</div>
        </div>

        <div class="or-badge" v-if="type === 'both'">Or</div>

        <!-- Fingerprint ID Card -->
        <div class="bio-card" v-if="type === 'both' || type === 'fingerprint'">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="bio-icon">
            <path d="M12 3a9 9 0 0 0-9 9v1"></path>
            <path d="M12 7a5 5 0 0 0-5 5v1"></path>
            <path d="M12 11a1 1 0 0 0-1 1v1"></path>
            <path d="M7 16c0 1.5 1 3 2.5 4M17 16c0 2 1.5 3 3 4M20.5 8.5C19 6.5 16 5 12 5M16 12v1"></path>
            <path d="M16.5 16.5A5.5 5.5 0 0 0 12 15a5.5 5.5 0 0 0-4.5 1.5"></path>
          </svg>
          <div class="card-title">Fingerprint ID</div>
          <div class="card-desc">Use your fingerprint</div>
        </div>
      </div>

      <!-- Info Banner -->
      <div class="info-banner">
        <div class="info-icon-wrapper">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="info-icon">
            <circle cx="12" cy="12" r="10" fill="currentColor" stroke="none"></circle>
            <path d="M12 16v-4M12 8h.01" stroke="#fff" stroke-width="2" stroke-linecap="round"></path>
          </svg>
        </div>
        <div class="info-text">
          <div class="info-title">Face / Fingerprint ID</div>
          <div class="info-desc">
            Link your Face or Fingerprint ID for quick and easy access to your account. Enjoy seamless logins and hassle-free payments by setting it up now.
          </div>
        </div>
      </div>

      <!-- Buttons -->
      <div class="bio-actions">
        <BizButton variant="primary" block @click="handleSetup">Set {{ buttonName }} ID</BizButton>
        <div style="height: 12px;"></div>
        <BizButton variant="outline" block @click="handleLater">Maybe Later</BizButton>
      </div>

    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import BizBottomSheet from './BizBottomSheet.vue';
import BizButton from './BizButton.vue';

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  type: {
    type: String, // 'both', 'face', 'fingerprint'
    default: 'both'
  }
});

const emit = defineEmits(['update:modelValue', 'setup', 'later']);

const titleName = computed(() => {
  if (props.type === 'both') return 'Biometrics';
  if (props.type === 'face') return 'Face ID';
  return 'Fingerprint ID';
});

const subtitleName = computed(() => {
  if (props.type === 'both') return 'Face ID or Fingerprint';
  if (props.type === 'face') return 'Face ID';
  return 'Fingerprint';
});

const buttonName = computed(() => {
  if (props.type === 'both') return 'Biometrics';
  if (props.type === 'face') return 'Face';
  return 'Fingerprint';
});

const handleSetup = () => {
  emit('setup', props.type);
  emit('update:modelValue', false);
};

const handleLater = () => {
  emit('later');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.biometric-sheet-content {
  padding: 16px 24px 32px 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* Shield Icon */
.shield-wrapper {
  margin-bottom: 24px;
  margin-top: 8px;
}
.shield-bg-light {
  width: 72px;
  height: 72px;
  background-color: #e6f0ff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.shield-bg-dark {
  width: 48px;
  height: 48px;
  background-color: var(--biz-primary, #003399);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--biz-primary, #003399);
}
.shield-icon {
  width: 28px;
  height: 28px;
}

/* Typography */
.bio-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 12px 0;
  text-align: center;
}
.bio-subtitle {
  font-size: 13px;
  color: #555;
  text-align: center;
  line-height: 1.5;
  margin: 0 0 32px 0;
  padding: 0 16px;
}

/* Cards */
.cards-container {
  display: flex;
  justify-content: center;
  gap: 16px;
  width: 100%;
  margin-bottom: 32px;
  position: relative;
}
.cards-container.is-both {
  justify-content: space-between;
}
.bio-card {
  flex: 1;
  max-width: 160px;
  background-color: #ffffff;
  border: 1px solid #eaeaea;
  border-radius: 16px;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.03);
}
.bio-icon {
  width: 40px;
  height: 40px;
  color: #0066cc;
  margin-bottom: 16px;
}
.card-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin-bottom: 6px;
}
.card-desc {
  font-size: 11px;
  color: #777;
  text-align: center;
  line-height: 1.4;
}

/* Or Badge */
.or-badge {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 32px;
  height: 32px;
  background-color: #f8f9fa;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 600;
  color: var(--biz-primary-variant, #1a2a5e);
  z-index: 2;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

/* Info Banner */
.info-banner {
  display: flex;
  gap: 12px;
  width: 100%;
  margin-bottom: 32px;
  align-items: flex-start;
}
.info-icon-wrapper {
  flex-shrink: 0;
  color: #0066cc;
  margin-top: 2px;
}
.info-icon {
  width: 20px;
  height: 20px;
}
.info-text {
  flex: 1;
}
.info-title {
  font-size: 13px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin-bottom: 4px;
}
.info-desc {
  font-size: 11px;
  color: #666;
  line-height: 1.5;
}

/* Actions */
.bio-actions {
  width: 100%;
}
</style>
