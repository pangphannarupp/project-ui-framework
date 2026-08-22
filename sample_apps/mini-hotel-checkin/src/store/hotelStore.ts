import { reactive } from 'vue'
import { HotelSuite, HotelBookingRecord } from '../types/hotel'
import { HOTEL_SUITES } from '../data/hotelData'

const STORAGE_KEY = 'mini_hotel_bookings_v1'

function loadBookings(): HotelBookingRecord[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw)
  } catch (e) {}
  return []
}

function saveBookings(list: HotelBookingRecord[]) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(list)) } catch (e) {}
}

const state = reactive({
  selectedSuite: HOTEL_SUITES[0] as HotelSuite,
  checkInDate: '2026-08-25',
  checkOutDate: '2026-08-27',
  nights: 2,
  guestName: 'LORD CHAMBERLAIN',
  bookings: loadBookings(),
  currentBooking: null as HotelBookingRecord | null
})

export function useHotelStore() {
  const bookSuite = () => {
    const id = 'HOTEL-' + Math.floor(100 + Math.random() * 900)
    const roomNum = `Suite ${Math.floor(1200 + Math.random() * 800)}`
    const total = state.selectedSuite.pricePerNight * state.nights
    const rec: HotelBookingRecord = {
      id,
      reservationNumber: `RES-${Math.floor(100000 + Math.random() * 900000)}`,
      guestName: state.guestName,
      suite: state.selectedSuite,
      checkInDate: state.checkInDate,
      checkOutDate: state.checkOutDate,
      nights: state.nights,
      totalPaid: total,
      status: 'CONFIRMED',
      roomNumber: roomNum,
      digitalKeyQr: `${id}|${roomNum}|NFC_KEYLESS_ACCESS_GRANTED|${total}USD`
    }
    state.bookings.unshift(rec)
    state.currentBooking = rec
    saveBookings(state.bookings)
    return rec
  }

  return {
    state,
    bookSuite
  }
}
