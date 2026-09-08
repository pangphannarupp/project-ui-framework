export interface PluginItem {
  id: string
  name: string
  title: string
  category: 'Native & Hardware' | 'File & Storage' | 'Network & Security' | 'UI & Visuals' | 'System & Utilities'
  description: string
  icon: any
  tag?: string
  color?: string
  status?: 'stable' | 'beta' | 'new'
  componentDemo?: string
}

export interface ProjectItem {
  id: string
  name: string
  slug: string
  category: string
  icon: string
  banner: string
  version: string
  description: string
  status: 'active' | 'development' | 'beta'
  rating: number
  pluginsCount: number
  pluginIds: string[]
  liveUrl?: string
  author: string
  updatedAt: string
}

export type ThemeMode = 'light' | 'dark' | 'system'
export type LanguageCode = 'en' | 'km' | 'ko' | 'ja' | 'zh'
