<template>
  <div class="pp-math-container" :class="{ 'is-focused': isFocused }">
    <!-- Toolbar -->
    <div class="pp-math-toolbar">
      <!-- Quick Inline Buttons (Most used) -->
      <div class="toolbar-group">
        <button class="toolbar-btn" @click="insert('\\frac{a}{b}')" title="Fraction">a/b</button>
        <button class="toolbar-btn" @click="insert('^{2}')" title="Superscript">x²</button>
        <button class="toolbar-btn" @click="insert('_{2}')" title="Subscript">x₂</button>
        <button class="toolbar-btn" @click="insert('\\sqrt{x}')" title="Square Root">√</button>
      </div>
      
      <div class="toolbar-divider"></div>

      <!-- Basic Operators Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('basic')" title="Basic Math">
          ± = ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'basic'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('+')" title="Plus">+</button>
            <button class="popup-btn" @click="insertAndClose('-')" title="Minus">-</button>
            <button class="popup-btn" @click="insertAndClose('\\pm')" title="Plus-Minus">±</button>
            <button class="popup-btn" @click="insertAndClose('\\mp')" title="Minus-Plus">∓</button>
            <button class="popup-btn" @click="insertAndClose('\\times')" title="Multiply">×</button>
            <button class="popup-btn" @click="insertAndClose('\\div')" title="Divide">÷</button>
            <button class="popup-btn" @click="insertAndClose('=')" title="Equal">=</button>
            <button class="popup-btn" @click="insertAndClose('\\neq')" title="Not Equal">≠</button>
            <button class="popup-btn" @click="insertAndClose('<')" title="Less Than"><</button>
            <button class="popup-btn" @click="insertAndClose('>')" title="Greater Than">></button>
            <button class="popup-btn" @click="insertAndClose('\\leq')" title="Less/Equal">≤</button>
            <button class="popup-btn" @click="insertAndClose('\\geq')" title="Greater/Equal">≥</button>
            <button class="popup-btn" @click="insertAndClose('\\equiv')" title="Equivalent">≡</button>
            <button class="popup-btn" @click="insertAndClose('\\approx')" title="Approximately">≈</button>
            <button class="popup-btn" @click="insertAndClose('\\propto')" title="Proportional">∝</button>
            <button class="popup-btn" @click="insertAndClose('\\cdot')" title="Dot">·</button>
            <button class="popup-btn" @click="insertAndClose('\\circ')" title="Circle">∘</button>
            <button class="popup-btn" @click="insertAndClose('\\sqrt{x}')" title="Square Root">√</button>
            <button class="popup-btn" @click="insertAndClose('\\sqrt[n]{x}')" title="Nth Root">ⁿ√</button>
            <button class="popup-btn" @click="insertAndClose('!')" title="Factorial">!</button>
          </div>
        </div>
      </div>

      <!-- Calculus Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('calculus')" title="Calculus & Analysis">
          ∫ ∑ ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'calculus'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\sum_{i=1}^{n}')" title="Sum">∑</button>
            <button class="popup-btn" @click="insertAndClose('\\prod_{i=1}^{n}')" title="Product">∏</button>
            <button class="popup-btn" @click="insertAndClose('\\coprod')" title="Coproduct">∐</button>
            <button class="popup-btn" @click="insertAndClose('\\int_{a}^{b}')" title="Integral">∫</button>
            <button class="popup-btn" @click="insertAndClose('\\iint')" title="Double Integral">∬</button>
            <button class="popup-btn" @click="insertAndClose('\\iiint')" title="Triple Integral">∭</button>
            <button class="popup-btn" @click="insertAndClose('\\oint')" title="Contour Integral">∮</button>
            <button class="popup-btn" @click="insertAndClose('\\partial')" title="Partial">∂</button>
            <button class="popup-btn" @click="insertAndClose('\\nabla')" title="Gradient">∇</button>
            <button class="popup-btn" @click="insertAndClose('\\infty')" title="Infinity">∞</button>
            <button class="popup-btn" @click="insertAndClose('\\lim_{x \\to \\infty}')" title="Limit">lim</button>
            <button class="popup-btn" @click="insertAndClose('\\max')" title="Maximum">max</button>
            <button class="popup-btn" @click="insertAndClose('\\min')" title="Minimum">min</button>
            <button class="popup-btn" @click="insertAndClose('\\sup')" title="Supremum">sup</button>
            <button class="popup-btn" @click="insertAndClose('\\inf')" title="Infimum">inf</button>
            <button class="popup-btn" @click="insertAndClose('dx')" title="Differential">dx</button>
            <button class="popup-btn" @click="insertAndClose('\\Delta x')" title="Delta x">Δx</button>
            <button class="popup-btn" @click="insertAndClose('\\prime')" title="Prime">′</button>
          </div>
        </div>
      </div>

      <!-- Logic & Sets Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('logic')" title="Logic & Sets">
          ∀ ∈ ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'logic'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\forall')" title="For All">∀</button>
            <button class="popup-btn" @click="insertAndClose('\\exists')" title="Exists">∃</button>
            <button class="popup-btn" @click="insertAndClose('\\nexists')" title="Not Exists">∄</button>
            <button class="popup-btn" @click="insertAndClose('\\in')" title="In">∈</button>
            <button class="popup-btn" @click="insertAndClose('\\notin')" title="Not In">∉</button>
            <button class="popup-btn" @click="insertAndClose('\\subset')" title="Subset">⊂</button>
            <button class="popup-btn" @click="insertAndClose('\\supset')" title="Superset">⊃</button>
            <button class="popup-btn" @click="insertAndClose('\\subseteq')" title="Subset or Equal">⊆</button>
            <button class="popup-btn" @click="insertAndClose('\\supseteq')" title="Superset or Equal">⊇</button>
            <button class="popup-btn" @click="insertAndClose('\\cup')" title="Union">∪</button>
            <button class="popup-btn" @click="insertAndClose('\\cap')" title="Intersection">∩</button>
            <button class="popup-btn" @click="insertAndClose('\\setminus')" title="Set Minus">\</button>
            <button class="popup-btn" @click="insertAndClose('\\emptyset')" title="Empty Set">∅</button>
            <button class="popup-btn" @click="insertAndClose('\\implies')" title="Implies">⟹</button>
            <button class="popup-btn" @click="insertAndClose('\\iff')" title="If and Only If">⟺</button>
            <button class="popup-btn" @click="insertAndClose('\\therefore')" title="Therefore">∴</button>
            <button class="popup-btn" @click="insertAndClose('\\because')" title="Because">∵</button>
            <button class="popup-btn" @click="insertAndClose('\\top')" title="Top/True">⊤</button>
            <button class="popup-btn" @click="insertAndClose('\\bot')" title="Bottom/False">⊥</button>
            <button class="popup-btn" @click="insertAndClose('\\vdash')" title="Provable">⊢</button>
            <button class="popup-btn" @click="insertAndClose('\\models')" title="Models/Entails">⊨</button>
            <button class="popup-btn" @click="insertAndClose('\\mathbb{R}')" title="Reals">ℝ</button>
            <button class="popup-btn" @click="insertAndClose('\\mathbb{Z}')" title="Integers">ℤ</button>
            <button class="popup-btn" @click="insertAndClose('\\mathbb{N}')" title="Naturals">ℕ</button>
            <button class="popup-btn" @click="insertAndClose('\\mathbb{Q}')" title="Rationals">ℚ</button>
            <button class="popup-btn" @click="insertAndClose('\\mathbb{C}')" title="Complex">ℂ</button>
          </div>
        </div>
      </div>

      <!-- Greek Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('greek')" title="Greek Letters">
          αβγ ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'greek'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\alpha')">α</button>
            <button class="popup-btn" @click="insertAndClose('\\beta')">β</button>
            <button class="popup-btn" @click="insertAndClose('\\gamma')">γ</button>
            <button class="popup-btn" @click="insertAndClose('\\delta')">δ</button>
            <button class="popup-btn" @click="insertAndClose('\\epsilon')">ε</button>
            <button class="popup-btn" @click="insertAndClose('\\varepsilon')">ε</button>
            <button class="popup-btn" @click="insertAndClose('\\zeta')">ζ</button>
            <button class="popup-btn" @click="insertAndClose('\\eta')">η</button>
            <button class="popup-btn" @click="insertAndClose('\\theta')">θ</button>
            <button class="popup-btn" @click="insertAndClose('\\vartheta')">ϑ</button>
            <button class="popup-btn" @click="insertAndClose('\\iota')">ι</button>
            <button class="popup-btn" @click="insertAndClose('\\kappa')">κ</button>
            <button class="popup-btn" @click="insertAndClose('\\lambda')">λ</button>
            <button class="popup-btn" @click="insertAndClose('\\mu')">μ</button>
            <button class="popup-btn" @click="insertAndClose('\\nu')">ν</button>
            <button class="popup-btn" @click="insertAndClose('\\xi')">ξ</button>
            <button class="popup-btn" @click="insertAndClose('\\pi')">π</button>
            <button class="popup-btn" @click="insertAndClose('\\rho')">ρ</button>
            <button class="popup-btn" @click="insertAndClose('\\sigma')">σ</button>
            <button class="popup-btn" @click="insertAndClose('\\tau')">τ</button>
            <button class="popup-btn" @click="insertAndClose('\\upsilon')">υ</button>
            <button class="popup-btn" @click="insertAndClose('\\phi')">φ</button>
            <button class="popup-btn" @click="insertAndClose('\\varphi')">ϕ</button>
            <button class="popup-btn" @click="insertAndClose('\\chi')">χ</button>
            <button class="popup-btn" @click="insertAndClose('\\psi')">ψ</button>
            <button class="popup-btn" @click="insertAndClose('\\omega')">ω</button>
            <button class="popup-btn" @click="insertAndClose('\\Gamma')">Γ</button>
            <button class="popup-btn" @click="insertAndClose('\\Delta')">Δ</button>
            <button class="popup-btn" @click="insertAndClose('\\Theta')">Θ</button>
            <button class="popup-btn" @click="insertAndClose('\\Lambda')">Λ</button>
            <button class="popup-btn" @click="insertAndClose('\\Xi')">Ξ</button>
            <button class="popup-btn" @click="insertAndClose('\\Pi')">Π</button>
            <button class="popup-btn" @click="insertAndClose('\\Sigma')">Σ</button>
            <button class="popup-btn" @click="insertAndClose('\\Upsilon')">Υ</button>
            <button class="popup-btn" @click="insertAndClose('\\Phi')">Φ</button>
            <button class="popup-btn" @click="insertAndClose('\\Psi')">Ψ</button>
            <button class="popup-btn" @click="insertAndClose('\\Omega')">Ω</button>
          </div>
        </div>
      </div>

      <!-- Arrows, Brackets, & Matrices Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('physics')" title="Arrows, Brackets & Matrices">
          [→] ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'physics'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\leftarrow')" title="Left Arrow">←</button>
            <button class="popup-btn" @click="insertAndClose('\\rightarrow')" title="Right Arrow">→</button>
            <button class="popup-btn" @click="insertAndClose('\\uparrow')" title="Up Arrow">↑</button>
            <button class="popup-btn" @click="insertAndClose('\\downarrow')" title="Down Arrow">↓</button>
            <button class="popup-btn" @click="insertAndClose('\\leftrightarrow')" title="Left Right Arrow">↔</button>
            <button class="popup-btn" @click="insertAndClose('\\updownarrow')" title="Up Down Arrow">↕</button>
            <button class="popup-btn" @click="insertAndClose('\\Leftarrow')" title="Double Left Arrow">⇐</button>
            <button class="popup-btn" @click="insertAndClose('\\Rightarrow')" title="Double Right Arrow">⇒</button>
            <button class="popup-btn" @click="insertAndClose('\\Leftrightarrow')" title="Double Left Right Arrow">⇔</button>
            <button class="popup-btn" @click="insertAndClose('\\rightleftharpoons')" title="Equilibrium">⇌</button>
            <button class="popup-btn" @click="insertAndClose('\\left( \\right)')" title="Parentheses">( )</button>
            <button class="popup-btn" @click="insertAndClose('\\left[ \\right]')" title="Square Brackets">[ ]</button>
            <button class="popup-btn" @click="insertAndClose('\\left\\{ \\right\\}')" title="Curly Braces">{ }</button>
            <button class="popup-btn" @click="insertAndClose('\\left| \\right|')" title="Absolute Value">| |</button>
            <button class="popup-btn" @click="insertAndClose('\\langle \\rangle')" title="Angle Brackets">⟨ ⟩</button>
            <button class="popup-btn" @click="insertAndClose('\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}')" title="Parentheses Matrix">(■)</button>
            <button class="popup-btn" @click="insertAndClose('\\begin{bmatrix} a & b \\\\ c & d \\end{bmatrix}')" title="Square Matrix">[■]</button>
            <button class="popup-btn" @click="insertAndClose('\\begin{vmatrix} a & b \\\\ c & d \\end{vmatrix}')" title="Determinant Matrix">|■|</button>
            <button class="popup-btn" @click="insertAndClose('\\vec{v}')" title="Vector">v⃗</button>
            <button class="popup-btn" @click="insertAndClose('\\hat{i}')" title="Unit Vector">î</button>
            <button class="popup-btn" @click="insertAndClose('\\bar{x}')" title="Bar">x̄</button>
            <button class="popup-btn" @click="insertAndClose('\\hbar')" title="Reduced Planck">ℏ</button>
            <button class="popup-btn" @click="insertAndClose('_{6}^{14}\\text{C}')" title="Isotope">¹⁴C</button>
            <button class="popup-btn" @click="insertAndClose('^\\circ')" title="Degree">°</button>
          </div>
        </div>
      </div>

      <!-- Functions Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('functions')" title="Functions">
          ƒ(x) ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'functions'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\sin(x)')" title="Sine">sin</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\cos(x)')" title="Cosine">cos</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\tan(x)')" title="Tangent">tan</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\csc(x)')" title="Cosecant">csc</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\sec(x)')" title="Secant">sec</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\cot(x)')" title="Cotangent">cot</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\arcsin(x)')" title="Arc Sine">arcsin</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\arccos(x)')" title="Arc Cosine">arccos</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\arctan(x)')" title="Arc Tangent">arctan</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\sinh(x)')" title="Hyperbolic Sine">sinh</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\cosh(x)')" title="Hyperbolic Cosine">cosh</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\tanh(x)')" title="Hyperbolic Tangent">tanh</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\log(x)')" title="Logarithm">log</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\ln(x)')" title="Natural Log">ln</button>
            <button class="popup-btn" style="width: 48px;" @click="insertAndClose('\\exp(x)')" title="Exponential">exp</button>
          </div>
        </div>
      </div>

      <!-- Geometry & Operators Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('geometry')" title="Geometry & Adv. Operators">
          △ ⊕ ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'geometry'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\triangle')" title="Triangle">△</button>
            <button class="popup-btn" @click="insertAndClose('\\angle')" title="Angle">∠</button>
            <button class="popup-btn" @click="insertAndClose('\\perp')" title="Perpendicular">⊥</button>
            <button class="popup-btn" @click="insertAndClose('\\parallel')" title="Parallel">∥</button>
            <button class="popup-btn" @click="insertAndClose('\\square')" title="Square">□</button>
            <button class="popup-btn" @click="insertAndClose('\\bigcirc')" title="Circle">○</button>
            <button class="popup-btn" @click="insertAndClose('\\oplus')" title="O-Plus">⊕</button>
            <button class="popup-btn" @click="insertAndClose('\\ominus')" title="O-Minus">⊖</button>
            <button class="popup-btn" @click="insertAndClose('\\otimes')" title="O-Times">⊗</button>
            <button class="popup-btn" @click="insertAndClose('\\oslash')" title="O-Slash">⊘</button>
            <button class="popup-btn" @click="insertAndClose('\\odot')" title="O-Dot">⊙</button>
            <button class="popup-btn" @click="insertAndClose('\\star')" title="Star">⋆</button>
            <button class="popup-btn" @click="insertAndClose('\\ast')" title="Asterisk">∗</button>
          </div>
        </div>
      </div>

      <!-- Decorations Popup -->
      <div class="toolbar-dropdown">
        <button class="toolbar-btn dropdown-trigger" @click.stop="togglePopup('decorations')" title="Decorations">
          â ā ▾
        </button>
        <div class="dropdown-popup" v-if="activePopup === 'decorations'" @click.stop>
          <div class="popup-grid">
            <button class="popup-btn" @click="insertAndClose('\\hat{a}')" title="Hat">â</button>
            <button class="popup-btn" @click="insertAndClose('\\bar{a}')" title="Bar">ā</button>
            <button class="popup-btn" @click="insertAndClose('\\tilde{a}')" title="Tilde">ã</button>
            <button class="popup-btn" @click="insertAndClose('\\acute{a}')" title="Acute">á</button>
            <button class="popup-btn" @click="insertAndClose('\\grave{a}')" title="Grave">à</button>
            <button class="popup-btn" @click="insertAndClose('\\dot{a}')" title="Dot">ȧ</button>
            <button class="popup-btn" @click="insertAndClose('\\ddot{a}')" title="Double Dot">ä</button>
            <button class="popup-btn" @click="insertAndClose('\\breve{a}')" title="Breve">ă</button>
            <button class="popup-btn" @click="insertAndClose('\\check{a}')" title="Check">ǎ</button>
            <button class="popup-btn" @click="insertAndClose('\\vec{a}')" title="Vector">a⃗</button>
            <button class="popup-btn" @click="insertAndClose('\\underline{a}')" title="Underline">a̲</button>
            <button class="popup-btn" @click="insertAndClose('\\overbrace{ab}')" title="Overbrace">⏞</button>
            <button class="popup-btn" @click="insertAndClose('\\underbrace{ab}')" title="Underbrace">⏟</button>
          </div>
        </div>
      </div>
      <!-- Mode Toggle -->
      <div v-if="showModeToggle && availableModes.length > 1" class="toolbar-group mode-toggle-group" style="margin-left: auto;">
        <button 
          v-if="availableModes.includes('edit')"
          class="toolbar-btn" 
          :class="{ active: currentMode === 'edit' }"
          @click="currentMode = 'edit'"
          title="Edit Mode"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
        </button>
        <button 
          v-if="availableModes.includes('split')"
          class="toolbar-btn" 
          :class="{ active: currentMode === 'split' }"
          @click="currentMode = 'split'"
          title="Split View"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="12" x2="21" y2="12"></line></svg>
        </button>
        <button 
          v-if="availableModes.includes('preview')"
          class="toolbar-btn" 
          :class="{ active: currentMode === 'preview' }"
          @click="currentMode = 'preview'"
          title="Preview Mode"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
        </button>
      </div>
    </div>

    <!-- Input Area -->
    <div v-show="currentMode === 'edit' || currentMode === 'split'" class="pp-math-input-wrapper">
      <textarea
        ref="textareaRef"
        class="pp-math-input"
        :value="modelValue"
        @input="onInput"
        @focus="onTextareaFocus"
        @blur="isFocused = false"
        :placeholder="placeholder"
        rows="4"
        spellcheck="false"
      ></textarea>
    </div>

    <!-- Preview Area -->
    <div v-show="!hidePreview && (currentMode === 'preview' || currentMode === 'split')" class="pp-math-preview">
      <div v-if="!mathliveLoaded" class="pp-math-loading">Loading visual editor...</div>
      <math-field 
        v-else 
        ref="mathFieldRef" 
        class="pp-math-rendered"
        @input="onMathLiveInput"
        @focus="lastFocused = 'mathlive'"
      ></math-field>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, PropType } from 'vue';

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: 'Enter LaTeX equation (e.g. \\frac{1}{2})'
  },
  hidePreview: {
    type: Boolean,
    default: false
  },
  showModeToggle: {
    type: Boolean,
    default: true
  },
  availableModes: {
    type: Array as PropType<Array<'edit' | 'preview' | 'split'>>,
    default: () => ['edit', 'split', 'preview']
  }
});

const emit = defineEmits(['update:modelValue']);

const textareaRef = ref<HTMLTextAreaElement | null>(null);
const mathFieldRef = ref<any>(null);
const isFocused = ref(false);
const mathliveLoaded = ref(false);
const activePopup = ref<string | null>(null);
const currentMode = ref<'edit' | 'preview' | 'split'>('split');
const lastFocused = ref<'textarea' | 'mathlive'>('textarea');

const onTextareaFocus = () => {
  isFocused.value = true;
  lastFocused.value = 'textarea';
};

const togglePopup = (popupId: string) => {
  if (activePopup.value === popupId) {
    activePopup.value = null;
  } else {
    activePopup.value = popupId;
  }
};

const insertAndClose = (text: string) => {
  insert(text);
  activePopup.value = null;
};

const onInput = (e: Event) => {
  const target = e.target as HTMLTextAreaElement;
  emit('update:modelValue', target.value);
};

const onMathLiveInput = (e: Event) => {
  const target = e.target as any;
  if (target.value !== props.modelValue) {
    emit('update:modelValue', target.value);
  }
};

const insert = (text: string) => {
  if (currentMode.value === 'preview' || (currentMode.value === 'split' && lastFocused.value === 'mathlive')) {
    if (mathFieldRef.value) {
      mathFieldRef.value.executeCommand(['insert', text]);
      mathFieldRef.value.focus();
    }
  } else {
    if (!textareaRef.value) return;
    
    const el = textareaRef.value;
    const start = el.selectionStart;
    const end = el.selectionEnd;
    const currentVal = props.modelValue;
    
    const newVal = currentVal.substring(0, start) + text + currentVal.substring(end);
    emit('update:modelValue', newVal);
    
    // Set focus back and move cursor after inserted text
    setTimeout(() => {
      el.focus();
      el.setSelectionRange(start + text.length, start + text.length);
    }, 0);
  }
};

// Update MathLive when modelValue changes from outside or textarea
watch(() => props.modelValue, (newVal) => {
  if (mathFieldRef.value && mathFieldRef.value.value !== newVal) {
    mathFieldRef.value.value = newVal;
  }
});

// Sync value on mount if loaded
watch(mathliveLoaded, (loaded) => {
  if (loaded && mathFieldRef.value) {
    mathFieldRef.value.value = props.modelValue;
  }
});

// Load MathLive dynamically
onMounted(() => {
  if (window.customElements.get('math-field')) {
    mathliveLoaded.value = true;
    return;
  }

  if (!document.getElementById('mathlive-js')) {
    const script = document.createElement('script');
    script.id = 'mathlive-js';
    script.type = 'module';
    script.src = 'https://unpkg.com/mathlive?module';
    script.onload = () => {
      mathliveLoaded.value = true;
    };
    document.head.appendChild(script);
  } else {
    // If script is already appending but not loaded, poll for it
    const check = setInterval(async () => {
      if (window.customElements.get('math-field')) {
        clearInterval(check);
        mathliveLoaded.value = true;
      }
    }, 100);
  }

  // Click outside to close popup
  document.addEventListener('click', () => {
    activePopup.value = null;
  });
});
</script>

<style scoped>
.pp-math-container {
  border: 1px solid #d1d5db;
  border-radius: 6px;
  background: white;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.pp-math-container.is-focused {
  border-color: #003399;
  box-shadow: 0 0 0 3px rgba(0, 51, 153, 0.1);
}

.pp-math-toolbar {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  padding: 8px;
  background: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
  gap: 8px;
}

.toolbar-group {
  display: flex;
  gap: 4px;
}

.toolbar-divider {
  width: 1px;
  height: 20px;
  background: #d1d5db;
  margin: 0 4px;
}

.toolbar-btn {
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #374151;
  min-width: 32px;
  height: 32px;
  padding: 0 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 14px;
  font-family: serif; /* For math look */
  transition: all 0.2s;
}

.toolbar-btn:hover {
  background: #e5e7eb;
}

.toolbar-btn.active {
  background: #e5e7eb;
  color: #003399;
}

.toolbar-btn:active {
  background: #d1d5db;
}

.pp-math-input-wrapper {
  padding: 8px;
  border-bottom: 1px solid #e5e7eb;
}

.pp-math-input {
  width: 100%;
  border: none;
  outline: none;
  font-family: monospace;
  font-size: 14px;
  color: #1f2937;
  background: transparent;
  resize: vertical;
}

.pp-math-preview {
  padding: 16px;
  background: #ffffff;
  min-height: 80px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow-x: auto;
}

.pp-math-loading {
  color: #9ca3af;
  font-size: 14px;
}

.pp-math-rendered {
  width: 100%;
  font-size: 1.5rem;
  padding: 8px;
  border: 1px solid transparent;
  outline: none;
  background: transparent;
  color: #1f2937;
  color-scheme: light;
}

/* Force math virtual keyboard to light theme */
math-virtual-keyboard {
  color-scheme: light;
}

.pp-math-rendered:focus-within {
  outline: none;
}

/* Popup Styles */
.toolbar-dropdown {
  position: relative;
}

.dropdown-trigger {
  padding: 0 8px;
}

.dropdown-popup {
  position: absolute;
  top: 100%;
  left: 0;
  margin-top: 4px;
  background: white;
  border: 1px solid #e5e7eb;
  border-radius: 6px;
  box-shadow: 0 4px 12px -2px rgba(0, 0, 0, 0.15);
  padding: 8px;
  z-index: 50;
  width: max-content;
  max-width: 320px;
}

.popup-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 4px;
}

.popup-btn {
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-family: serif;
  font-size: 16px;
  transition: background 0.2s;
  color: #374151;
}

.popup-btn:hover {
  background: #f3f4f6;
  border-color: #e5e7eb;
}
</style>
