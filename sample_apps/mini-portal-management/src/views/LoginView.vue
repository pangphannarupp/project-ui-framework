<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const email = ref('admin@miniportal.io')
const password = ref('••••••••••••')
const otpCode = ref('')
const rememberMe = ref(true)
const requires2FA = ref(false)
const isLoading = ref(false)
const errorMessage = ref('')

const handleLogin = () => {
  isLoading.value = true
  errorMessage.value = ''

  setTimeout(() => {
    isLoading.value = false
    if (!requires2FA.value) {
      requires2FA.value = true
    } else {
      router.push('/dashboard')
    }
  }, 700)
}

const fillDemo = (role: string) => {
  if (role === 'admin') {
    email.value = 'pangphanna@example.com'
    password.value = 'superadmin2026'
  } else {
    email.value = 'operator@example.com'
    password.value = 'operator2026'
  }
}
</script>

<template>
  <div class="login-container">
    <!-- Left Visual Panel -->
    <div class="visual-panel">
      <div class="visual-content">
        <div class="brand-badge">⚡ Next-Gen Architecture</div>
        <h1>Mini Portal Management</h1>
        <p>Enterprise orchestration, telemetry, payment routing, and real-time push distribution for 30+ mini applications.</p>

        <div class="stats-grid">
          <div class="stat-card">
            <h4>30+</h4>
            <span>Integrated Mini Apps</span>
          </div>
          <div class="stat-card">
            <h4>168K</h4>
            <span>Daily Active Users</span>
          </div>
          <div class="stat-card">
            <h4>99.99%</h4>
            <span>Uptime SLA</span>
          </div>
        </div>
      </div>
      <div class="glow-sphere"></div>
    </div>

    <!-- Right Login Form -->
    <div class="form-panel">
      <div class="form-card glass-panel">
        <div class="form-header">
          <h2>Welcome Back</h2>
          <p>{{ requires2FA ? 'Enter the 6-digit verification code' : 'Sign in to access your administration console' }}</p>
        </div>

        <div v-if="errorMessage" class="error-banner">
          ⚠️ {{ errorMessage }}
        </div>

        <form @submit.prevent="handleLogin" class="login-form">
          <template v-if="!requires2FA">
            <div class="input-group">
              <label>Email Address</label>
              <input
                type="email"
                v-model="email"
                required
                placeholder="name@company.com"
              />
            </div>

            <div class="input-group">
              <div class="label-row">
                <label>Password</label>
                <a href="#" class="forgot-link">Forgot?</a>
              </div>
              <input
                type="password"
                v-model="password"
                required
                placeholder="Enter your password"
              />
            </div>

            <div class="options-row">
              <label class="checkbox-label">
                <input type="checkbox" v-model="rememberMe" />
                <span>Keep me signed in for 30 days</span>
              </label>
            </div>
          </template>

          <template v-else>
            <div class="input-group">
              <label>Two-Factor Authentication Code (2FA)</label>
              <input
                type="text"
                v-model="otpCode"
                placeholder="6 5 4 3 2 1"
                maxlength="6"
                class="otp-input"
                required
              />
              <small class="helper-text">Enter any 6 digits for demo verification</small>
            </div>
          </template>

          <button type="submit" class="submit-btn" :disabled="isLoading">
            <span v-if="isLoading">Authenticating...</span>
            <span v-else-if="requires2FA">Verify & Enter Dashboard →</span>
            <span v-else>Continue with Password →</span>
          </button>
        </form>

        <div class="quick-demo-section">
          <span>Quick Demo Access:</span>
          <div class="demo-buttons">
            <button type="button" @click="fillDemo('admin')" class="demo-chip">
              🛡️ Super Admin
            </button>
            <button type="button" @click="fillDemo('operator')" class="demo-chip">
              👷 Operator
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-container {
  display: flex;
  min-height: 100vh;
  background: #090d16;
}

/* Left Visual */
.visual-panel {
  flex: 1;
  background: radial-gradient(circle at 20% 30%, #1e1b4b 0%, #090d16 70%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px;
  position: relative;
  overflow: hidden;
}

.visual-content {
  max-width: 520px;
  position: relative;
  z-index: 10;
}

.brand-badge {
  display: inline-block;
  background: rgba(99, 102, 241, 0.15);
  color: #818cf8;
  border: 1px solid rgba(99, 102, 241, 0.3);
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
  margin-bottom: 24px;
}

.visual-content h1 {
  font-size: 42px;
  font-weight: 800;
  line-height: 1.15;
  color: #fff;
  margin-bottom: 16px;
  background: linear-gradient(135deg, #ffffff 0%, #94a3b8 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.visual-content p {
  font-size: 16px;
  color: #94a3b8;
  line-height: 1.6;
  margin-bottom: 40px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.stat-card {
  background: rgba(30, 41, 59, 0.5);
  border: 1px solid rgba(255, 255, 255, 0.08);
  padding: 16px;
  border-radius: 12px;
}

.stat-card h4 {
  font-size: 24px;
  font-weight: 700;
  color: #60a5fa;
  margin-bottom: 4px;
}

.stat-card span {
  font-size: 12px;
  color: #94a3b8;
}

.glow-sphere {
  position: absolute;
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.25), transparent 70%);
  top: -100px;
  left: -100px;
  filter: blur(50px);
}

/* Right Form */
.form-panel {
  width: 520px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  background: #0f172a;
}

.form-card {
  width: 100%;
  max-width: 420px;
  padding: 36px;
  background: #1e293b;
  border: 1px solid #334155;
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.form-header h2 {
  font-size: 24px;
  font-weight: 700;
  color: #fff;
  margin-bottom: 6px;
}

.form-header p {
  font-size: 14px;
  color: #94a3b8;
  margin-bottom: 24px;
}

.error-banner {
  background: rgba(239, 68, 68, 0.15);
  border: 1px solid #ef4444;
  color: #fca5a5;
  padding: 10px 14px;
  border-radius: 8px;
  font-size: 13px;
  margin-bottom: 16px;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.input-group label {
  font-size: 13px;
  font-weight: 600;
  color: #cbd5e1;
}

.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.forgot-link {
  font-size: 12px;
  color: #60a5fa;
  text-decoration: none;
}

.input-group input {
  background: #0f172a;
  border: 1px solid #334155;
  padding: 12px 16px;
  border-radius: 10px;
  color: #fff;
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s;
}

.input-group input:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

.otp-input {
  letter-spacing: 6px;
  font-size: 18px !important;
  text-align: center;
  font-family: 'JetBrains Mono', monospace;
}

.helper-text {
  font-size: 12px;
  color: #64748b;
}

.options-row {
  display: flex;
  align-items: center;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #94a3b8;
  cursor: pointer;
}

.submit-btn {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  border: none;
  padding: 14px;
  border-radius: 10px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}

.submit-btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 20px rgba(37, 99, 235, 0.5);
}

.submit-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.quick-demo-section {
  margin-top: 28px;
  padding-top: 20px;
  border-top: 1px solid #334155;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.quick-demo-section span {
  font-size: 12px;
  color: #64748b;
}

.demo-buttons {
  display: flex;
  gap: 10px;
}

.demo-chip {
  flex: 1;
  background: #0f172a;
  border: 1px solid #334155;
  color: #cbd5e1;
  padding: 8px 12px;
  border-radius: 8px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.demo-chip:hover {
  background: #1e293b;
  border-color: #60a5fa;
  color: #fff;
}

@media (max-width: 900px) {
  .visual-panel {
    display: none;
  }
  .form-panel {
    width: 100%;
  }
}
</style>
