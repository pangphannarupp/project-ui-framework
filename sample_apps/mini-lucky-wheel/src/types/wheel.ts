export interface WheelPrize {
  id: string
  label: string
  color: string
  textColor: string
  icon: string
  value: string
  probability: number
}

export interface SpinTicketRecord {
  id: string
  code: string
  spinsBought: number
  price: number
  prizesWon: WheelPrize[]
  status: 'CLAIMED' | 'AVAILABLE'
  qrValue: string
  createdAt: string
}
