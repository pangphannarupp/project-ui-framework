<template>
  <div class="guide-section">
    <h2>Keypads & Security</h2>
    <p>Secure input methods for PINs and amounts.</p>

    <h3>Standard Keypad</h3>
    <div class="demo-box" :style="{ backgroundColor: keypadTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: keypadTheme === 'light' ? '#e5e7eb' : '#333' }">
      <div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;">
        <label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }">
          <input type="checkbox" v-model="isKeypadLightMode" /> Light Theme
        </label>
        
        <label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }">
          Variant:
          <select v-model="keypadVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;">
            <option value="default">Default</option>
            <option value="flat">Flat</option>
            <option value="glass">Glass</option>
          </select>
        </label>

        <label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }">
          BG Color:
          <input type="color" v-model="keypadBgColor" style="margin-left: 4px; vertical-align: middle;" />
          <button @click="keypadBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;">Clear</button>
        </label>
      </div>
      <div style="margin-bottom: 24px; position: relative;">
        <!-- Demo background image just to show off glass effect -->
        <img v-if="keypadVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=1000&auto=format&fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" />
        
        <div style="position: relative; z-index: 1; text-align: center; font-size: 24px; margin-bottom: 24px; font-family: monospace; color: white;">
          <div :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }">{{ keypadValue || 'Enter Amount' }}</div>
        </div>
        <div style="position: relative; z-index: 1; max-width: 400px; margin: 0 auto;">
          <PPKeypad 
            :theme="keypadTheme" 
            :variant="keypadVariant"
            :backgroundColor="keypadBgColor"
            @press="onKeypadPress" 
          />
        </div>
      </div>
      <pre class="code-block" style="margin: 0; position: relative; z-index: 1;" v-pre><code>&lt;PPKeypad theme="{{ keypadTheme }}" variant="{{ keypadVariant }}" backgroundColor="{{ keypadBgColor }}" @press="onPress" /&gt;</code></pre>
    </div>

    <h3>Secure Keyboard</h3>
    <p>A randomized keyboard layout to prevent keylogging/screen tracking.</p>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <PPSecureKeyboard @input="onSecureInput" @delete="onSecureDelete" />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPSecureKeyboard @input="onInput" @delete="onDelete" /&gt;</code></pre>
    </div>

    <h3>Khmer Keyboard</h3>
    <p>A full-featured virtual keyboard for the Khmer language.</p>
    <div class="demo-box" :style="{ backgroundColor: khmerTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: khmerTheme === 'light' ? '#e5e7eb' : '#333' }">
      <div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;">
        <label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }">
          <input type="checkbox" v-model="isKhmerLightMode" /> Light Theme
        </label>
        
        <label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }">
          Variant:
          <select v-model="khmerVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;">
            <option value="default">Default</option>
            <option value="flat">Flat</option>
            <option value="glass">Glass</option>
          </select>
        </label>

        <label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }">
          BG Color:
          <input type="color" v-model="khmerBgColor" style="margin-left: 4px; vertical-align: middle;" />
          <button @click="khmerBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;">Clear</button>
        </label>
      </div>
      <div style="margin-bottom: 24px; position: relative;">
        <!-- Demo background image just to show off glass effect -->
        <img v-if="khmerVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=1000&auto=format&fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" />
        
        <div style="position: relative; z-index: 1; min-height: 48px; border: 1px solid #ccc; border-radius: 6px; padding: 12px; font-size: 24px; background: #fff; color: #000; margin-bottom: 16px; font-family: 'Suwannaphum', 'Hanuman', sans-serif;">
          {{ khmerValue || '...' }}
        </div>
        
        <div style="position: relative; z-index: 1;">
          <PPKhmerKeyboard 
            :theme="khmerTheme" 
            :variant="khmerVariant"
            :backgroundColor="khmerBgColor"
            @input="onKhmerInput" 
            @delete="onKhmerDelete" 
            @enter="onKhmerEnter" 
            @emoji="onKhmerEmoji"
          />
        </div>
      </div>
      <pre class="code-block" style="margin: 0; position: relative; z-index: 1;" v-pre><code>&lt;PPKhmerKeyboard theme="{{ khmerTheme }}" variant="{{ khmerVariant }}" backgroundColor="{{ khmerBgColor }}" @input="onInput" @delete="onDelete" @enter="onEnter" @emoji="onEmoji" /&gt;</code></pre>
    </div>

    <h3>English Keyboard</h3>
    <p>A standard QWERTY English keyboard layout.</p>
    <div class="demo-box" :style="{ backgroundColor: englishTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: englishTheme === 'light' ? '#e5e7eb' : '#333' }">
      <div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;">
        <label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }">
          <input type="checkbox" v-model="isEnglishLightMode" /> Light Theme
        </label>
        
        <label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }">
          Variant:
          <select v-model="englishVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;">
            <option value="default">Default</option>
            <option value="flat">Flat</option>
            <option value="glass">Glass</option>
          </select>
        </label>

        <label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }">
          BG Color:
          <input type="color" v-model="englishBgColor" style="margin-left: 4px; vertical-align: middle;" />
          <button @click="englishBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;">Clear</button>
        </label>
      </div>
      <div style="margin-bottom: 24px; position: relative;">
        <!-- Demo background image just to show off glass effect -->
        <img v-if="englishVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=1000&auto=format&fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" />
        
        <div style="position: relative; z-index: 1; min-height: 48px; border: 1px solid #ccc; border-radius: 6px; padding: 12px; font-size: 24px; background: #fff; color: #000; margin-bottom: 16px;">
          {{ englishValue || '...' }}
        </div>
        
        <div style="position: relative; z-index: 1;">
          <PPEnglishKeyboard 
            :theme="englishTheme" 
            :variant="englishVariant"
            :backgroundColor="englishBgColor"
            @input="onEnglishInput" 
            @delete="onEnglishDelete" 
            @enter="onEnglishEnter" 
            @emoji="onEnglishEmoji"
          />
        </div>
      </div>
      <pre class="code-block" style="margin: 0; position: relative; z-index: 1;" v-pre><code>&lt;PPEnglishKeyboard theme="{{ englishTheme }}" variant="{{ englishVariant }}" backgroundColor="{{ englishBgColor }}" @input="onInput" @delete="onDelete" @enter="onEnter" @emoji="onEmoji" /&gt;</code></pre>
    </div>

    <h3>Phone Keyboard</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <div style="text-align: center; font-size: 24px; margin-bottom: 24px; font-family: monospace;">
          {{ phoneValue || 'Enter Number' }}
        </div>
        <PPPhoneKeyboard @press="onPhonePress" @call="onPhoneCall" />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPPhoneKeyboard @press="onPress" @call="onCall" /&gt;</code></pre>
    </div>

    <h3>Math Keyboard</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <div style="text-align: right; font-size: 24px; margin-bottom: 24px; font-family: monospace; border: 1px solid #ccc; padding: 12px; border-radius: 6px;">
          {{ mathValue || '0' }}
        </div>
        <PPMathKeyboard @input="onMathInput" @delete="onMathDelete" />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPMathKeyboard @input="onInput" @delete="onDelete" /&gt;</code></pre>
    </div>

    <h3>Emoji Keyboard</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <div style="text-align: center; font-size: 32px; margin-bottom: 24px; min-height: 48px;">
          {{ emojiValue }}
        </div>
        <PPEmojiKeyboard @input="onEmojiInput" @delete="onEmojiDelete" @back="onEmojiBack" />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPEmojiKeyboard @input="onInput" @delete="onDelete" @back="onBack" /&gt;</code></pre>
    </div>

  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-keypad-bg: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;div class="guide-section"&gt;
    &lt;h2&gt;Keypads &amp; Security&lt;/h2&gt;
    &lt;p&gt;Secure input methods for PINs and amounts.&lt;/p&gt;

    &lt;h3&gt;Standard Keypad&lt;/h3&gt;
    &lt;div class="demo-box" :style="{ backgroundColor: keypadTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: keypadTheme === 'light' ? '#e5e7eb' : '#333' }"&gt;
      &lt;div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;"&gt;
        &lt;label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }"&gt;
          &lt;input type="checkbox" v-model="isKeypadLightMode" /&gt; Light Theme
        &lt;/label&gt;
        
        &lt;label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }"&gt;
          Variant:
          &lt;select v-model="keypadVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;"&gt;
            &lt;option value="default"&gt;Default&lt;/option&gt;
            &lt;option value="flat"&gt;Flat&lt;/option&gt;
            &lt;option value="glass"&gt;Glass&lt;/option&gt;
          &lt;/select&gt;
        &lt;/label&gt;

        &lt;label :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }"&gt;
          BG Color:
          &lt;input type="color" v-model="keypadBgColor" style="margin-left: 4px; vertical-align: middle;" /&gt;
          &lt;button @click="keypadBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;"&gt;Clear&lt;/button&gt;
        &lt;/label&gt;
      &lt;/div&gt;
      &lt;div style="margin-bottom: 24px; position: relative;"&gt;
        &lt;!-- Demo background image just to show off glass effect --&gt;
        &lt;img v-if="keypadVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" /&gt;
        
        &lt;div style="position: relative; z-index: 1; text-align: center; font-size: 24px; margin-bottom: 24px; font-family: monospace; color: white;"&gt;
          &lt;div :style="{ color: keypadTheme === 'light' ? '#000' : '#fff' }"&gt;{{ keypadValue || 'Enter Amount' }}&lt;/div&gt;
        &lt;/div&gt;
        &lt;div style="position: relative; z-index: 1; max-width: 400px; margin: 0 auto;"&gt;
          &lt;PPKeypad 
            :theme="keypadTheme" 
            :variant="keypadVariant"
            :backgroundColor="keypadBgColor"
            @press="onKeypadPress" 
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0; position: relative; z-index: 1;"&gt;&lt;code&gt;&amp;lt;PPKeypad theme="{{ keypadTheme }}" variant="{{ keypadVariant }}" backgroundColor="{{ keypadBgColor }}" @press="onPress" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Secure Keyboard&lt;/h3&gt;
    &lt;p&gt;A randomized keyboard layout to prevent keylogging/screen tracking.&lt;/p&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;PPSecureKeyboard @input="onSecureInput" @delete="onSecureDelete" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPSecureKeyboard @input="onInput" @delete="onDelete" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Khmer Keyboard&lt;/h3&gt;
    &lt;p&gt;A full-featured virtual keyboard for the Khmer language.&lt;/p&gt;
    &lt;div class="demo-box" :style="{ backgroundColor: khmerTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: khmerTheme === 'light' ? '#e5e7eb' : '#333' }"&gt;
      &lt;div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;"&gt;
        &lt;label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }"&gt;
          &lt;input type="checkbox" v-model="isKhmerLightMode" /&gt; Light Theme
        &lt;/label&gt;
        
        &lt;label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }"&gt;
          Variant:
          &lt;select v-model="khmerVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;"&gt;
            &lt;option value="default"&gt;Default&lt;/option&gt;
            &lt;option value="flat"&gt;Flat&lt;/option&gt;
            &lt;option value="glass"&gt;Glass&lt;/option&gt;
          &lt;/select&gt;
        &lt;/label&gt;

        &lt;label :style="{ color: khmerTheme === 'light' ? '#000' : '#fff' }"&gt;
          BG Color:
          &lt;input type="color" v-model="khmerBgColor" style="margin-left: 4px; vertical-align: middle;" /&gt;
          &lt;button @click="khmerBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;"&gt;Clear&lt;/button&gt;
        &lt;/label&gt;
      &lt;/div&gt;
      &lt;div style="margin-bottom: 24px; position: relative;"&gt;
        &lt;!-- Demo background image just to show off glass effect --&gt;
        &lt;img v-if="khmerVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" /&gt;
        
        &lt;div style="position: relative; z-index: 1; min-height: 48px; border: 1px solid #ccc; border-radius: 6px; padding: 12px; font-size: 24px; background: #fff; color: #000; margin-bottom: 16px; font-family: 'Suwannaphum', 'Hanuman', sans-serif;"&gt;
          {{ khmerValue || '...' }}
        &lt;/div&gt;
        
        &lt;div style="position: relative; z-index: 1;"&gt;
          &lt;PPKhmerKeyboard 
            :theme="khmerTheme" 
            :variant="khmerVariant"
            :backgroundColor="khmerBgColor"
            @input="onKhmerInput" 
            @delete="onKhmerDelete" 
            @enter="onKhmerEnter" 
            @emoji="onKhmerEmoji"
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0; position: relative; z-index: 1;"&gt;&lt;code&gt;&amp;lt;PPKhmerKeyboard theme="{{ khmerTheme }}" variant="{{ khmerVariant }}" backgroundColor="{{ khmerBgColor }}" @input="onInput" @delete="onDelete" @enter="onEnter" @emoji="onEmoji" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;English Keyboard&lt;/h3&gt;
    &lt;p&gt;A standard QWERTY English keyboard layout.&lt;/p&gt;
    &lt;div class="demo-box" :style="{ backgroundColor: englishTheme === 'light' ? '#f5f7f9' : '#000000', borderColor: englishTheme === 'light' ? '#e5e7eb' : '#333' }"&gt;
      &lt;div style="margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 16px; align-items: center;"&gt;
        &lt;label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }"&gt;
          &lt;input type="checkbox" v-model="isEnglishLightMode" /&gt; Light Theme
        &lt;/label&gt;
        
        &lt;label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }"&gt;
          Variant:
          &lt;select v-model="englishVariant" style="margin-left: 4px; padding: 4px; border-radius: 4px;"&gt;
            &lt;option value="default"&gt;Default&lt;/option&gt;
            &lt;option value="flat"&gt;Flat&lt;/option&gt;
            &lt;option value="glass"&gt;Glass&lt;/option&gt;
          &lt;/select&gt;
        &lt;/label&gt;

        &lt;label :style="{ color: englishTheme === 'light' ? '#000' : '#fff' }"&gt;
          BG Color:
          &lt;input type="color" v-model="englishBgColor" style="margin-left: 4px; vertical-align: middle;" /&gt;
          &lt;button @click="englishBgColor = ''" style="margin-left: 4px; padding: 2px 6px; font-size: 12px; border-radius: 4px;"&gt;Clear&lt;/button&gt;
        &lt;/label&gt;
      &lt;/div&gt;
      &lt;div style="margin-bottom: 24px; position: relative;"&gt;
        &lt;!-- Demo background image just to show off glass effect --&gt;
        &lt;img v-if="englishVariant === 'glass'" src="https://images.unsplash.com/photo-1557683316-973673baf926?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; border-radius: 8px; z-index: 0; opacity: 0.8;" /&gt;
        
        &lt;div style="position: relative; z-index: 1; min-height: 48px; border: 1px solid #ccc; border-radius: 6px; padding: 12px; font-size: 24px; background: #fff; color: #000; margin-bottom: 16px;"&gt;
          {{ englishValue || '...' }}
        &lt;/div&gt;
        
        &lt;div style="position: relative; z-index: 1;"&gt;
          &lt;PPEnglishKeyboard 
            :theme="englishTheme" 
            :variant="englishVariant"
            :backgroundColor="englishBgColor"
            @input="onEnglishInput" 
            @delete="onEnglishDelete" 
            @enter="onEnglishEnter" 
            @emoji="onEnglishEmoji"
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0; position: relative; z-index: 1;"&gt;&lt;code&gt;&amp;lt;PPEnglishKeyboard theme="{{ englishTheme }}" variant="{{ englishVariant }}" backgroundColor="{{ englishBgColor }}" @input="onInput" @delete="onDelete" @enter="onEnter" @emoji="onEmoji" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Phone Keyboard&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;div style="text-align: center; font-size: 24px; margin-bottom: 24px; font-family: monospace;"&gt;
          {{ phoneValue || 'Enter Number' }}
        &lt;/div&gt;
        &lt;PPPhoneKeyboard @press="onPhonePress" @call="onPhoneCall" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPPhoneKeyboard @press="onPress" @call="onCall" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Math Keyboard&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;div style="text-align: right; font-size: 24px; margin-bottom: 24px; font-family: monospace; border: 1px solid #ccc; padding: 12px; border-radius: 6px;"&gt;
          {{ mathValue || '0' }}
        &lt;/div&gt;
        &lt;PPMathKeyboard @input="onMathInput" @delete="onMathDelete" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPMathKeyboard @input="onInput" @delete="onDelete" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Emoji Keyboard&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;div style="text-align: center; font-size: 32px; margin-bottom: 24px; min-height: 48px;"&gt;
          {{ emojiValue }}
        &lt;/div&gt;
        &lt;PPEmojiKeyboard @input="onEmojiInput" @delete="onEmojiDelete" @back="onEmojiBack" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPEmojiKeyboard @input="onInput" @delete="onDelete" @back="onBack" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-keypad-bg: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';
import { PPKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPEnglishKeyboard, PPPhoneKeyboard, PPMathKeyboard, PPEmojiKeyboard } from '@phanna/ui-framework';

const keypadValue = ref('');
const isKeypadLightMode = ref(false);
const keypadVariant = ref&lt;'default' | 'flat' | 'glass'&gt;('default');
const keypadBgColor = ref('');
const keypadTheme = computed(() =&gt; isKeypadLightMode.value ? 'light' : 'dark');

const onKeypadPress = (val: string) =&gt; {
  if (val === 'backspace') {
    keypadValue.value = keypadValue.value.slice(0, -1);
  } else if (keypadValue.value.length &lt; 10) {
    keypadValue.value += val;
  }
};

const onSecureInput = (val: string) =&gt; console.log('Secure Input:', val);
const onSecureDelete = () =&gt; console.log('Secure Delete');

const englishValue = ref('');
const isEnglishLightMode = ref(false);
const englishVariant = ref&lt;'default' | 'flat' | 'glass'&gt;('default');
const englishBgColor = ref('');
const englishTheme = computed(() =&gt; isEnglishLightMode.value ? 'light' : 'dark');

const onEnglishInput = (val: string) =&gt; {
  englishValue.value += val;
};
const onEnglishDelete = () =&gt; {
  englishValue.value = englishValue.value.slice(0, -1);
};
const onEnglishEnter = () =&gt; {
  englishValue.value += '\n';
};
const onEnglishEmoji = () =&gt; {
  alert('Emoji button clicked!');
};

const khmerValue = ref('');
const isKhmerLightMode = ref(false);
const khmerVariant = ref&lt;'default' | 'flat' | 'glass'&gt;('default');
const khmerBgColor = ref('');
const khmerTheme = computed(() =&gt; isKhmerLightMode.value ? 'light' : 'dark');

const onKhmerInput = (val: string) =&gt; {
  khmerValue.value += val;
};
const onKhmerDelete = () =&gt; {
  khmerValue.value = khmerValue.value.slice(0, -1);
};
const onKhmerEnter = () =&gt; {
  khmerValue.value += '\n';
};
const onKhmerEmoji = () =&gt; {
  alert('Emoji button clicked!');
};

const phoneValue = ref('');
const onPhonePress = (val: string) =&gt; {
  if (val === 'backspace') {
    phoneValue.value = phoneValue.value.slice(0, -1);
  } else {
    phoneValue.value += val;
  }
};
const onPhoneCall = () =&gt; alert(`Calling ${phoneValue.value}...`);

const mathValue = ref('');
const onMathInput = (val: string) =&gt; mathValue.value += val;
const onMathDelete = () =&gt; mathValue.value = mathValue.value.slice(0, -1);

const emojiValue = ref('');
const onEmojiInput = (val: string) =&gt; emojiValue.value += val;
const onEmojiDelete = () =&gt; {
  // Simple delete, might have issues with surrogate pairs but okay for demo
  emojiValue.value = emojiValue.value.slice(0, -2); 
};
const onEmojiBack = () =&gt; alert('Back button clicked (return to text keyboard)!');
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { PPKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPEnglishKeyboard, PPPhoneKeyboard, PPMathKeyboard, PPEmojiKeyboard } from '@phanna/ui-framework';

const keypadValue = ref('');
const isKeypadLightMode = ref(false);
const keypadVariant = ref<'default' | 'flat' | 'glass'>('default');
const keypadBgColor = ref('');
const keypadTheme = computed(() => isKeypadLightMode.value ? 'light' : 'dark');

const onKeypadPress = (val: string) => {
  if (val === 'backspace') {
    keypadValue.value = keypadValue.value.slice(0, -1);
  } else if (keypadValue.value.length < 10) {
    keypadValue.value += val;
  }
};

const onSecureInput = (val: string) => console.log('Secure Input:', val);
const onSecureDelete = () => console.log('Secure Delete');

const englishValue = ref('');
const isEnglishLightMode = ref(false);
const englishVariant = ref<'default' | 'flat' | 'glass'>('default');
const englishBgColor = ref('');
const englishTheme = computed(() => isEnglishLightMode.value ? 'light' : 'dark');

const onEnglishInput = (val: string) => {
  englishValue.value += val;
};
const onEnglishDelete = () => {
  englishValue.value = englishValue.value.slice(0, -1);
};
const onEnglishEnter = () => {
  englishValue.value += '\n';
};
const onEnglishEmoji = () => {
  alert('Emoji button clicked!');
};

const khmerValue = ref('');
const isKhmerLightMode = ref(false);
const khmerVariant = ref<'default' | 'flat' | 'glass'>('default');
const khmerBgColor = ref('');
const khmerTheme = computed(() => isKhmerLightMode.value ? 'light' : 'dark');

const onKhmerInput = (val: string) => {
  khmerValue.value += val;
};
const onKhmerDelete = () => {
  khmerValue.value = khmerValue.value.slice(0, -1);
};
const onKhmerEnter = () => {
  khmerValue.value += '\n';
};
const onKhmerEmoji = () => {
  alert('Emoji button clicked!');
};

const phoneValue = ref('');
const onPhonePress = (val: string) => {
  if (val === 'backspace') {
    phoneValue.value = phoneValue.value.slice(0, -1);
  } else {
    phoneValue.value += val;
  }
};
const onPhoneCall = () => alert(`Calling ${phoneValue.value}...`);

const mathValue = ref('');
const onMathInput = (val: string) => mathValue.value += val;
const onMathDelete = () => mathValue.value = mathValue.value.slice(0, -1);

const emojiValue = ref('');
const onEmojiInput = (val: string) => emojiValue.value += val;
const onEmojiDelete = () => {
  // Simple delete, might have issues with surrogate pairs but okay for demo
  emojiValue.value = emojiValue.value.slice(0, -2); 
};
const onEmojiBack = () => alert('Back button clicked (return to text keyboard)!');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
