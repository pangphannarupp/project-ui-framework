<template>
<div class="guide-section">
        <h2>6. Form Inputs</h2>
        
        <div class="variant-group">
          <h3>BizTextField Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable />
            <BizTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable />
            <BizTextField v-model="textVal" variant="underlined" label="Underlined" placeholder="Enter text" clearable />
          </div>
          <pre class="code-block"><code>&lt;BizTextField variant="outlined|filled|underlined" label="..." clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizSelect Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <BizSelect v-model="selectVal" label="Outlined (Default)" :options="[{label: 'Option 1', value: 1}, {label: 'Option 2', value: 2}]" placeholder="Select an option" />
            <BizSelect v-model="selectVal" variant="filled" label="Filled" :options="[{label: 'Option A', value: 'a'}, {label: 'Option B', value: 'b'}]" placeholder="Choose..." />
            <BizSelect v-model="selectVal" variant="underlined" label="Underlined" :options="[{label: 'Yes', value: 'yes'}, {label: 'No', value: 'no'}]" placeholder="Pick one" />
          </div>
          <pre class="code-block"><code>&lt;BizSelect variant="outlined|filled|underlined" label="..." :options="[...]" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>BizTransferList Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 32px;">
            <BizTransferList v-model="transferVal" variant="outlined" :data="transferOptions" :titles="['Available (Outlined)', 'Selected (Outlined)']" />
            <BizTransferList v-model="transferVal" variant="filled" :data="transferOptions" :titles="['Available (Filled)', 'Selected (Filled)']" />
            <BizTransferList v-model="transferVal" variant="underlined" :data="transferOptions" :titles="['Available (Underlined)', 'Selected (Underlined)']" />
          </div>
          <pre class="code-block"><code>&lt;BizTransferList v-model="selectedKeys" variant="outlined" :data="options" :titles="['Source', 'Target']" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Text Input</h3>
          <div class="component-demo">
            <BizInput v-model="textVal" label="Username" placeholder="Enter name" clearable />
          </div>
          <pre class="code-block"><code>&lt;BizInput v-model="text" label="Username" clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Password Input (with icon)</h3>
          <div class="component-demo">
            <BizInput v-model="textVal" label="Password" type="password" placeholder="Enter pass" clearable>
              <template #iconLeft>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
              </template>
            </BizInput>
          </div>
          <pre class="code-block"><code>&lt;BizInput type="password"&gt;
  &lt;template #iconLeft&gt;...&lt;/template&gt;
&lt;/BizInput&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Phone Input</h3>
          <div class="component-demo">
            <BizPhoneInput v-model="phoneVal" label="Phone Number" placeholder="12 *** *66" />
          </div>
          <pre class="code-block"><code>&lt;BizPhoneInput v-model="phone" countryCode="+855" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>File Upload</h3>
          <div class="component-demo">
            <BizFileUpload 
              multiple 
              accept=".pdf,image/*" 
              :maxSize="5 * 1024 * 1024"
              :files="uploadedFiles"
              @select="handleFileUpload"
              @remove="handleFileRemove"
              @retry="handleFileRetry"
            />
          </div>
          <pre class="code-block"><code>&lt;BizFileUpload multiple accept=".pdf,image/*" :files="files" @select="..." /&gt;</code></pre>
        </div>
        

        <div class="variant-group">
          <h3>OTP Input (6-digit)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <BizOtpInput v-model="otpVal" :length="6" />
          </div>
          <pre class="code-block"><code>&lt;BizOtpInput v-model="otp" :length="6" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker</h3>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <BizColorPicker v-model="colorVal" />
            <p style="margin-top: 16px; font-weight: 500;">Selected Color: <span :style="{ color: colorVal }">{{ colorVal }}</span></p>
          </div>
          <pre class="code-block"><code>&lt;BizColorPicker v-model="color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizColorPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <BizButton @click="showColorPickerSheet = true">Open Color Sheet</BizButton>
            <BizColorPickerSheet 
              v-model="showColorPickerSheet"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;BizColorPickerSheet v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizColorPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <BizButton @click="showColorPickerIsland = true">Open Color Picker Island</BizButton>
            <BizColorPickerIsland 
              v-model="showColorPickerIsland"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;BizColorPickerIsland v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;BizColorPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <BizButton @click="showColorPickerAlert = true">Open Color Alert</BizButton>
            <BizColorPickerAlert 
              v-model="showColorPickerAlert"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;BizColorPickerAlert v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const textVal = ref('');

const colorVal = ref('#ff0000');

const showColorPickerSheet = ref(false);

const showColorPickerAlert = ref(false);

const showColorPickerIsland = ref(false);

const selectVal = ref('');

const transferVal = ref([2, 3]);

const transferOptions = ref([
  { key: 1, label: 'Option A' },
  { key: 2, label: 'Option B' },
  { key: 3, label: 'Option C' },
  { key: 4, label: 'Option D (Disabled)', disabled: true },
  { key: 5, label: 'Option E' },
]);

const phoneVal = ref('');

const otpVal = ref('');

const uploadedFiles = ref<any[]>([]);

const handleFileUpload = (newFiles: any[]) => {
  newFiles.forEach(file => {
    const id = Date.now().toString() + Math.random().toString();
    const newFileObj = { id, name: file.name, size: file.size, progress: 0, status: 'uploading', file };
    uploadedFiles.value.push(newFileObj);
    const interval = setInterval(() => {
      const fileRef = uploadedFiles.value.find((f: any) => f.id === id);
      if (!fileRef) { clearInterval(interval); return; }
      fileRef.progress += Math.random() * 20 + 5;
      if (fileRef.progress >= 100) {
        fileRef.progress = 100;
        fileRef.status = Math.random() > 0.8 ? 'error' : 'success';
        if (fileRef.status === 'error') fileRef.errorMessage = 'Network timeout';
        clearInterval(interval);
      }
    }, 500);
  });
};

const handleFileRemove = (id: string | number) => {
  uploadedFiles.value = uploadedFiles.value.filter(f => f.id !== id);
};

const handleFileRetry = (id: string | number) => {
  const fileRef = uploadedFiles.value.find(f => f.id === id);
  if (fileRef) {
    fileRef.status = 'uploading';
    fileRef.progress = 0;
    const interval = setInterval(() => {
      const fRef = uploadedFiles.value.find((f: any) => f.id === id);
      if (!fRef) { clearInterval(interval); return; }
      fRef.progress += Math.random() * 20 + 5;
      if (fRef.progress >= 100) {
        fRef.progress = 100;
        fRef.status = 'success';
        clearInterval(interval);
      }
    }, 500);
  }
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { BizButton, BizButtonGroup, BizImageTransition, BizSwipeItem, BizSlider, BizSwitch, BizBarChart, BizLineChart, BizDonutChart, BizPieChart, BizRadarChart, BizProgressGauge, BizScatterChart, BizFunnelChart, BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail, BizHideAppBar, BizBottomNav, BizFab, BizFabList, BizFabAction, BizNumberSpinner, BizRadio, BizRadioGroup, BizRating, BizCollapsingToolbar, BizPullToRefresh, BizInput, BizTextField, BizSelect, BizTransferList, BizToggleButton, BizCheckbox, BizCheckboxGroup, BizPhoneInput, BizOtpInput, BizInfoCard, BizActionCard, BizAccountCard, BizSegment, BizSegmentButton, BizCompanySelector, BizScrollSegment, BizScrollSegmentButton, BizNotificationItem, BizPinDots, BizKeypad, BizSecureKeypad, BizSecureKeyboard, BizKhmerKeyboard, BizToast, BizConfirmSheet, BizReceiveAmountSheet, BizAccountSavingCard, BizReceivingAccountSheet, BizKhmerCalendar, BizKhmerCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarIsland, BizCalendar, BizCalendarSheet, BizCalendarAlert, BizCalendarIsland, BizFileUpload, BizMonthPicker, BizMonthPickerSheet, BizMonthPickerAlert, BizMonthPickerIsland, BizYearPicker, BizYearPickerSheet, BizYearPickerAlert, BizYearPickerIsland, BizTimePicker, BizTimePickerSheet, BizTimePickerAlert, BizTimePickerIsland, BizAutocomplete, BizAccountListCard, BizAccountReorderList, BizColorPicker, BizColorPickerSheet, BizColorPickerAlert, BizColorPickerIsland, BizNavigationDrawer, BizNavigationRail, BizDynamicIsland, BizCollapse, BizCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
