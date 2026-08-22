export interface GiftCardTheme {
  id: string
  title: string
  category: 'BIRTHDAY' | 'THANK_YOU' | 'LOVE' | 'CELEBRATION'
  gradient: string
  cardArtEmoji: string
}

export interface GiftCardOrderRecord {
  id: string
  voucherCode: string
  theme: GiftCardTheme
  amount: number
  recipientName: string
  recipientEmail: string
  customMessage: string
  totalPaid: number
  createdAt: string
  qrValue: string
  redeemed: boolean
}
