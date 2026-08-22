export interface EventZoneTier {
  id: string
  name: Record<string, string>
  price: number
  perks: string[]
  badge: string
  color: string
}

export interface ConcertEvent {
  id: string
  title: string
  artist: string
  venue: string
  date: string
  time: string
  bannerUrl: string
  zones: EventZoneTier[]
}

export interface ConcertPassRecord {
  id: string
  ticketNumber: string
  event: ConcertEvent
  zone: EventZoneTier
  seatCode: string
  totalPaid: number
  status: 'VALID' | 'SCANNED'
  entryGate: string
  qrValue: string
  issuedAt: string
}
