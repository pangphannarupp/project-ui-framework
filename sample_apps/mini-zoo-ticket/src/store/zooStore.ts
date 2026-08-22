import { reactive, computed } from 'vue';
import { TicketType, AddonItem, SelectedTicket, SelectedAddon, VisitorInfo, BookedTicketRecord } from '../types/zoo';
import { AVAILABLE_TICKETS, AVAILABLE_ADDONS, PROMO_CODES, TIME_SLOTS } from '../data/tickets';

const STORAGE_KEY_TICKETS = 'mini_zoo_booked_tickets_v2';

// Initial dummy booked tickets for rich demo experience
const INITIAL_BOOKINGS: BookedTicketRecord[] = [
  {
    id: 'WZ-849201',
    bookingCode: 'SAFARI-849201',
    purchaseDate: '2026-08-20',
    visitDate: '2026-08-22',
    timeSlot: 'Morning Slot (08:30 AM - 12:30 PM)',
    tickets: [
      { ticket: AVAILABLE_TICKETS[0], quantity: 2 },
      { ticket: AVAILABLE_TICKETS[1], quantity: 1 }
    ],
    addons: [
      { addon: AVAILABLE_ADDONS[0], quantity: 3 }
    ],
    visitor: {
      fullName: 'Sophea Chan',
      email: 'sophea.chan@example.com',
      phone: '012 345 678',
      idOrPassport: 'CAM-992812',
      specialRequests: '',
      agreeTerms: true
    },
    subtotal: 50.00,
    discount: 5.00,
    tax: 4.50,
    total: 49.50,
    promoCode: 'ZOOFUN10',
    paymentMethod: 'KHQR_PURCHASE',
    status: 'CONFIRMED',
    qrValue: 'WZ-849201|CONFIRMED|2026-08-22|MORNING'
  }
];

function loadSavedBookings(): BookedTicketRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY_TICKETS);
    if (raw) {
      return JSON.parse(raw);
    }
  } catch (e) {
    console.error('Failed to load tickets from localStorage', e);
  }
  return INITIAL_BOOKINGS;
}

function saveBookings(list: BookedTicketRecord[]) {
  try {
    localStorage.setItem(STORAGE_KEY_TICKETS, JSON.stringify(list));
  } catch (e) {
    console.error('Failed to save tickets to localStorage', e);
  }
}

// Global reactive state
const state = reactive({
  selectedVisitDate: new Date(Date.now() + 86400000).toISOString().split('T')[0], // Tomorrow default
  selectedTimeSlot: TIME_SLOTS[0].label,
  
  // Selected Tickets map: { [ticketId]: quantity }
  ticketQuantities: {} as Record<string, number>,

  // Selected Addons map: { [addonId]: quantity }
  addonQuantities: {} as Record<string, number>,

  // Applied promo code
  appliedPromoCode: '',
  promoDiscountPercent: 0,
  promoMessage: '',

  // Visitor Details
  visitor: {
    fullName: '',
    email: '',
    phone: '',
    idOrPassport: '',
    specialRequests: '',
    agreeTerms: true
  } as VisitorInfo,

  selectedPaymentMethod: 'KHQR_PURCHASE',

  // Stored Bookings list
  bookedTickets: loadSavedBookings(),

  // Active / Last created booking
  currentBooking: null as BookedTicketRecord | null,

  // Toast notification message
  toastMessage: '',
  toastType: 'info' as 'info' | 'success' | 'warning' | 'error'
});

// Computed properties
const selectedTicketsList = computed<SelectedTicket[]>(() => {
  return AVAILABLE_TICKETS.map(t => ({
    ticket: t,
    quantity: state.ticketQuantities[t.id] || 0
  })).filter(item => item.quantity > 0);
});

const selectedAddonsList = computed<SelectedAddon[]>(() => {
  return AVAILABLE_ADDONS.map(a => ({
    addon: a,
    quantity: state.addonQuantities[a.id] || 0
  })).filter(item => item.quantity > 0);
});

const totalTicketsCount = computed(() => {
  return selectedTicketsList.value.reduce((acc, curr) => acc + curr.quantity, 0);
});

const totalCount = computed(() => {
  const tCount = selectedTicketsList.value.reduce((acc, curr) => acc + curr.quantity, 0);
  const aCount = selectedAddonsList.value.reduce((acc, curr) => acc + curr.quantity, 0);
  return tCount + aCount;
});

const ticketsSubtotal = computed(() => {
  return selectedTicketsList.value.reduce((acc, curr) => acc + (curr.ticket.price * curr.quantity), 0);
});

const addonsSubtotal = computed(() => {
  return selectedAddonsList.value.reduce((acc, curr) => acc + (curr.addon.price * curr.quantity), 0);
});

const subtotal = computed(() => {
  return ticketsSubtotal.value + addonsSubtotal.value;
});

const discountAmount = computed(() => {
  if (state.promoDiscountPercent > 0) {
    return Number(((subtotal.value * state.promoDiscountPercent) / 100).toFixed(2));
  }
  return 0;
});

const tax = computed(() => {
  // 10% VAT
  const taxable = Math.max(0, subtotal.value - discountAmount.value);
  return Number((taxable * 0.10).toFixed(2));
});

const grandTotal = computed(() => {
  return Number((Math.max(0, subtotal.value - discountAmount.value) + tax.value).toFixed(2));
});

// Actions
export const useZooStore = () => {
  const setTicketQuantity = (ticketId: string, qty: number) => {
    state.ticketQuantities[ticketId] = Math.max(0, qty);
  };

  const addTicket = (ticketId: string) => {
    const curr = state.ticketQuantities[ticketId] || 0;
    state.ticketQuantities[ticketId] = curr + 1;
  };

  const removeTicket = (ticketId: string) => {
    const curr = state.ticketQuantities[ticketId] || 0;
    if (curr > 0) {
      state.ticketQuantities[ticketId] = curr - 1;
    }
  };

  const setAddonQuantity = (addonId: string, qty: number) => {
    state.addonQuantities[addonId] = Math.max(0, qty);
  };

  const addAddon = (addonId: string) => {
    const curr = state.addonQuantities[addonId] || 0;
    state.addonQuantities[addonId] = curr + 1;
  };

  const removeAddon = (addonId: string) => {
    const curr = state.addonQuantities[addonId] || 0;
    if (curr > 0) {
      state.addonQuantities[addonId] = curr - 1;
    }
  };

  const clearSelection = () => {
    state.ticketQuantities = {};
    state.addonQuantities = {};
    state.appliedPromoCode = '';
    state.promoDiscountPercent = 0;
    state.promoMessage = '';
  };

  const applyPromoCode = (code: string): boolean => {
    const cleanCode = code.trim().toUpperCase();
    if (!cleanCode) {
      state.appliedPromoCode = '';
      state.promoDiscountPercent = 0;
      state.promoMessage = '';
      return false;
    }
    const found = PROMO_CODES[cleanCode];
    if (found) {
      state.appliedPromoCode = cleanCode;
      state.promoDiscountPercent = found.discountPercent;
      state.promoMessage = `Promo applied: ${found.description}`;
      showToast(`🎉 ${found.description}`, 'success');
      return true;
    } else {
      state.appliedPromoCode = '';
      state.promoDiscountPercent = 0;
      state.promoMessage = 'Invalid promo code';
      showToast('⚠️ Promo code is not valid', 'warning');
      return false;
    }
  };

  const removePromoCode = () => {
    state.appliedPromoCode = '';
    state.promoDiscountPercent = 0;
    state.promoMessage = '';
    showToast('Promo code removed', 'info');
  };

  const createBooking = (paymentInfo?: { transactionId?: string; status?: string }): BookedTicketRecord => {
    const randomCode = 'WZ-' + Math.floor(100000 + Math.random() * 900000);
    const newRecord: BookedTicketRecord = {
      id: randomCode,
      bookingCode: `SAFARI-${Math.floor(100000 + Math.random() * 900000)}`,
      purchaseDate: new Date().toISOString().split('T')[0],
      visitDate: state.selectedVisitDate,
      timeSlot: state.selectedTimeSlot,
      tickets: JSON.parse(JSON.stringify(selectedTicketsList.value)),
      addons: JSON.parse(JSON.stringify(selectedAddonsList.value)),
      visitor: { ...state.visitor },
      subtotal: subtotal.value,
      discount: discountAmount.value,
      tax: tax.value,
      total: grandTotal.value,
      promoCode: state.appliedPromoCode || undefined,
      paymentMethod: state.selectedPaymentMethod,
      status: 'CONFIRMED',
      qrValue: `${randomCode}|CONFIRMED|${state.selectedVisitDate}|${state.visitor.fullName || 'GUEST'}|${grandTotal.value}USD`
    };

    state.bookedTickets.unshift(newRecord);
    state.currentBooking = newRecord;
    saveBookings(state.bookedTickets);
    clearSelection();
    return newRecord;
  };

  const cancelBooking = (bookingId: string) => {
    const item = state.bookedTickets.find(b => b.id === bookingId);
    if (item) {
      item.status = 'CANCELLED';
      saveBookings(state.bookedTickets);
      showToast('Booking cancelled', 'info');
    }
  };

  const getBookingById = (bookingId: string): BookedTicketRecord | undefined => {
    return state.bookedTickets.find(b => b.id === bookingId);
  };

  const showToast = (msg: string, type: 'info' | 'success' | 'warning' | 'error' = 'info') => {
    state.toastMessage = msg;
    state.toastType = type;
    setTimeout(() => {
      if (state.toastMessage === msg) {
        state.toastMessage = '';
      }
    }, 3500);
  };

  return {
    state,
    selectedTicketsList,
    selectedAddonsList,
    totalTicketsCount,
    totalCount,
    ticketsSubtotal,
    addonsSubtotal,
    subtotal,
    discountAmount,
    tax,
    grandTotal,
    setTicketQuantity,
    addTicket,
    removeTicket,
    setAddonQuantity,
    addAddon,
    removeAddon,
    clearSelection,
    applyPromoCode,
    removePromoCode,
    createBooking,
    cancelBooking,
    getBookingById,
    showToast
  };
};
