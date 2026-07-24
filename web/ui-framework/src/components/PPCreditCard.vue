<template>
  <div class="pp-credit-card-container">
    <!-- Card Visual -->
    <div class="pp-credit-card" :class="{ 'is-flipped': isFlipped }">
      <div class="pp-credit-card-inner">
        <!-- Front Side -->
        <div class="pp-credit-card-front">
          <div class="card-logo">Visa</div>
          <div class="card-chip"></div>
          <div class="card-number">{{ displayCardNumber }}</div>
          <div class="card-footer">
            <div class="card-holder">
              <div class="label">Card Holder</div>
              <div class="value">{{ cardHolder || 'JOHN DOE' }}</div>
            </div>
            <div class="card-expires">
              <div class="label">Expires</div>
              <div class="value">{{ cardExpiry || 'MM/YY' }}</div>
            </div>
          </div>
        </div>

        <!-- Back Side -->
        <div class="pp-credit-card-back">
          <div class="card-stripe"></div>
          <div class="card-cvc-box">
            <div class="label">CVC</div>
            <div class="cvc-band">{{ cardCvc }}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Inputs -->
    <div class="pp-credit-card-form">
      <div class="input-group">
        <label>Card Number</label>
        <input 
          type="text" 
          v-model="cardNumber" 
          maxlength="19" 
          placeholder="0000 0000 0000 0000"
          @input="formatCardNumber"
          @focus="isFlipped = false"
        />
      </div>
      
      <div class="input-group">
        <label>Card Holder</label>
        <input 
          type="text" 
          v-model="cardHolder" 
          placeholder="John Doe"
          @focus="isFlipped = false"
        />
      </div>

      <div class="input-row">
        <div class="input-group">
          <label>Expiration (MM/YY)</label>
          <input 
            type="text" 
            v-model="cardExpiry" 
            maxlength="5" 
            placeholder="MM/YY"
            @input="formatExpiry"
            @focus="isFlipped = false"
          />
        </div>
        <div class="input-group">
          <label>CVC</label>
          <input 
            type="text" 
            v-model="cardCvc" 
            maxlength="4" 
            placeholder="123"
            @focus="isFlipped = true"
            @blur="isFlipped = false"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const isFlipped = ref(false);
const cardNumber = ref('');
const cardHolder = ref('');
const cardExpiry = ref('');
const cardCvc = ref('');

const formatCardNumber = (e: any) => {
  let val = e.target.value.replace(/\D/g, '');
  if (val.length > 0) {
    val = val.match(new RegExp('.{1,4}', 'g'))?.join(' ') || val;
  }
  cardNumber.value = val;
};

const formatExpiry = (e: any) => {
  let val = e.target.value.replace(/\D/g, '');
  if (val.length >= 2) {
    val = val.substring(0, 2) + '/' + val.substring(2, 4);
  }
  cardExpiry.value = val;
};

const displayCardNumber = computed(() => {
  const val = cardNumber.value.replace(/\s/g, '');
  if (!val) return '#### #### #### ####';
  let str = '';
  for (let i = 0; i < 16; i++) {
    if (i > 0 && i % 4 === 0) str += ' ';
    str += val[i] || '#';
  }
  return str;
});
</script>

<style scoped>
.pp-credit-card-container {
  max-width: 400px;
  margin: 0 auto;
}

.pp-credit-card {
  perspective: 1000px;
  width: 100%;
  height: 240px;
  margin-bottom: 30px;
  position: relative;
  z-index: 10;
}

.pp-credit-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: left;
  transition: transform 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  transform-style: preserve-3d;
}

.pp-credit-card.is-flipped .pp-credit-card-inner {
  transform: rotateY(180deg);
}

.pp-credit-card-front, .pp-credit-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  border-radius: 20px;
  box-shadow: 0 15px 35px rgba(0,0,0,0.2);
  color: white;
  padding: 24px;
  box-sizing: border-box;
}

.pp-credit-card-front {
  background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
}

.pp-credit-card-back {
  background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
  transform: rotateY(180deg);
  padding: 24px 0;
}

.card-logo {
  font-size: 24px;
  font-weight: 800;
  font-style: italic;
  text-align: right;
  margin-bottom: 20px;
}

.card-chip {
  width: 50px;
  height: 40px;
  background: #ffcc00;
  border-radius: 6px;
  margin-bottom: 24px;
  position: relative;
  overflow: hidden;
}
.card-chip::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  height: 1px;
  background: rgba(0,0,0,0.2);
}

.card-number {
  font-size: 26px;
  letter-spacing: 2px;
  font-family: 'Courier New', Courier, monospace;
  margin-bottom: 24px;
  text-shadow: 0 2px 2px rgba(0,0,0,0.3);
}

.card-footer {
  display: flex;
  justify-content: space-between;
}

.card-holder, .card-expires {
  text-transform: uppercase;
}

.label {
  font-size: 10px;
  opacity: 0.7;
  margin-bottom: 4px;
}

.value {
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 1px;
}

.card-stripe {
  width: 100%;
  height: 50px;
  background: #111;
  margin-bottom: 20px;
}

.card-cvc-box {
  padding: 0 24px;
  text-align: right;
}

.cvc-band {
  background: white;
  color: #333;
  height: 40px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 0 16px;
  font-size: 16px;
  font-style: italic;
}

.pp-credit-card-form {
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.05);
  margin-top: -80px;
  padding-top: 100px;
}

.input-group {
  margin-bottom: 16px;
  display: flex;
  flex-direction: column;
}

.input-row {
  display: flex;
  gap: 16px;
}
.input-row .input-group {
  flex: 1;
}

label {
  font-size: 12px;
  font-weight: 600;
  color: #64748b;
  margin-bottom: 8px;
}

input, select {
  width: 100%;
  box-sizing: border-box;
  padding: 12px;
  background: white;
  border: 1px solid #cbd5e1;
  border-radius: 8px;
  font-size: 14px;
  color: #334155;
  outline: none;
  transition: border-color 0.2s;
}

input:focus, select:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}
</style>
