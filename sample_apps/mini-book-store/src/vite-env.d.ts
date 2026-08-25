/// <reference types="vite/client" />

declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}

declare module '@phanna/ui-framework' {
  export const PPBottomSheet: any
  export const PPConfirm: any
  export const PPAlert: any
  export const PPQRCode: any
  export const PPSpinWheel: any
  export const PPProgressGauge: any
  export const PPStepper: any
  export const PPConfetti: any
  export const PPSegment: any
  export const PPSegmentButton: any
  export const PPButton: any
  export const PPInput: any
  const plugin: any
  export default plugin
}
