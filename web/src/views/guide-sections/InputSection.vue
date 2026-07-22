<template>
<div class="guide-section">
        <h2>6. Form Inputs</h2>
        
        <div class="variant-group">
          <h3>PPTextField Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable />
            <PPTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable />
          </div>
          <pre class="code-block"><code>&lt;PPTextField variant="outlined|filled" label="..." clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPSelect Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPSelect v-model="selectVal" label="Outlined (Default)" :options="[{label: 'Option 1', value: 1}, {label: 'Option 2', value: 2}]" placeholder="Select an option" />
            <PPSelect v-model="selectVal" variant="filled" label="Filled" :options="[{label: 'Option A', value: 'a'}, {label: 'Option B', value: 'b'}]" placeholder="Choose..." />
          </div>
          <pre class="code-block"><code>&lt;PPSelect variant="outlined|filled" label="..." :options="[...]" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPTransferList Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 32px;">
            <PPTransferList v-model="transferVal" variant="outlined" :data="transferOptions" :titles="['Available (Outlined)', 'Selected (Outlined)']" />
            <PPTransferList v-model="transferVal" variant="filled" :data="transferOptions" :titles="['Available (Filled)', 'Selected (Filled)']" />
          </div>
          <pre class="code-block"><code>&lt;PPTransferList v-model="selectedKeys" variant="outlined" :data="options" :titles="['Source', 'Target']" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Text Input</h3>
          <div class="component-demo">
            <PPInput v-model="textVal" label="Username" placeholder="Enter name" clearable />
          </div>
          <pre class="code-block"><code>&lt;PPInput v-model="text" label="Username" clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Password Input (with icon)</h3>
          <div class="component-demo">
            <PPInput v-model="textVal" label="Password" type="password" placeholder="Enter pass" clearable>
              <template #iconLeft>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
              </template>
            </PPInput>
          </div>
          <pre class="code-block"><code>&lt;PPInput type="password"&gt;
  &lt;template #iconLeft&gt;...&lt;/template&gt;
&lt;/PPInput&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Phone Input</h3>
          <div class="component-demo">
            <PPPhoneInput v-model="phoneVal" label="Phone Number" placeholder="12 *** *66" format="888 888 888" />
          </div>
          <pre class="code-block"><code>&lt;PPPhoneInput v-model="phone" countryCode="+855" format="888 888 888" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>File Upload</h3>
          <div class="component-demo">
            <PPFileUpload 
              multiple 
              accept=".pdf,image/*" 
              :maxSize="5 * 1024 * 1024"
              :files="uploadedFiles"
              @select="handleFileUpload"
              @remove="handleFileRemove"
              @retry="handleFileRetry"
              @preview="handleFilePreview"
            />
          </div>
          <pre class="code-block"><code>&lt;PPFileUpload multiple accept=".pdf,image/*" :files="files" @select="..." @preview="..." /&gt;</code></pre>
          
          <PPFilePreview v-model="previewOpen" :file="previewFile" @crop="handleCrop" />
        </div>
        
        <div class="variant-group">
          <h3>Image Cropper</h3>
          <div class="component-demo">
            <PPImageCropper 
              src="https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"
              :aspectRatio="1"
              @crop="handleCrop"
              @cancel="handleCropCancel"
            />
            <div v-if="croppedImage" style="margin-top: 20px;">
              <h4>Cropped Result:</h4>
              <img :src="croppedImage" style="max-width: 200px; border-radius: 8px;" />
            </div>
          </div>
          <pre class="code-block"><code>&lt;PPImageCropper src="..." :aspectRatio="1" @crop="..." @cancel="..." /&gt;</code></pre>
        </div>
        

        <div class="variant-group">
          <h3>OTP Input (6-digit)</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <PPOtpInput v-model="otpVal" :length="6" />
          </div>
          <pre class="code-block"><code>&lt;PPOtpInput v-model="otp" :length="6" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker</h3>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <PPColorPicker v-model="colorVal" />
            <p style="margin-top: 16px; font-weight: 500;">Selected Color: <span :style="{ color: colorVal }">{{ colorVal }}</span></p>
          </div>
          <pre class="code-block"><code>&lt;PPColorPicker v-model="color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Sheet</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerSheet&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <PPButton @click="showColorPickerSheet = true">Open Color Sheet</PPButton>
            <PPColorPickerSheet 
              v-model="showColorPickerSheet"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;PPColorPickerSheet v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Island Popup</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerIsland&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPButton @click="showColorPickerIsland = true">Open Color Picker Island</PPButton>
            <PPColorPickerIsland 
              v-model="showColorPickerIsland"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;PPColorPickerIsland v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Color Picker Alert</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerAlert&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #ddd;">
            <PPButton @click="showColorPickerAlert = true">Open Color Alert</PPButton>
            <PPColorPickerAlert 
              v-model="showColorPickerAlert"
              v-model:colorValue="colorVal"
              title="Select a Theme Color"
            />
          </div>
          <pre class="code-block"><code>&lt;PPColorPickerAlert v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
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

const previewOpen = ref(false);
const previewFile = ref<any>(null);

const handleFilePreview = (file: any) => {
  previewFile.value = file;
  previewOpen.value = true;
};

const croppedImage = ref('');

const handleCrop = (dataUrl: string) => {
  croppedImage.value = dataUrl;
};

const handleCropCancel = () => {
  alert('Crop cancelled');
};



import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonTabButton, IonIcon, IonLabel } from '@ionic/vue';

import { addOutline, shareOutline, trashOutline, cardOutline, cashOutline, mapOutline, phonePortraitOutline, settingsOutline, homeOutline, home, documentTextOutline, documentText, personOutline, person, chatbubbleOutline, chatbubble, volumeLowOutline, volumeHighOutline, menuOutline, rocketOutline, cubeOutline, calendarOutline, compassOutline, chatbubbleEllipsesOutline, lockClosedOutline, barChartOutline, layersOutline, searchOutline } from 'ionicons/icons';

import { PPButton, PPButtonGroup, PPImageTransition, PPSwipeItem, PPSlider, PPSwitch, PPBarChart, PPLineChart, PPDonutChart, PPPieChart, PPRadarChart, PPProgressGauge, PPScatterChart, PPFunnelChart, PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail, PPHideAppBar, PPBottomNav, PPFab, PPFabList, PPFabAction, PPNumberSpinner, PPRadio, PPRadioGroup, PPRating, PPCollapsingToolbar, PPPullToRefresh, PPInput, PPTextField, PPSelect, PPTransferList, PPToggleButton, PPCheckbox, PPCheckboxGroup, PPPhoneInput, PPOtpInput, PPInfoCard, PPActionCard, PPAccountCard, PPSegment, PPSegmentButton, PPCompanySelector, PPScrollSegment, PPScrollSegmentButton, PPNotificationItem, PPPinDots, PPKeypad, PPSecureKeypad, PPSecureKeyboard, PPKhmerKeyboard, PPToast, PPConfirmSheet, PPReceiveAmountSheet, PPAccountSavingCard, PPReceivingAccountSheet, PPKhmerCalendar, PPKhmerCalendarSheet, PPKhmerCalendarAlert, PPKhmerCalendarIsland, PPCalendar, PPCalendarSheet, PPCalendarAlert, PPCalendarIsland, PPFileUpload, PPImageCropper, PPFilePreview, PPMonthPicker, PPMonthPickerSheet, PPMonthPickerAlert, PPMonthPickerIsland, PPYearPicker, PPYearPickerSheet, PPYearPickerAlert, PPYearPickerIsland, PPTimePicker, PPTimePickerSheet, PPTimePickerAlert, PPTimePickerIsland, PPAutocomplete, PPAccountListCard, PPAccountReorderList, PPColorPicker, PPColorPickerSheet, PPColorPickerAlert, PPColorPickerIsland, PPNavigationDrawer, PPNavigationRail, PPDynamicIsland, PPCollapse, PPCollapseItem } from '@phanna/ui-framework';

import { KhmerDate } from '@phanna/ui-framework/dist/KhmerDate';
</script>
