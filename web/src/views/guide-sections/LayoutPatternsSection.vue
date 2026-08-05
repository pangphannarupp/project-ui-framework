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
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
    &lt;div class="section-header"&gt;
      &lt;h2&gt;Mobile Layout Patterns&lt;/h2&gt;
      &lt;p&gt;A collection of standard mobile layout patterns built using the UI framework's components.&lt;/p&gt;
    &lt;/div&gt;

    &lt;div class="section-content"&gt;
      
      &lt;div class="variant-group"&gt;
        &lt;h3&gt;1. Bottom Navigation Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A classic layout featuring a persistent bottom navigation bar for top-level destinations.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;BottomNavScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;2. Hamburger Drawer Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A layout utilizing a sidebar navigation drawer triggered from the app bar.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;HamburgerDrawerScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;3. Tabbed Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;Using tabs below the header to organize content into distinct categories.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;TabbedScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;4. Card Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A vertical feed focused on large, visually distinct cards, perfect for news or social media.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;CardLayoutScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;5. Grid Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A grid or masonry style layout suitable for image galleries or dashboards.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;GridLayoutScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;6. Full Screen Hero&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;An immersive layout dominated by a background visual, often used for onboarding.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;FullScreenHeroScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;7. List with FAB&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A standard list view with a primary Floating Action Button (FAB) in the corner.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;ListFabScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;8. Carousel Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;Combining a horizontal scrolling carousel for featured items with a vertical list.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;CarouselLayoutScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;9. Backdrop Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A material pattern with a background filter/control layer and a foreground content layer.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;BackdropScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;10. Master Detail Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A split-pane layout ideal for larger viewports or tablets, showing a list alongside details.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;MasterDetailScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;11. Profile &amp; Settings Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A layout featuring an avatar header and grouped list sections for settings and preferences.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;ProfileSettingsScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;12. Chat / Messaging Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A conversational interface with a scrollable message history and sticky bottom input.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;ChatMessagingScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;13. Dashboard / Analytics Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A data-heavy layout with summary metric cards, charts, and a recent activity feed.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;DashboardAnalyticsScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;14. Map-centric Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A full-screen map interface with a floating search bar and a bottom details sheet.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;MapCentricScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;15. Wizard / Stepped Form Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A multi-step form layout with a progress bar and sticky bottom action buttons.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;WizardFormScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;16. E-commerce Product Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A classic shopping layout featuring a large image gallery, product details, and a sticky Add to Cart button.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;EcommerceProductScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;17. Media Player Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;An immersive playback layout with large album art, scrubber, and playback controls.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;MediaPlayerScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;18. Calendar / Agenda Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A productivity layout featuring a horizontal date selector and vertical time-blocked agenda.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;CalendarAgendaScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;19. Immersive Social Feed&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A full-screen vertical snapping layout with floating right-side action buttons.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;SocialFeedScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;20. Wallet / Financial Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A fintech layout with a prominent top balance card, quick actions, and recent transactions list.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;WalletFinancialScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;21. Food Delivery / Restaurant Menu Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A delivery app layout with a hero image, horizontal sticky categories, vertical menu items, and a floating View Cart button.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;FoodDeliveryScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;22. Fitness / Workout Tracker Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A health layout with a circular progress ring, daily stat summaries, and an activity timeline.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;FitnessTrackerScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;23. Smart Home IoT Dashboard&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A grid-based layout for controlling devices with status summaries and toggleable cards.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;SmartHomeDashboardScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;24. Dating / Swiping Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A full-screen stacked card layout with prominent photos, details overlays, and circular action buttons.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;DatingSwipeScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class="variant-group"&gt;
        &lt;h3&gt;25. Podcast / Audiobook Player Layout&lt;/h3&gt;
        &lt;p class="guide-desc"&gt;A spoken-word media layout featuring a prominent cover, 15s skips, speed controls, and a sleep timer.&lt;/p&gt;
        &lt;div class="component-demo" style="background: transparent;"&gt;
          &lt;PodcastPlayerScreen /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
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
&lt;/script&gt;

&lt;style scoped&gt;
/* Inherits global guide styles */
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
