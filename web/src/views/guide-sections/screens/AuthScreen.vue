<template>
  <div class="component-section">
    <h2>Authentication Template</h2>
    <p>A modern split-screen login and registration template built entirely with PPUI components.</p>
    
    <div class="demo-box template-demo">
      <div class="auth-layout">
        <!-- Left Side: Branding / Image -->
        <div class="auth-brand">
          <div class="brand-content">
            <h2 class="brand-logo">PPUI Pro</h2>
            <p class="brand-tagline">Building enterprise interfaces has never been easier.</p>
          </div>
          <!-- Decorative UI elements fading in the background -->
          <div class="brand-decoration">
            <div class="circle c1"></div>
            <div class="circle c2"></div>
          </div>
        </div>

        <!-- Right Side: Form -->
        <div class="auth-form-container">
          <div class="auth-form-wrapper">
            <h3>Welcome back</h3>
            <p class="auth-subtitle">Please enter your details to sign in.</p>

            <form @submit.prevent class="auth-form">
              <div class="form-group">
                <PPTextField 
                  v-model="email" 
                  label="Email" 
                  placeholder="Enter your email" 
                  type="email"
                />
              </div>

              <div class="form-group">
                <PPTextField 
                  v-model="password" 
                  label="Password" 
                  placeholder="••••••••" 
                  type="password"
                />
              </div>

              <div class="auth-actions">
                <label class="remember-me">
                  <input type="checkbox" class="pp-native-checkbox" />
                  <span>Remember me</span>
                </label>
                <a href="#" class="forgot-link">Forgot password?</a>
              </div>

              <button class="pp-btn pp-btn-primary full-width sign-in-btn">
                Sign In
              </button>
              
              <button class="pp-btn pp-btn-outline full-width google-btn">
                <span class="icon">G</span>
                Sign in with Google
              </button>
            </form>

            <p class="auth-footer">
              Don't have an account? <a href="#">Sign up</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTextField } from '@phanna/ui-framework';

const email = ref('');
const password = ref('');
</script>

<style scoped>
.template-demo {
  padding: 0;
  overflow: hidden;
  height: 600px;
}

.auth-layout {
  display: flex;
  height: 100%;
  width: 100%;
  background: white;
}

/* Brand Side */
.auth-brand {
  flex: 1;
  background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
  color: white;
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

@media (max-width: 768px) {
  .auth-brand { display: none; }
}

.brand-content {
  position: relative;
  z-index: 2;
  max-width: 320px;
}

.brand-logo {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 16px 0;
  letter-spacing: -0.5px;
}

.brand-tagline {
  font-size: 18px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.brand-decoration .circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255,255,255,0.1);
}
.brand-decoration .c1 {
  width: 400px;
  height: 400px;
  bottom: -150px;
  right: -100px;
}
.brand-decoration .c2 {
  width: 250px;
  height: 250px;
  top: -50px;
  left: -100px;
}

/* Form Side */
.auth-form-container {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 48px;
}

.auth-form-wrapper {
  width: 100%;
  max-width: 360px;
}

.auth-form-wrapper h3 {
  font-size: 28px;
  font-weight: 700;
  color: #111827;
  margin: 0 0 8px 0;
}

.auth-subtitle {
  color: #6b7280;
  margin: 0 0 32px 0;
  font-size: 15px;
}

.form-group {
  margin-bottom: 20px;
}

.auth-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.remember-me {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #374151;
  cursor: pointer;
}

.pp-native-checkbox {
  width: 16px;
  height: 16px;
  accent-color: #4f46e5;
}

.forgot-link {
  font-size: 14px;
  color: #4f46e5;
  text-decoration: none;
  font-weight: 500;
}

.pp-btn {
  padding: 10px 16px;
  border-radius: 6px;
  font-weight: 500;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.full-width {
  width: 100%;
  display: flex;
}

.pp-btn-primary {
  background: #4f46e5;
  color: white;
  border: 1px solid #4f46e5;
}

.pp-btn-primary:hover {
  background: #4338ca;
}

.pp-btn-outline {
  background: white;
  color: #374151;
  border: 1px solid #d1d5db;
}

.pp-btn-outline:hover {
  background: #f9fafb;
}

.sign-in-btn {
  margin-bottom: 16px;
}

.google-btn .icon {
  font-weight: 800;
  margin-right: 8px;
}

.auth-footer {
  text-align: center;
  margin-top: 32px;
  font-size: 14px;
  color: #6b7280;
}

.auth-footer a {
  color: #4f46e5;
  text-decoration: none;
  font-weight: 600;
}
</style>
