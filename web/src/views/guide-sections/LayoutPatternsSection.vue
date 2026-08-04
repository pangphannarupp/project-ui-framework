<template>
  <div class="guide-section">
    <div class="section-header">
      <h2>Mobile Layout Patterns</h2>
      <p>A collection of standard mobile layout patterns built using the UI framework's components.</p>
    </div>

    <div class="section-content">
      
      <div class="variant-group">
        <h3>1. Bottom Navigation Layout</h3>
        <p class="guide-desc">A classic layout featuring a persistent bottom navigation bar for top-level destinations.</p>
        <div class="component-demo" style="background: transparent;">
          <BottomNavScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>2. Hamburger Drawer Layout</h3>
        <p class="guide-desc">A layout utilizing a sidebar navigation drawer triggered from the app bar.</p>
        <div class="component-demo" style="background: transparent;">
          <HamburgerDrawerScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>3. Tabbed Layout</h3>
        <p class="guide-desc">Using tabs below the header to organize content into distinct categories.</p>
        <div class="component-demo" style="background: transparent;">
          <TabbedScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>4. Card Layout</h3>
        <p class="guide-desc">A vertical feed focused on large, visually distinct cards, perfect for news or social media.</p>
        <div class="component-demo" style="background: transparent;">
          <CardLayoutScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>5. Grid Layout</h3>
        <p class="guide-desc">A grid or masonry style layout suitable for image galleries or dashboards.</p>
        <div class="component-demo" style="background: transparent;">
          <GridLayoutScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>6. Full Screen Hero</h3>
        <p class="guide-desc">An immersive layout dominated by a background visual, often used for onboarding.</p>
        <div class="component-demo" style="background: transparent;">
          <FullScreenHeroScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>7. List with FAB</h3>
        <p class="guide-desc">A standard list view with a primary Floating Action Button (FAB) in the corner.</p>
        <div class="component-demo" style="background: transparent;">
          <ListFabScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>8. Carousel Layout</h3>
        <p class="guide-desc">Combining a horizontal scrolling carousel for featured items with a vertical list.</p>
        <div class="component-demo" style="background: transparent;">
          <CarouselLayoutScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>9. Backdrop Layout</h3>
        <p class="guide-desc">A material pattern with a background filter/control layer and a foreground content layer.</p>
        <div class="component-demo" style="background: transparent;">
          <BackdropScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>10. Master Detail Layout</h3>
        <p class="guide-desc">A split-pane layout ideal for larger viewports or tablets, showing a list alongside details.</p>
        <div class="component-demo" style="background: transparent;">
          <MasterDetailScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>11. Profile & Settings Layout</h3>
        <p class="guide-desc">A layout featuring an avatar header and grouped list sections for settings and preferences.</p>
        <div class="component-demo" style="background: transparent;">
          <ProfileSettingsScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>12. Chat / Messaging Layout</h3>
        <p class="guide-desc">A conversational interface with a scrollable message history and sticky bottom input.</p>
        <div class="component-demo" style="background: transparent;">
          <ChatMessagingScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>13. Dashboard / Analytics Layout</h3>
        <p class="guide-desc">A data-heavy layout with summary metric cards, charts, and a recent activity feed.</p>
        <div class="component-demo" style="background: transparent;">
          <DashboardAnalyticsScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>14. Map-centric Layout</h3>
        <p class="guide-desc">A full-screen map interface with a floating search bar and a bottom details sheet.</p>
        <div class="component-demo" style="background: transparent;">
          <MapCentricScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>15. Wizard / Stepped Form Layout</h3>
        <p class="guide-desc">A multi-step form layout with a progress bar and sticky bottom action buttons.</p>
        <div class="component-demo" style="background: transparent;">
          <WizardFormScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>16. E-commerce Product Layout</h3>
        <p class="guide-desc">A classic shopping layout featuring a large image gallery, product details, and a sticky Add to Cart button.</p>
        <div class="component-demo" style="background: transparent;">
          <EcommerceProductScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>17. Media Player Layout</h3>
        <p class="guide-desc">An immersive playback layout with large album art, scrubber, and playback controls.</p>
        <div class="component-demo" style="background: transparent;">
          <MediaPlayerScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>18. Calendar / Agenda Layout</h3>
        <p class="guide-desc">A productivity layout featuring a horizontal date selector and vertical time-blocked agenda.</p>
        <div class="component-demo" style="background: transparent;">
          <CalendarAgendaScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>19. Immersive Social Feed</h3>
        <p class="guide-desc">A full-screen vertical snapping layout with floating right-side action buttons.</p>
        <div class="component-demo" style="background: transparent;">
          <SocialFeedScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>20. Wallet / Financial Layout</h3>
        <p class="guide-desc">A fintech layout with a prominent top balance card, quick actions, and recent transactions list.</p>
        <div class="component-demo" style="background: transparent;">
          <WalletFinancialScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>21. Food Delivery / Restaurant Menu Layout</h3>
        <p class="guide-desc">A delivery app layout with a hero image, horizontal sticky categories, vertical menu items, and a floating View Cart button.</p>
        <div class="component-demo" style="background: transparent;">
          <FoodDeliveryScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>22. Fitness / Workout Tracker Layout</h3>
        <p class="guide-desc">A health layout with a circular progress ring, daily stat summaries, and an activity timeline.</p>
        <div class="component-demo" style="background: transparent;">
          <FitnessTrackerScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>23. Smart Home IoT Dashboard</h3>
        <p class="guide-desc">A grid-based layout for controlling devices with status summaries and toggleable cards.</p>
        <div class="component-demo" style="background: transparent;">
          <SmartHomeDashboardScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>24. Dating / Swiping Layout</h3>
        <p class="guide-desc">A full-screen stacked card layout with prominent photos, details overlays, and circular action buttons.</p>
        <div class="component-demo" style="background: transparent;">
          <DatingSwipeScreen />
        </div>
      </div>

      <div class="variant-group">
        <h3>25. Podcast / Audiobook Player Layout</h3>
        <p class="guide-desc">A spoken-word media layout featuring a prominent cover, 15s skips, speed controls, and a sleep timer.</p>
        <div class="component-demo" style="background: transparent;">
          <PodcastPlayerScreen />
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import BottomNavScreen from './screens/BottomNavScreen.vue';
import HamburgerDrawerScreen from './screens/HamburgerDrawerScreen.vue';
import TabbedScreen from './screens/TabbedScreen.vue';
import CardLayoutScreen from './screens/CardLayoutScreen.vue';
import GridLayoutScreen from './screens/GridLayoutScreen.vue';
import FullScreenHeroScreen from './screens/FullScreenHeroScreen.vue';
import ListFabScreen from './screens/ListFabScreen.vue';
import CarouselLayoutScreen from './screens/CarouselLayoutScreen.vue';
import BackdropScreen from './screens/BackdropScreen.vue';
import MasterDetailScreen from './screens/MasterDetailScreen.vue';
import ProfileSettingsScreen from './screens/ProfileSettingsScreen.vue';
import ChatMessagingScreen from './screens/ChatMessagingScreen.vue';
import DashboardAnalyticsScreen from './screens/DashboardAnalyticsScreen.vue';
import MapCentricScreen from './screens/MapCentricScreen.vue';
import WizardFormScreen from './screens/WizardFormScreen.vue';
import EcommerceProductScreen from './screens/EcommerceProductScreen.vue';
import MediaPlayerScreen from './screens/MediaPlayerScreen.vue';
import CalendarAgendaScreen from './screens/CalendarAgendaScreen.vue';
import SocialFeedScreen from './screens/SocialFeedScreen.vue';
import WalletFinancialScreen from './screens/WalletFinancialScreen.vue';
import FoodDeliveryScreen from './screens/FoodDeliveryScreen.vue';
import FitnessTrackerScreen from './screens/FitnessTrackerScreen.vue';
import SmartHomeDashboardScreen from './screens/SmartHomeDashboardScreen.vue';
import DatingSwipeScreen from './screens/DatingSwipeScreen.vue';
import PodcastPlayerScreen from './screens/PodcastPlayerScreen.vue';
</script>

<style scoped>
/* Inherits global guide styles */
</style>
