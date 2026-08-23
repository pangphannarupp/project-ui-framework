<script setup lang="ts">
import { useLoginViewModel } from '../viewmodels/useLoginViewModel'

const {
  email,
  password,
  rememberMe,
  isLoading,
  handleLogin,
  fillQuickLogin
} = useLoginViewModel()
</script>

<template>
  <div class="login-layout">
    <div class="login-bg-glow"></div>
    <div class="login-card glass-panel">
      <div class="brand-badge">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="#60a5fa" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
      </div>
      <h2>Mini Portal Management</h2>
      <p class="subtitle">Secure administrative console & mini app distribution gateway</p>

      <form @submit.prevent="handleLogin" class="login-form">
        <div class="form-group">
          <label>Admin Work Email</label>
          <PPInput v-model="email" type="email" placeholder="admin@domain.com" required />
        </div>

        <div class="form-group">
          <div class="label-row">
            <label>Master Security Key</label>
            <a href="#" class="forgot-link">Forgot?</a>
          </div>
          <PPInput v-model="password" type="password" placeholder="••••••••••••" required />
        </div>

        <div class="remember-row">
          <label class="remember-label">
            <PPCheckbox v-model="rememberMe" />
            <span>Keep session active on this node (30 days)</span>
          </label>
        </div>

        <PPButton type="submit" variant="filled" style="width: 100%;" :disabled="isLoading">
          <span>{{ isLoading ? 'Verifying HSM Session...' : 'Sign In to Portal →' }}</span>
        </PPButton>
      </form>

      <div class="quick-roles">
        <span>Instant Sandbox Accounts:</span>
        <div class="role-chips">
          <button @click="fillQuickLogin('admin@mcnc.biz')" class="role-btn">Super Admin</button>
          <button @click="fillQuickLogin('ops@mcnc.biz')" class="role-btn">Operator</button>
          <button @click="fillQuickLogin('dev@mcnc.biz')" class="role-btn">Developer</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-layout {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #0b1120;
  position: relative;
  overflow: hidden;
  padding: 20px;
}

.login-bg-glow {
  position: absolute;
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.15), transparent 70%);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  pointer-events: none;
}

.login-card {
  width: 100%;
  max-width: 440px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 20px;
  padding: 36px;
  position: relative;
  z-index: 10;
  text-align: center;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
}

.brand-badge {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: rgba(59, 130, 246, 0.15);
  border: 1px solid rgba(59, 130, 246, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
}

.login-card h2 {
  font-size: 20px;
  color: #fff;
  margin-bottom: 6px;
}

.subtitle {
  font-size: 13px;
  color: #94a3b8;
  margin-bottom: 24px;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
  text-align: left;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 12px;
  color: #cbd5e1;
  font-weight: 500;
}

.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.forgot-link {
  font-size: 11px;
  color: #60a5fa;
  text-decoration: none;
}

.remember-row {
  display: flex;
  align-items: center;
  margin: 2px 0 6px;
}

.remember-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  color: #94a3b8;
  cursor: pointer;
}

.quick-roles {
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid #1f2937;
  font-size: 12px;
  color: #64748b;
}

.role-chips {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 10px;
}

.role-btn {
  background: #0f172a;
  border: 1px solid #1f2937;
  color: #94a3b8;
  font-size: 11px;
  padding: 5px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
}

.role-btn:hover {
  background: #1e293b;
  color: #60a5fa;
  border-color: #3b82f6;
}
</style>
