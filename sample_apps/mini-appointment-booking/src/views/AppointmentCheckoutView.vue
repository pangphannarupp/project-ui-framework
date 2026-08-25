<template>
  <div class="checkout-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.back()">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.checkoutTitle }}</h2>
      <button class="nav-exit-btn" @click="showExitConfirm = true">✕</button>
    </div>

    <div class="content-scroll">
      <!-- Service Summary -->
      <div class="section-card srv-card">
        <span class="cat">{{ store.state.selectedService.category }}</span>
        <h4 class="name">{{ store.state.selectedService.name }}</h4>
        <span class="doc">👨‍⚕️ {{ store.state.selectedService.specialist }}</span>
      </div>

      <!-- Date & Slot Picker -->
      <div class="section-card">
        <h4 class="section-title">📅 {{ t.appointmentDate }}</h4>
        <PPDatePicker 
          v-model="selectedDateObj"
          placeholder="Select Appointment Date"
          class="custom-pp-datepicker"
        />

        <h4 class="section-title" style="margin-top: 14px;">⏰ {{ t.timeSlot }}</h4>
        <div class="slots-grid">
          <button 
            v-for="slot in TIME_SLOTS"
            :key="slot"
            class="slot-btn"
            :class="{ active: store.state.selectedSlot === slot }"
            @click="store.state.selectedSlot = slot"
          >
            {{ slot }}
          </button>
        </div>
      </div>

      <!-- Patient Information -->
      <div class="section-card">
        <h4 class="section-title">Patient Contact Info</h4>
        <div class="form-row">
          <label>Full Name</label>
          <PPInput v-model="store.state.patientName" placeholder="Enter Full Name" />
        </div>
        <div class="form-row">
          <label>Phone Number</label>
          <PPInput v-model="store.state.patientPhone" placeholder="Enter Phone Number" />
        </div>
      </div>

      <!-- Deposit Breakdown -->
      <div class="section-card">
        <div class="bill-row"><span>Full Service Fee</span><span>${{ store.state.selectedService.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Remaining Due on Clinic Visit</span><span>${{ (store.state.selectedService.price - store.state.selectedService.deposit).toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Deposit to Pay Now</span><span class="highlight-total">${{ store.state.selectedService.deposit.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Bar -->
    <div class="bottom-action-bar">
      <PPButton 
        variant="primary" 
        block 
        :disabled="isPaying" 
        @click="handlePay"
        class="pay-btn"
      >
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedService.deposit.toFixed(2) }})</span>
        <span v-else>Confirming Booking...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="View Appointment Pass"
      @confirm="onAlertConfirm"
    />

    <!-- PPConfirm Exit -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { PPAlert, PPConfirm, PPDatePicker, PPInput, PPButton } from '@phanna/ui-framework'
import { useAppointmentStore } from '../store/appointmentStore'
import { TIME_SLOTS } from '../data/appointmentData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useAppointmentStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdAptId = ref('')
const selectedDateObj = ref<Date | null>(new Date())

watch(selectedDateObj, (newVal) => {
  if (newVal) {
    store.state.selectedDate = newVal.toISOString().split('T')[0]
  }
})

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'CLINIC_PREPAY_' + Date.now(),
    amount: store.state.selectedService.deposit,
    currency: 'USD',
    partnerCode: 'CLINIC_RESERVATION',
    metadata: {
      treatment: store.state.selectedService.name,
      patient: store.state.patientName,
      slot: `${store.state.selectedDate}_${store.state.selectedSlot}`
    }
  }

  try {
    let res: any
    if (MiniApp && typeof MiniApp.requestPayment === 'function') {
      res = await MiniApp.requestPayment(payload)
    } else {
      await new Promise(r => setTimeout(r, 600))
      res = { status: 'SUCCESS' }
    }

    if (res?.status === 'SUCCESS' || res?.success) {
      const apt = store.createAppointment()
      createdAptId.value = apt.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${apt.appointmentCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Transaction could not be completed'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdAptId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.srv-card { background: #f0fdfa; border-color: #ccfbf1; }
.cat { font-size: 10px; font-weight: 800; color: #0d9488; text-transform: uppercase; }
.name { font-size: 15px; font-weight: 800; margin: 2px 0; }
.doc { font-size: 12px; color: #64748b; }

.section-title { font-size: 13px; font-weight: 800; margin: 0 0 8px 0; }
.date-field { width: 100%; padding: 8px 12px; border-radius: 8px; border: 1px solid #cbd5e1; font-size: 13px; outline: none; }
.slots-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 8px; }
.slot-btn {
  background: #f8fafc; border: 1px solid #cbd5e1; padding: 8px 4px; border-radius: 8px;
  font-size: 11px; font-weight: 700; cursor: pointer;
}
.slot-btn.active { background: #0d9488; color: white; border-color: #0d9488; }

.form-row { display: flex; flex-direction: column; gap: 4px; margin-bottom: 8px; }
.form-row label { font-size: 11px; font-weight: 700; color: #64748b; }
.form-input { padding: 8px 10px; border-radius: 8px; border: 1px solid #cbd5e1; font-size: 13px; outline: none; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #0d9488; font-size: 17px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #0d9488 0%, #0f766e 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 800; cursor: pointer;
}
</style>
