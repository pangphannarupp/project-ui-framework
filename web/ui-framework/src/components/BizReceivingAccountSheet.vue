<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="receiving-account-sheet">
      <div class="sheet-header">
        <h3>Receiving Account</h3>
      </div>
      
      <div class="accounts-list">
        <BizAccountSavingCard
          v-for="account in accounts"
          :key="account.id"
          :accountName="account.name"
          :accountNumber="account.number"
          :balance="account.balance"
          :currency="account.currency"
          :type="account.type"
          :selected="selectedAccountId === account.id"
          @select="onSelect(account)"
        />
      </div>
    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizBottomSheet from './BizBottomSheet.vue';
import BizAccountSavingCard from './BizAccountSavingCard.vue';

interface Account {
  id: string;
  name: string;
  number: string;
  balance: number;
  currency: 'USD' | 'KHR';
  type: string;
}

defineProps({
  modelValue: Boolean,
  accounts: {
    type: Array as () => Account[],
    default: () => []
  },
  selectedAccountId: {
    type: String,
    default: ''
  }
});

const emit = defineEmits(['update:modelValue', 'select']);

const onSelect = (account: Account) => {
  emit('select', account);
  emit('update:modelValue', false);
};
</script>

<style scoped>
.receiving-account-sheet {
  padding: 8px 20px 24px;
  display: flex;
  flex-direction: column;
  max-height: 70vh;
}

.sheet-header {
  margin-bottom: 24px;
}

.sheet-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0;
}

.accounts-list {
  flex: 1;
  overflow-y: auto;
  /* Make room for scrolling nicely */
  padding-right: 4px;
  padding-bottom: 16px;
}

/* Custom Scrollbar for accounts list */
.accounts-list::-webkit-scrollbar {
  width: 4px;
}
.accounts-list::-webkit-scrollbar-track {
  background: transparent;
}
.accounts-list::-webkit-scrollbar-thumb {
  background: #d0d0d0;
  border-radius: 4px;
}
</style>
