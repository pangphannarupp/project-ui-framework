import { reactive, computed } from 'vue'
import { MovieItem, ShowtimeSlot, SnackItem, CinemaBookingRecord } from '../types/cinema'
import { MOVIES_LIST, SHOWTIME_SLOTS, CINEMA_BRANCHES, SNACKS_LIST } from '../data/cinemaData'

const STORAGE_KEY = 'mini_cinema_bookings_v1'

const initialBookings: CinemaBookingRecord[] = [
  {
    id: 'CIN-9921',
    bookingCode: 'CINE-992140',
    movie: MOVIES_LIST[0],
    showtime: SHOWTIME_SLOTS[0],
    seats: ['F5', 'F6'],
    snacks: [{ snack: SNACKS_LIST[1], quantity: 1 }],
    totalAmount: 26.00,
    visitDate: new Date().toISOString().split('T')[0],
    cinemaBranch: CINEMA_BRANCHES[0],
    status: 'CONFIRMED',
    qrValue: 'CIN-9921|F5,F6|AVATAR|26USD'
  }
]

function loadBookings(): CinemaBookingRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return initialBookings
}

function saveBookings(list: CinemaBookingRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedMovie: MOVIES_LIST[0] as MovieItem,
  selectedShowtime: SHOWTIME_SLOTS[0] as ShowtimeSlot,
  selectedDate: new Date().toISOString().split('T')[0],
  selectedBranch: CINEMA_BRANCHES[0],
  selectedSeats: ['F5', 'F6'] as string[],
  snackQuantities: {} as Record<string, number>,
  bookings: loadBookings(),
  currentBooking: null as CinemaBookingRecord | null
})

export function useCinemaStore() {
  const toggleSeat = (seatId: string) => {
    const idx = state.selectedSeats.indexOf(seatId)
    if (idx >= 0) state.selectedSeats.splice(idx, 1)
    else state.selectedSeats.push(seatId)
  }

  const addSnack = (id: string) => {
    state.snackQuantities[id] = (state.snackQuantities[id] || 0) + 1
  }

  const removeSnack = (id: string) => {
    if (state.snackQuantities[id] > 0) state.snackQuantities[id]--
  }

  const selectedSnacksList = computed(() => {
    return SNACKS_LIST.map(snack => ({
      snack,
      quantity: state.snackQuantities[snack.id] || 0
    })).filter(s => s.quantity > 0)
  })

  const seatsSubtotal = computed(() => state.selectedSeats.length * state.selectedShowtime.price)
  const snacksSubtotal = computed(() => selectedSnacksList.value.reduce((acc, curr) => acc + curr.snack.price * curr.quantity, 0))
  const subtotal = computed(() => seatsSubtotal.value + snacksSubtotal.value)
  const tax = computed(() => Number((subtotal.value * 0.05).toFixed(2)))
  const grandTotal = computed(() => Number((subtotal.value + tax.value).toFixed(2)))

  const createBooking = () => {
    const randomCode = 'CIN-' + Math.floor(1000 + Math.random() * 9000)
    const booking: CinemaBookingRecord = {
      id: randomCode,
      bookingCode: `CINE-${Math.floor(100000 + Math.random() * 900000)}`,
      movie: state.selectedMovie,
      showtime: state.selectedShowtime,
      seats: [...state.selectedSeats],
      snacks: JSON.parse(JSON.stringify(selectedSnacksList.value)),
      totalAmount: grandTotal.value,
      visitDate: state.selectedDate,
      cinemaBranch: state.selectedBranch,
      status: 'CONFIRMED',
      qrValue: `${randomCode}|${state.selectedSeats.join(',')}|${state.selectedMovie.title}|${grandTotal.value}USD`
    }
    state.bookings.unshift(booking)
    state.currentBooking = booking
    saveBookings(state.bookings)
    return booking
  }

  return {
    state,
    toggleSeat,
    addSnack,
    removeSnack,
    selectedSnacksList,
    seatsSubtotal,
    snacksSubtotal,
    subtotal,
    tax,
    grandTotal,
    createBooking
  }
}
