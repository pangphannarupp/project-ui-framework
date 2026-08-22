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
  export const PPButton: any
  export const PPInput: any
  export const PPSearch: any
  export const PPSlider: any
  export const PPChip: any
  export const PPBadge: any
  export const PPCarousel: any
  export const PPCarouselItem: any
  export const PPTabs: any
  export const PPTabList: any
  export const PPTab: any
  export const PPTabPanels: any
  export const PPTabPanel: any
  export const PPScrollArea: any
  export const MyButton: any
  export const MyList: any
  const plugin: any
  export default plugin
}
