<template>
  <div class="p-4 space-y-6">
    <!-- Search Bar (Optional mock) -->
    <div class="w-full">
      <PPTextField placeholder="Search for clothes..." icon="search-outline" class="w-full" />
    </div>

    <!-- Product Slider (Featured) -->
    <div>
      <h2 class="text-lg font-bold mb-3">Featured</h2>
      <div class="flex overflow-x-auto gap-4 snap-x snap-mandatory pb-2 -mx-4 px-4 scrollbar-hide">
        <div v-for="featured in featuredProducts" :key="featured.id" class="snap-start flex-none w-72">
          <div 
            class="relative h-40 bg-gray-200 rounded-xl overflow-hidden cursor-pointer bg-cover bg-center"
            :style="{ backgroundImage: `url(${featured.image})` }"
            @click="$router.push(`/product/${featured.id}`)"
          >
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
            <div class="absolute bottom-3 left-3 text-white">
              <p class="font-semibold">{{ featured.name }}</p>
              <p class="text-sm opacity-90">${{ featured.price.toFixed(2) }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Categories -->
    <div>
      <h2 class="text-lg font-bold mb-3">Categories</h2>
      <div class="flex gap-2 overflow-x-auto pb-2 scrollbar-hide">
        <PPChip 
          v-for="cat in categories" 
          :key="cat" 
          :label="cat" 
          :variant="activeCategory === cat ? 'primary' : 'default'"
          @click="activeCategory = cat"
          class="cursor-pointer"
        />
      </div>
    </div>

    <!-- Product Grid -->
    <div>
      <div class="flex justify-between items-end mb-3">
        <h2 class="text-lg font-bold">New Arrivals</h2>
      </div>
      <div class="grid grid-cols-2 gap-4">
        <div 
          v-for="product in filteredProducts" 
          :key="product.id"
          class="flex flex-col gap-2 cursor-pointer"
          @click="$router.push(`/product/${product.id}`)"
        >
          <div class="aspect-[3/4] bg-gray-100 rounded-lg overflow-hidden">
            <img :src="product.image" :alt="product.name" class="w-full h-full object-cover" />
          </div>
          <div>
            <h3 class="text-sm font-medium leading-tight line-clamp-1">{{ product.name }}</h3>
            <p class="text-sm font-bold mt-1">${{ product.price.toFixed(2) }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { PPTextField, PPChip } from '@phanna/ui-framework'
import type { Product } from '../stores/cart'

const mockProducts: Product[] = [
  { id: '1', name: 'Classic White Tee', price: 29.99, category: 'T-Shirts', image: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Premium cotton t-shirt.' },
  { id: '2', name: 'Denim Jacket', price: 89.99, category: 'Jackets', image: 'https://images.unsplash.com/photo-1576871337632-b9aef4c17ab9?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Vintage style denim jacket.' },
  { id: '3', name: 'Slim Fit Jeans', price: 59.99, category: 'Pants', image: 'https://images.unsplash.com/photo-1542272604-780c8d47b096?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Comfortable slim fit denim.' },
  { id: '4', name: 'Summer Dress', price: 49.99, category: 'Dresses', image: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Lightweight summer dress.' },
  { id: '5', name: 'Leather Boots', price: 129.99, category: 'Shoes', image: 'https://images.unsplash.com/photo-1520639887900-4712952405bd?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Genuine leather boots.' },
  { id: '6', name: 'Wool Beanie', price: 19.99, category: 'Accessories', image: 'https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', description: 'Warm knitted beanie.' }
]

const categories = ['All', 'T-Shirts', 'Jackets', 'Pants', 'Dresses', 'Shoes', 'Accessories']
const activeCategory = ref('All')

const featuredProducts = computed(() => mockProducts.slice(0, 3))

const filteredProducts = computed(() => {
  if (activeCategory.value === 'All') return mockProducts
  return mockProducts.filter(p => p.category === activeCategory.value)
})

// Store mock products globally for detail view
if (!(window as any).mockProducts) {
  (window as any).mockProducts = mockProducts
}
</script>

<style scoped>
.scrollbar-hide::-webkit-scrollbar {
    display: none;
}
.scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
}
</style>
