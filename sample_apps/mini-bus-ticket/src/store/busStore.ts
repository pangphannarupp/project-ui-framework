import { reactive, computed } from 'vue'
import { BusRoute, BusBookingRecord } from '../types/bus'
import { BUS_ROUTES, CITIES_LIST } from '../data/busData'

const STORAGE_KEY = 'mini_bus_bookings_v1'

const initialBookings: BusBookingRecord[] = [
  {
    id: 'BUS-102',
    ticketCode: 'GI-882910',
    route: BUS_ROUTES[0],
    seats: ['A04', 'A05'],
    passengerName: 'Sokheng Kong',
    passengerPhone: '012 888 999',
    travelDate: new Date().toISOString().split('T')[0],
    boardingPoint: 'Giant Ibis Night Terminal, Night Market Road',
    totalAmount: 31.00,
    status: 'CONFIRMED',
    qrValue: 'BUS-102|GI-882910|A04,A05|CONFIRMED'
  }
]

function loadBookings(): BusBookingRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return initialBookings
}

function saveBookings(list: BusBookingRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  origin: 'Phnom Penh',
  destination: 'Siem Reap (Angkor)',
  selectedDate: new Date().toISOString().split('T')[0],
  selectedRoute: BUS_ROUTES[0] as BusRoute,
  selectedSeats: ['A04'] as string[],
  passengerName: 'Sokheng Kong',
  passengerPhone: '012 888 999',
  bookings: loadBookings(),
  currentBooking: null as BusBookingRecord | null
})

export function useBusStore() {
  const toggleSeat = (s: string) => {
    const idx = state.selectedSeats.indexOf(s)
    if (idx >= 0) state.selectedSeats.splice(idx, 1)
    else state.selectedSeats.push(s)
  }

  const subtotal = computed(() => state.selectedSeats.length * state.selectedRoute.price)
  const tax = computed(() => Number((subtotal.value * 0.05 + state.selectedSeats.length * 0.50).toFixed(2))) // tax + passenger insurance
  const grandTotal = computed(() => Number((subtotal.value + tax.value).toFixed(2)))

  const createBooking = () => {
    const id = 'BUS-' + Math.floor(100 + Math.random() * 900)
    const booking: BusBookingRecord = {
      id,
      ticketCode: `TRANSIT-${Math.floor(100000 + Math.random() * 900000)}`,
      route: state.selectedRoute,
      seats: [...state.selectedSeats],
      passengerName: state.passengerName,
      passengerPhone: state.passengerPhone,
      travelDate: state.selectedDate,
      boardingPoint: `${state.selectedRoute.operator} Terminal, ${state.selectedRoute.origin}`,
      totalAmount: grandTotal.value,
      status: 'CONFIRMED',
      qrValue: `${id}|${state.selectedSeats.join(',')}|${state.selectedRoute.origin}-${state.selectedRoute.destination}|${grandTotal.value}USD`
    }
    state.bookings.unshift(booking)
    state.currentBooking = booking
    saveBookings(state.bookings)
    return booking
  }

  return {
    state,
    toggleSeat,
    subtotal,
    tax,
    grandTotal,
    createBooking
  }
}
