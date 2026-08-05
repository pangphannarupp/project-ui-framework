<template>
<div class="guide-section">
        <h2>Collapsing Appbar</h2>
        <div class="variant-group">
          <h3>Scroll to Collapse</h3>
          <p class="custom-guide">A Material Design style collapsing toolbar. Scroll the content below to see it shrink!</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <img src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <template #profile>
                <img src="https://i.pravatar.cc/150?img=68" alt="Profile" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; object-fit: cover; box-shadow: 0 2px 4px rgba(0,0,0,0.2);" />
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56"&gt;
  &lt;template #background&gt;
    &lt;img src="..." alt="bg" /&gt;
  &lt;/template&gt;
  &lt;template #start&gt;
    &lt;PPIconButton color="white"&gt;
      &lt;!-- Back Icon --&gt;
    &lt;/PPIconButton&gt;
  &lt;/template&gt;
  &lt;template #profile&gt;
    &lt;img src="..." alt="Profile" class="avatar" /&gt;
  &lt;/template&gt;
  
  &lt;div class="content"&gt;
    &lt;!-- Scrollable content --&gt;
  &lt;/div&gt;
&lt;/PPCollapsingToolbar&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Standard Header (No Profile)</h3>
          <p class="custom-guide">Without a profile picture, the title scales and aligns correctly by itself. Here it moves to the center when collapsed.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <img src="https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse&gt;
  &lt;template #background&gt;
    &lt;img src="..." alt="bg" /&gt;
  &lt;/template&gt;
  &lt;template #start&gt;
    &lt;PPIconButton color="white"&gt;
      &lt;!-- Back Icon --&gt;
    &lt;/PPIconButton&gt;
  &lt;/template&gt;
  
  &lt;div class="content"&gt;
    &lt;!-- Scrollable content --&gt;
  &lt;/div&gt;
&lt;/PPCollapsingToolbar&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Gradient Background & Icon Profile</h3>
          <p class="custom-guide">A vibrant gradient background with an icon instead of an image for the profile.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Plugin Details" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #ff4081 0%, #ffe0b2 50%, #81d4fa 100%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <template #profile>
                <div style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; background-color: white; display: flex; align-items: center; justify-content: center; color: #ff4081;">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="18" height="18"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                </div>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 5" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. This style is great for dynamic plugin pages!
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Solid Color with Actions</h3>
          <p class="custom-guide">A solid color background using the end slot for actions like search and settings.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Settings" :expandedHeight="150" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <div style="width: 100%; height: 100%; background-color: var(--pp-primary, #007aff);"></div>
              </template>
              
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>

              <template #end>
                <div style="display: flex; gap: 4px; align-items: center;">
                  <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></PPIconButton>
                  <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg></PPIconButton>
                </div>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  List item {{ i }}. This style allows adding quick actions directly on the appbar.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
        <div class="variant-group">
          <h3>Sticky Segment (Tabs)</h3>
          <p class="custom-guide">A segment control that scrolls with the content but sticks to the bottom of the collapsed header.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Transactions" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <!-- Sticky Segment Container -->
              <div style="position: sticky; top: 56px; z-index: 20; background: white; padding: 8px 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);">
                <div style="display: flex; background: #f1f5f9; border-radius: 8px; padding: 4px;">
                  <div style="flex: 1; text-align: center; padding: 6px; background: white; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); font-weight: 500; font-size: 14px;">Recent</div>
                  <div style="flex: 1; text-align: center; padding: 6px; border-radius: 6px; color: #64748b; font-weight: 500; font-size: 14px;">Scheduled</div>
                </div>
              </div>
              
              <div style="padding: 16px 24px;">
                <p v-for="i in 12" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable item {{ i }}. Notice how the segment tabs stick right under the header when you scroll down.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Floating Header Style</h3>
          <p class="custom-guide">By using CSS overrides, you can make the expanded header look like a floating island.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f8fafc;">
            <PPCollapsingToolbar title="Overview" :expandedHeight="220" :collapsedHeight="64" class="floating-collapse-appbar">
              <template #background>
                <div style="width: 100%; height: 100%; background: #ffffff; border-radius: 20px; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent" style="color: #1e293b;"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; padding-top: 32px;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Floating content {{ i }}. This style pushes the header inward using CSS.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
        <div class="variant-group">
          <h3>Glassmorphism (Frosted Glass)</h3>
          <p class="custom-guide">A premium iOS-style blurred glass effect using backdrop-filter. This requires a background image and a translucent overlay.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Discover" :expandedHeight="220" :collapsedHeight="60">
              <template #background>
                <!-- Base image -->
                <div style="position: absolute; inset: 0;">
                  <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=1000&auto=format&fit=crop" alt="bg" style="width: 100%; height: 100%; object-fit: cover;" />
                </div>
                <!-- Glass overlay -->
                <div style="position: absolute; inset: 0; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255, 255, 255, 0.3);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              <template #end>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scroll up to see the beautiful frosted glass effect compress. The background image blurs heavily under the title.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Dark Mode Aesthetic</h3>
          <p class="custom-guide">A sleek, dark-themed header with subtle glowing accents.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #0f172a;">
            <PPCollapsingToolbar title="Wallet" :expandedHeight="200" :collapsedHeight="56" class="dark-collapse-appbar">
              <template #background>
                <div style="width: 100%; height: 100%; background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%); position: relative; overflow: hidden;">
                  <!-- Glowing orb -->
                  <div style="position: absolute; top: -50px; right: -20px; width: 150px; height: 150px; background: #3b82f6; border-radius: 50%; filter: blur(60px); opacity: 0.5;"></div>
                  <div style="position: absolute; bottom: 0; left: 0; right: 0; height: 1px; background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.5), transparent);"></div>
                </div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; color: #cbd5e1;">
                <p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px;">
                  Dark mode content. The appbar title text is styled to be white using a CSS override.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Card Overlap Style</h3>
          <p class="custom-guide">The content scrolls over the header, creating a layered, dimensional look. Very common in modern finance apps.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f1f5f9;">
            <PPCollapsingToolbar title="Account details" :expandedHeight="240" :collapsedHeight="60">
              <template #background>
                <div style="width: 100%; height: 100%; background: #2563eb; background-image: radial-gradient(circle at 100% 0%, #3b82f6 0%, transparent 50%);"></div>
              </template>
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <!-- Overlapping Card Container -->
              <div style="padding: 0 16px; margin-top: -32px; position: relative; z-index: 1;">
                <div style="background: white; border-radius: 16px; padding: 24px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); text-align: center;">
                  <div style="font-size: 14px; color: #64748b; font-weight: 500;">Total Balance</div>
                  <div style="font-size: 32px; font-weight: 700; color: #0f172a; margin-top: 8px;">$12,450.00</div>
                  <div style="display: flex; gap: 12px; margin-top: 24px;">
                    <div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;">Transfer</div>
                    <div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;">Pay</div>
                  </div>
                </div>
                
                <div style="margin-top: 24px;">
                  <h4 style="margin: 0 0 16px 0; color: #334155;">Recent Activity</h4>
                  <div v-for="i in 8" :key="i" style="background: white; padding: 16px; border-radius: 12px; margin-bottom: 12px; display: flex; justify-content: space-between;">
                    <div>
                      <div style="font-weight: 600; color: #1e293b;">Payment {{ i }}</div>
                      <div style="font-size: 13px; color: #94a3b8; margin-top: 4px;">Today</div>
                    </div>
                    <div style="font-weight: 600; color: #ef4444;">-$45.00</div>
                  </div>
                </div>
              </div>
            </PPCollapsingToolbar>
          </div>
        <div class="variant-group">
          <h3>E-Commerce Product (Rounded Bottom)</h3>
          <p class="custom-guide">A product detail page style where the header contains the product image with rounded bottom corners, collapsing into a solid bar.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f8fafc;">
            <PPCollapsingToolbar title="Wireless Headphones" :expandedHeight="260" :collapsedHeight="60" class="ecommerce-sliver">
              <template #background>
                <div style="width: 100%; height: 100%; background: #ffffff; border-bottom-left-radius: 32px; border-bottom-right-radius: 32px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                  <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop" alt="Product" style="width: 80%; height: 80%; object-fit: contain; margin-bottom: 20px;" />
                </div>
              </template>
              <template #start>
                <PPIconButton color="transparent" style="color: #0f172a; background: rgba(255,255,255,0.7) !important; border-radius: 50%;"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              <template #end>
                <PPIconButton color="transparent" style="color: #0f172a; background: rgba(255,255,255,0.7) !important; border-radius: 50%;"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; padding-top: 48px;">
                <h2 style="margin: 0; color: #0f172a; font-size: 24px;">Sony WH-1000XM4</h2>
                <div style="color: #2563eb; font-weight: bold; font-size: 20px; margin-top: 8px;">$348.00</div>
                <div style="margin-top: 16px; display: flex; gap: 8px;">
                  <span style="background: #f1f5f9; padding: 4px 12px; border-radius: 16px; font-size: 12px; font-weight: 500;">Noise Cancelling</span>
                  <span style="background: #f1f5f9; padding: 4px 12px; border-radius: 16px; font-size: 12px; font-weight: 500;">Bluetooth 5.0</span>
                </div>
                <p v-for="i in 5" :key="i" style="margin-top: 20px; font-size: 15px; color: #475569; line-height: 1.6;">
                  Product description block {{ i }}. Scroll down to see the product image disappear and the header pin to the top.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

        <div class="variant-group">
          <h3>Parallax Image with Integrated Search</h3>
          <p class="custom-guide">A large destination image that contains a search bar inside the expanded area. A classic travel/booking app layout.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Explore" :expandedHeight="280" :collapsedHeight="64">
              <template #background>
                <div style="position: absolute; inset: 0;">
                  <img src="https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=1000&auto=format&fit=crop" alt="Travel" style="width: 100%; height: 100%; object-fit: cover;" />
                  <div style="position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0) 50%, rgba(0,0,0,0.6) 100%);"></div>
                </div>
                
                <!-- Search bar injected into background so it scrolls with parallax -->
                <div style="position: absolute; bottom: 32px; left: 24px; right: 24px; z-index: 2;">
                  <div style="background: white; border-radius: 24px; padding: 12px 20px; display: flex; align-items: center; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">
                    <svg viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" width="20" height="20" style="margin-right: 12px;"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="text" placeholder="Where do you want to go?" style="border: none; background: transparent; outline: none; width: 100%; font-size: 15px; color: #0f172a;" />
                  </div>
                </div>
              </template>
              
              <template #start>
                <PPIconButton color="transparent"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px; background: white; min-height: 400px; border-top-left-radius: 24px; border-top-right-radius: 24px; position: relative; z-index: 2;">
                <h3 style="margin-top: 0;">Top Destinations</h3>
                <div style="display: flex; gap: 16px; overflow-x: auto; padding-bottom: 16px; margin-top: 16px;">
                  <div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"></div>
                  <div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"></div>
                  <div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"></div>
                </div>
                <p v-for="i in 5" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Discover places block {{ i }}.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>

      </div>
    
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-app-bar-bg: /* value */;
  --pp-app-bar-color: /* value */;
  --pp-app-bar-height: /* value */;
  --pp-app-bar-pb: /* value */;
  --pp-app-bar-pt: /* value */;
  --pp-app-bar-radius: /* value */;
  --pp-app-bar-title-size: /* value */;
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
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
        &lt;h2&gt;Collapsing Appbar&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Scroll to Collapse&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A Material Design style collapsing toolbar. Scroll the content below to see it shrink!&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56"&gt;
              &lt;template #background&gt;
                &lt;img src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" alt="bg" /&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;template #profile&gt;
                &lt;img src="https://i.pravatar.cc/150?img=68" alt="Profile" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; object-fit: cover; box-shadow: 0 2px 4px rgba(0,0,0,0.2);" /&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px;"&gt;
                &lt;p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56"&amp;gt;
  &amp;lt;template #background&amp;gt;
    &amp;lt;img src="..." alt="bg" /&amp;gt;
  &amp;lt;/template&amp;gt;
  &amp;lt;template #start&amp;gt;
    &amp;lt;PPIconButton color="white"&amp;gt;
      &amp;lt;!-- Back Icon --&amp;gt;
    &amp;lt;/PPIconButton&amp;gt;
  &amp;lt;/template&amp;gt;
  &amp;lt;template #profile&amp;gt;
    &amp;lt;img src="..." alt="Profile" class="avatar" /&amp;gt;
  &amp;lt;/template&amp;gt;
  
  &amp;lt;div class="content"&amp;gt;
    &amp;lt;!-- Scrollable content --&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/PPCollapsingToolbar&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Header (No Profile)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Without a profile picture, the title scales and aligns correctly by itself. Here it moves to the center when collapsed.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse&gt;
              &lt;template #background&gt;
                &lt;img src="https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" alt="bg" /&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px;"&gt;
                &lt;p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse&amp;gt;
  &amp;lt;template #background&amp;gt;
    &amp;lt;img src="..." alt="bg" /&amp;gt;
  &amp;lt;/template&amp;gt;
  &amp;lt;template #start&amp;gt;
    &amp;lt;PPIconButton color="white"&amp;gt;
      &amp;lt;!-- Back Icon --&amp;gt;
    &amp;lt;/PPIconButton&amp;gt;
  &amp;lt;/template&amp;gt;
  
  &amp;lt;div class="content"&amp;gt;
    &amp;lt;!-- Scrollable content --&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/PPCollapsingToolbar&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Gradient Background &amp; Icon Profile&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A vibrant gradient background with an icon instead of an image for the profile.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Plugin Details" :expandedHeight="200" :collapsedHeight="56"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: linear-gradient(135deg, #ff4081 0%, #ffe0b2 50%, #81d4fa 100%);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;template #profile&gt;
                &lt;div style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; background-color: white; display: flex; align-items: center; justify-content: center; color: #ff4081;"&gt;
                  &lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="18" height="18"&gt;&lt;path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/&gt;&lt;/svg&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px;"&gt;
                &lt;p v-for="i in 5" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Scrollable content block {{ i }}. This style is great for dynamic plugin pages!
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Solid Color with Actions&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A solid color background using the end slot for actions like search and settings.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Settings" :expandedHeight="150" :collapsedHeight="56" centerTitleOnCollapse&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background-color: var(--pp-primary, #007aff);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;

              &lt;template #end&gt;
                &lt;div style="display: flex; gap: 4px; align-items: center;"&gt;
                  &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;circle cx="11" cy="11" r="8"&gt;&lt;/circle&gt;&lt;line x1="21" y1="21" x2="16.65" y2="16.65"&gt;&lt;/line&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
                  &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;circle cx="12" cy="12" r="3"&gt;&lt;/circle&gt;&lt;path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"&gt;&lt;/path&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px;"&gt;
                &lt;p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  List item {{ i }}. This style allows adding quick actions directly on the appbar.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Sticky Segment (Tabs)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A segment control that scrolls with the content but sticks to the bottom of the collapsed header.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Transactions" :expandedHeight="200" :collapsedHeight="56"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: linear-gradient(to right, #4facfe 0%, #00f2fe 100%);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;!-- Sticky Segment Container --&gt;
              &lt;div style="position: sticky; top: 56px; z-index: 20; background: white; padding: 8px 16px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);"&gt;
                &lt;div style="display: flex; background: #f1f5f9; border-radius: 8px; padding: 4px;"&gt;
                  &lt;div style="flex: 1; text-align: center; padding: 6px; background: white; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); font-weight: 500; font-size: 14px;"&gt;Recent&lt;/div&gt;
                  &lt;div style="flex: 1; text-align: center; padding: 6px; border-radius: 6px; color: #64748b; font-weight: 500; font-size: 14px;"&gt;Scheduled&lt;/div&gt;
                &lt;/div&gt;
              &lt;/div&gt;
              
              &lt;div style="padding: 16px 24px;"&gt;
                &lt;p v-for="i in 12" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Scrollable item {{ i }}. Notice how the segment tabs stick right under the header when you scroll down.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Floating Header Style&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;By using CSS overrides, you can make the expanded header look like a floating island.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f8fafc;"&gt;
            &lt;PPCollapsingToolbar title="Overview" :expandedHeight="220" :collapsedHeight="64" class="floating-collapse-appbar"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: #ffffff; border-radius: 20px; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.1);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent" style="color: #1e293b;"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px; padding-top: 32px;"&gt;
                &lt;p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Floating content {{ i }}. This style pushes the header inward using CSS.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Glassmorphism (Frosted Glass)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A premium iOS-style blurred glass effect using backdrop-filter. This requires a background image and a translucent overlay.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Discover" :expandedHeight="220" :collapsedHeight="60"&gt;
              &lt;template #background&gt;
                &lt;!-- Base image --&gt;
                &lt;div style="position: absolute; inset: 0;"&gt;
                  &lt;img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" alt="bg" style="width: 100%; height: 100%; object-fit: cover;" /&gt;
                &lt;/div&gt;
                &lt;!-- Glass overlay --&gt;
                &lt;div style="position: absolute; inset: 0; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255, 255, 255, 0.3);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              &lt;template #end&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;circle cx="11" cy="11" r="8"&gt;&lt;/circle&gt;&lt;line x1="21" y1="21" x2="16.65" y2="16.65"&gt;&lt;/line&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px;"&gt;
                &lt;p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Scroll up to see the beautiful frosted glass effect compress. The background image blurs heavily under the title.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Dark Mode Aesthetic&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A sleek, dark-themed header with subtle glowing accents.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #0f172a;"&gt;
            &lt;PPCollapsingToolbar title="Wallet" :expandedHeight="200" :collapsedHeight="56" class="dark-collapse-appbar"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%); position: relative; overflow: hidden;"&gt;
                  &lt;!-- Glowing orb --&gt;
                  &lt;div style="position: absolute; top: -50px; right: -20px; width: 150px; height: 150px; background: #3b82f6; border-radius: 50%; filter: blur(60px); opacity: 0.5;"&gt;&lt;/div&gt;
                  &lt;div style="position: absolute; bottom: 0; left: 0; right: 0; height: 1px; background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.5), transparent);"&gt;&lt;/div&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px; color: #cbd5e1;"&gt;
                &lt;p v-for="i in 8" :key="i" style="margin-bottom: 20px; font-size: 16px;"&gt;
                  Dark mode content. The appbar title text is styled to be white using a CSS override.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Card Overlap Style&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;The content scrolls over the header, creating a layered, dimensional look. Very common in modern finance apps.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f1f5f9;"&gt;
            &lt;PPCollapsingToolbar title="Account details" :expandedHeight="240" :collapsedHeight="60"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: #2563eb; background-image: radial-gradient(circle at 100% 0%, #3b82f6 0%, transparent 50%);"&gt;&lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;!-- Overlapping Card Container --&gt;
              &lt;div style="padding: 0 16px; margin-top: -32px; position: relative; z-index: 1;"&gt;
                &lt;div style="background: white; border-radius: 16px; padding: 24px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); text-align: center;"&gt;
                  &lt;div style="font-size: 14px; color: #64748b; font-weight: 500;"&gt;Total Balance&lt;/div&gt;
                  &lt;div style="font-size: 32px; font-weight: 700; color: #0f172a; margin-top: 8px;"&gt;$12,450.00&lt;/div&gt;
                  &lt;div style="display: flex; gap: 12px; margin-top: 24px;"&gt;
                    &lt;div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;"&gt;Transfer&lt;/div&gt;
                    &lt;div style="flex: 1; padding: 12px; background: #eff6ff; color: #2563eb; border-radius: 12px; font-weight: 600;"&gt;Pay&lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
                
                &lt;div style="margin-top: 24px;"&gt;
                  &lt;h4 style="margin: 0 0 16px 0; color: #334155;"&gt;Recent Activity&lt;/h4&gt;
                  &lt;div v-for="i in 8" :key="i" style="background: white; padding: 16px; border-radius: 12px; margin-bottom: 12px; display: flex; justify-content: space-between;"&gt;
                    &lt;div&gt;
                      &lt;div style="font-weight: 600; color: #1e293b;"&gt;Payment {{ i }}&lt;/div&gt;
                      &lt;div style="font-size: 13px; color: #94a3b8; margin-top: 4px;"&gt;Today&lt;/div&gt;
                    &lt;/div&gt;
                    &lt;div style="font-weight: 600; color: #ef4444;"&gt;-$45.00&lt;/div&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;E-Commerce Product (Rounded Bottom)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A product detail page style where the header contains the product image with rounded bottom corners, collapsing into a solid bar.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative; background: #f8fafc;"&gt;
            &lt;PPCollapsingToolbar title="Wireless Headphones" :expandedHeight="260" :collapsedHeight="60" class="ecommerce-sliver"&gt;
              &lt;template #background&gt;
                &lt;div style="width: 100%; height: 100%; background: #ffffff; border-bottom-left-radius: 32px; border-bottom-right-radius: 32px; overflow: hidden; display: flex; align-items: center; justify-content: center;"&gt;
                  &lt;img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" alt="Product" style="width: 80%; height: 80%; object-fit: contain; margin-bottom: 20px;" /&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent" style="color: #0f172a; background: rgba(255,255,255,0.7) !important; border-radius: 50%;"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20"&gt;&lt;path d="M19 12H5M12 19l-7-7 7-7"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              &lt;template #end&gt;
                &lt;PPIconButton color="transparent" style="color: #0f172a; background: rgba(255,255,255,0.7) !important; border-radius: 50%;"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20"&gt;&lt;path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px; padding-top: 48px;"&gt;
                &lt;h2 style="margin: 0; color: #0f172a; font-size: 24px;"&gt;Sony WH-1000XM4&lt;/h2&gt;
                &lt;div style="color: #2563eb; font-weight: bold; font-size: 20px; margin-top: 8px;"&gt;$348.00&lt;/div&gt;
                &lt;div style="margin-top: 16px; display: flex; gap: 8px;"&gt;
                  &lt;span style="background: #f1f5f9; padding: 4px 12px; border-radius: 16px; font-size: 12px; font-weight: 500;"&gt;Noise Cancelling&lt;/span&gt;
                  &lt;span style="background: #f1f5f9; padding: 4px 12px; border-radius: 16px; font-size: 12px; font-weight: 500;"&gt;Bluetooth 5.0&lt;/span&gt;
                &lt;/div&gt;
                &lt;p v-for="i in 5" :key="i" style="margin-top: 20px; font-size: 15px; color: #475569; line-height: 1.6;"&gt;
                  Product description block {{ i }}. Scroll down to see the product image disappear and the header pin to the top.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Parallax Image with Integrated Search&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;A large destination image that contains a search bar inside the expanded area. A classic travel/booking app layout.&lt;/p&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;"&gt;
            &lt;PPCollapsingToolbar title="Explore" :expandedHeight="280" :collapsedHeight="64"&gt;
              &lt;template #background&gt;
                &lt;div style="position: absolute; inset: 0;"&gt;
                  &lt;img src="https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" alt="Travel" style="width: 100%; height: 100%; object-fit: cover;" /&gt;
                  &lt;div style="position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0) 50%, rgba(0,0,0,0.6) 100%);"&gt;&lt;/div&gt;
                &lt;/div&gt;
                
                &lt;!-- Search bar injected into background so it scrolls with parallax --&gt;
                &lt;div style="position: absolute; bottom: 32px; left: 24px; right: 24px; z-index: 2;"&gt;
                  &lt;div style="background: white; border-radius: 24px; padding: 12px 20px; display: flex; align-items: center; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"&gt;
                    &lt;svg viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" width="20" height="20" style="margin-right: 12px;"&gt;&lt;circle cx="11" cy="11" r="8"&gt;&lt;/circle&gt;&lt;line x1="21" y1="21" x2="16.65" y2="16.65"&gt;&lt;/line&gt;&lt;/svg&gt;
                    &lt;input type="text" placeholder="Where do you want to go?" style="border: none; background: transparent; outline: none; width: 100%; font-size: 15px; color: #0f172a;" /&gt;
                  &lt;/div&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              
              &lt;template #start&gt;
                &lt;PPIconButton color="transparent"&gt;&lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"&gt;&lt;line x1="3" y1="12" x2="21" y2="12"&gt;&lt;/line&gt;&lt;line x1="3" y1="6" x2="21" y2="6"&gt;&lt;/line&gt;&lt;line x1="3" y1="18" x2="21" y2="18"&gt;&lt;/line&gt;&lt;/svg&gt;&lt;/PPIconButton&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 24px; background: white; min-height: 400px; border-top-left-radius: 24px; border-top-right-radius: 24px; position: relative; z-index: 2;"&gt;
                &lt;h3 style="margin-top: 0;"&gt;Top Destinations&lt;/h3&gt;
                &lt;div style="display: flex; gap: 16px; overflow-x: auto; padding-bottom: 16px; margin-top: 16px;"&gt;
                  &lt;div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"&gt;&lt;/div&gt;
                  &lt;div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"&gt;&lt;/div&gt;
                  &lt;div style="min-width: 120px; height: 160px; border-radius: 12px; background: #e2e8f0;"&gt;&lt;/div&gt;
                &lt;/div&gt;
                &lt;p v-for="i in 5" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;"&gt;
                  Discover places block {{ i }}.
                &lt;/p&gt;
              &lt;/div&gt;
            &lt;/PPCollapsingToolbar&gt;
          &lt;/div&gt;
        &lt;/div&gt;

      &lt;/div&gt;
    
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-app-bar-bg: /* value */;
  --pp-app-bar-color: /* value */;
  --pp-app-bar-height: /* value */;
  --pp-app-bar-pb: /* value */;
  --pp-app-bar-pt: /* value */;
  --pp-app-bar-radius: /* value */;
  --pp-app-bar-title-size: /* value */;
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { PPCollapsingToolbar, PPIconButton } from '@phanna/ui-framework';
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  padding: 16px;
}
.custom-guide {
  color: #64748b;
  margin-bottom: 16px;
}
.code-block {
  background: #1e293b;
  color: #e2e8f0;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  margin-top: 16px;
}
.floating-collapse-appbar :deep(.pp-collapsing-header) {
  margin: 16px;
  width: calc(100% - 32px);
  border-radius: 20px;
  background: transparent;
  box-shadow: none;
}
.floating-collapse-appbar :deep(.pp-collapsing-title) {
  color: #1e293b;
}

/* Fallback for transparent icon button until framework rebuild cache is cleared */
:deep(.pp-icon-btn--transparent) {
  background-color: transparent !important;
  color: inherit;
  box-shadow: none !important;
}
:deep(.pp-icon-btn--transparent:active) {
  background-color: rgba(0, 0, 0, 0.1) !important;
}
:deep(.floating-collapse-appbar .pp-icon-btn--transparent) {
  color: #1e293b !important;
}
:deep(.pp-collapsing-header:not(.floating-collapse-appbar) .pp-icon-btn--transparent) {
  color: #ffffff;
}
.dark-collapse-appbar :deep(.pp-collapsing-title) {
  color: #ffffff !important;
}
.ecommerce-sliver :deep(.pp-collapsing-header.collapsed) {
  background: white !important;
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
}
.ecommerce-sliver :deep(.pp-collapsing-title) {
  color: #0f172a !important;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { PPCollapsingToolbar, PPIconButton } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section {
  padding: 16px;
}
.custom-guide {
  color: #64748b;
  margin-bottom: 16px;
}
.code-block {
  background: #1e293b;
  color: #e2e8f0;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  margin-top: 16px;
}
.floating-collapse-appbar :deep(.pp-collapsing-header) {
  margin: 16px;
  width: calc(100% - 32px);
  border-radius: 20px;
  background: transparent;
  box-shadow: none;
}
.floating-collapse-appbar :deep(.pp-collapsing-title) {
  color: #1e293b;
}

/* Fallback for transparent icon button until framework rebuild cache is cleared */
:deep(.pp-icon-btn--transparent) {
  background-color: transparent !important;
  color: inherit;
  box-shadow: none !important;
}
:deep(.pp-icon-btn--transparent:active) {
  background-color: rgba(0, 0, 0, 0.1) !important;
}
:deep(.floating-collapse-appbar .pp-icon-btn--transparent) {
  color: #1e293b !important;
}
:deep(.pp-collapsing-header:not(.floating-collapse-appbar) .pp-icon-btn--transparent) {
  color: #ffffff;
}
.dark-collapse-appbar :deep(.pp-collapsing-title) {
  color: #ffffff !important;
}
.ecommerce-sliver :deep(.pp-collapsing-header.collapsed) {
  background: white !important;
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
}
.ecommerce-sliver :deep(.pp-collapsing-title) {
  color: #0f172a !important;
}
</style>
