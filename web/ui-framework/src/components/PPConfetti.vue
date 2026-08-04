<template>
  <div class="pp-confetti-container" v-if="isActive">
    <canvas ref="canvasRef" class="confetti-canvas"></canvas>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, watch } from 'vue';

const props = defineProps({
  active: {
    type: Boolean,
    default: false
  },
  duration: {
    type: Number,
    default: 3000
  },
  particleCount: {
    type: Number,
    default: 100
  },
  colors: {
    type: Array,
    default: () => ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899']
  }
});

const emit = defineEmits(['update:active', 'complete']);

const isActive = ref(props.active);
const canvasRef = ref<HTMLCanvasElement | null>(null);

let particles: any[] = [];
let animationId: number;
let ctx: CanvasRenderingContext2D | null = null;
let stopTimeout: any;

watch(() => props.active, (newVal) => {
  isActive.value = newVal;
  if (newVal) {
    startConfetti();
  } else {
    stopConfetti();
  }
});

const randomRange = (min: number, max: number) => Math.random() * (max - min) + min;

const initParticles = () => {
  particles = [];
  const canvas = canvasRef.value;
  if (!canvas) return;
  
  for (let i = 0; i < props.particleCount; i++) {
    particles.push({
      x: canvas.width / 2, // Start from center bottom
      y: canvas.height,
      r: randomRange(4, 10), // Size
      dx: randomRange(-10, 10), // Velocity X
      dy: randomRange(-15, -25), // Velocity Y (initial blast upwards)
      color: props.colors[Math.floor(Math.random() * props.colors.length)] as string,
      tilt: Math.floor(Math.random() * 10) - 10,
      tiltAngleIncrement: (Math.random() * 0.07) + 0.05,
      tiltAngle: 0
    });
  }
};

const draw = () => {
  const canvas = canvasRef.value;
  if (!canvas || !ctx) return;
  
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  
  for (let i = 0; i < particles.length; i++) {
    const p = particles[i];
    
    ctx.beginPath();
    ctx.lineWidth = p.r;
    ctx.strokeStyle = p.color;
    ctx.moveTo(p.x + p.tilt + p.r, p.y);
    ctx.lineTo(p.x + p.tilt, p.y + p.tilt + p.r);
    ctx.stroke();
  }
};

const update = () => {
  const canvas = canvasRef.value;
  if (!canvas) return;
  
  let remaining = 0;
  
  for (let i = 0; i < particles.length; i++) {
    const p = particles[i];
    
    p.tiltAngle += p.tiltAngleIncrement;
    p.y += (Math.cos(p.tiltAngle) + 1 + p.r / 2) / 2; // Gravity + falling
    p.y += p.dy; // Apply initial upward velocity
    p.x += Math.sin(p.tiltAngle) * 2; // Sway
    p.x += p.dx; // Horizontal drift
    
    p.dy *= 0.95; // Friction to slow upward blast
    
    if (p.y <= canvas.height) {
      remaining++;
    }
  }
  
  return remaining > 0;
};

const animate = () => {
  animationId = requestAnimationFrame(animate);
  draw();
  const keepGoing = update();
  
  if (!keepGoing) {
    stopConfetti();
  }
};

const startConfetti = () => {
  setTimeout(() => {
    const canvas = canvasRef.value;
    if (canvas) {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
      ctx = canvas.getContext('2d');
      
      initParticles();
      animate();
      
      stopTimeout = setTimeout(() => {
        stopConfetti();
      }, props.duration);
    }
  }, 50); // slight delay to allow canvas render
};

const stopConfetti = () => {
  cancelAnimationFrame(animationId);
  clearTimeout(stopTimeout);
  isActive.value = false;
  emit('update:active', false);
  emit('complete');
};

onMounted(() => {
  if (isActive.value) {
    startConfetti();
  }
});

onBeforeUnmount(() => {
  cancelAnimationFrame(animationId);
  clearTimeout(stopTimeout);
});
</script>

<style scoped>
.pp-confetti-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  pointer-events: none;
  z-index: 9999;
}
.confetti-canvas {
  width: 100%;
  height: 100%;
}
</style>
