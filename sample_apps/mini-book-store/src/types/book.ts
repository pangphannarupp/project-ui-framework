export interface Book {
  id: string
  title: string
  author: string
  description: string
  coverUrl: string
  price: number
  category: string // e.g. "Fiction", "Philosophy", "Mystery", "History"
  formats: string[] // e.g. ["Hardcover", "Paperback", "E-book", "Audiobook"]
  rating: number
  reviewsCount: number
  publishedYear: number
  publisher: string
  pages: number
  samplePages: string[] // List of text lines or paragraphs representing previewable pages
}

export interface CartItem {
  book: Book
  format: string
  price: number
  quantity: number
}

export interface BookOrder {
  id: string
  items: CartItem[]
  customerName: string
  customerPhone: string
  orderDate: string
  totalAmount: number
  paymentStatus: 'PENDING' | 'SUCCESS' | 'FAILED'
  receiptCode: string
}
