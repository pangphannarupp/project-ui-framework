import { ref, computed, watch } from 'vue'
import type { ThemeMode, LanguageCode } from '../types'

const activeTab = ref<'home' | 'project' | 'setting'>('home')
const searchQuery = ref('')
const selectedLanguage = ref<LanguageCode>('en')
const themeMode = ref<ThemeMode>('system')
const primaryColor = ref('#3b82f6')

// Language dictionaries
export const translations = {
  en: {
    home: 'Home',
    project: 'Project',
    setting: 'Setting',
    hubTitle: 'UI Framework Showcase',
    hubSubtitle: 'Explore rich components, interactive plugins, and project architectures',
    searchPlugins: 'Search components & plugins...',
    allCategories: 'All',
    pluginsTotal: 'Total Components',
    projectsTotal: 'Sample Projects',
    assignedPlugins: 'Assigned Plugins',
    projectInfo: 'Project Information',
    changeLanguage: 'Language',
    themeColor: 'Theme Color',
    themeMode: 'Appearance Mode',
    light: 'Light',
    dark: 'Dark',
    system: 'System',
    version: 'Version',
    frameworkVersion: 'UI Framework',
    techStack: 'Tech Stack',
    author: 'Author',
    openDemo: 'Live Demo',
    features: 'Key Features',
    componentsList: 'Components Used',
    close: 'Close',
    selectColor: 'Select Accent Color',
    searchProjects: 'Search project name...',
    activeStatus: 'Active',
    betaStatus: 'Beta',
    devStatus: 'In Dev'
  },
  km: {
    home: 'ទំព័រដើម',
    project: 'គម្រោង',
    setting: 'ការកំណត់',
    hubTitle: 'UI Framework បង្ហាញសមាសភាគ',
    hubSubtitle: 'ស្វែងយល់ពីសមាសភាគទំនើប ផ្លាកអ៊ីន និងស្ថាបត្យកម្មគម្រោង',
    searchPlugins: 'ស្វែងរកសមាសភាគ & ផ្លាកអ៊ីន...',
    allCategories: 'ទាំងអស់',
    pluginsTotal: 'សមាសភាគសរុប',
    projectsTotal: 'គម្រោងគំរូ',
    assignedPlugins: 'ផ្លាកអ៊ីនដែលបានប្រើ',
    projectInfo: 'ព័ត៌មានគម្រោង',
    changeLanguage: 'ភាសា',
    themeColor: 'ពណ៌ស្បែក',
    themeMode: 'ទម្រង់ផ្ទៃ',
    light: 'ភ្លឺ',
    dark: 'ងងឹត',
    system: 'តាមប្រព័ន្ធ',
    version: 'ជំនាន់',
    frameworkVersion: 'UI Framework',
    techStack: 'បច្ចេកវិទ្យា',
    author: 'អ្នកបង្កើត',
    openDemo: 'មើលការអនុវត្ត',
    features: 'លក្ខណៈពិសេស',
    componentsList: 'សមាសភាគដែលប្រើ',
    close: 'បិទ',
    selectColor: 'ជ្រើសរើសពណ៌ចម្បង',
    searchProjects: 'ស្វែងរកឈ្មោះគម្រោង...',
    activeStatus: 'ដំណើរការ',
    betaStatus: 'សាកល្បង',
    devStatus: 'កំពុងអភិវឌ្ឍ'
  },
  ko: {
    home: '홈',
    project: '프로젝트',
    setting: '설정',
    hubTitle: 'UI 프레임워크 쇼케이스',
    hubSubtitle: '풍부한 컴포넌트, 인터랙티브 플러그인 및 프로젝트 아키텍처 탐색',
    searchPlugins: '컴포넌트 및 플러그인 검색...',
    allCategories: '전체',
    pluginsTotal: '총 컴포넌트',
    projectsTotal: '샘플 프로젝트',
    assignedPlugins: '사용된 플러그인',
    projectInfo: '프로젝트 정보',
    changeLanguage: '언어',
    themeColor: '테마 색상',
    themeMode: '화면 모드',
    light: '라이트',
    dark: '다크',
    system: '시스템',
    version: '버전',
    frameworkVersion: 'UI 프레임워크',
    techStack: '기술 스택',
    author: '작성자',
    openDemo: '라이브 데모',
    features: '주요 기능',
    componentsList: '사용된 컴포넌트',
    close: '닫기',
    selectColor: '테마 악센트 색상 선택',
    searchProjects: '프로젝트 이름 검색...',
    activeStatus: '활성',
    betaStatus: '베타',
    devStatus: '개발 중'
  },
  ja: {
    home: 'ホーム',
    project: 'プロジェクト',
    setting: '設定',
    hubTitle: 'UIフレームワーク ショーケース',
    hubSubtitle: '洗練されたUIコンポーネント、プラグイン、プロジェクト構成を探索',
    searchPlugins: 'コンポーネント & プラグインを検索...',
    allCategories: 'すべて',
    pluginsTotal: '総コンポーネント',
    projectsTotal: 'サンプルプロジェクト',
    assignedPlugins: '使用プラグイン',
    projectInfo: 'プロジェクト情報',
    changeLanguage: '言語',
    themeColor: 'テーマカラー',
    themeMode: '外観モード',
    light: 'ライト',
    dark: 'ダーク',
    system: 'システム',
    version: 'バージョン',
    frameworkVersion: 'UIフレームワーク',
    techStack: '技術スタック',
    author: '作者',
    openDemo: 'ライブデモ',
    features: '主な機能',
    componentsList: '使用コンポーネント',
    close: '閉じる',
    selectColor: 'アクセントカラーを選択',
    searchProjects: 'プロジェクト名で検索...',
    activeStatus: 'アクティブ',
    betaStatus: 'ベータ',
    devStatus: '開発中'
  },
  zh: {
    home: '首页',
    project: '项目',
    setting: '设置',
    hubTitle: 'UI 框架展示中心',
    hubSubtitle: '探索丰富的 UI 组件、互动插件以及项目架构',
    searchPlugins: '搜索组件与插件...',
    allCategories: '全部',
    pluginsTotal: '组件总数',
    projectsTotal: '示例项目',
    assignedPlugins: '已分配插件',
    projectInfo: '项目信息',
    changeLanguage: '语言设置',
    themeColor: '主题颜色',
    themeMode: '外观模式',
    light: '浅色',
    dark: '深色',
    system: '跟随系统',
    version: '版本',
    frameworkVersion: 'UI 框架',
    techStack: '技术栈',
    author: '开发者',
    openDemo: '在线演示',
    features: '核心功能',
    componentsList: '使用组件',
    close: '关闭',
    selectColor: '选择强调颜色',
    searchProjects: '搜索项目名称...',
    activeStatus: '活跃',
    betaStatus: '测试',
    devStatus: '开发中'
  }
}

export function useAppState() {
  const t = computed(() => translations[selectedLanguage.value] || translations.en)

  const applyThemeMode = () => {
    const isDark =
      themeMode.value === 'dark' ||
      (themeMode.value === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches)
    
    if (isDark) {
      document.documentElement.setAttribute('data-theme', 'dark')
    } else {
      document.documentElement.removeAttribute('data-theme')
    }
  }

  const applyPrimaryColor = (color: string) => {
    primaryColor.value = color
    document.documentElement.style.setProperty('--pp-primary', color)
    document.documentElement.style.setProperty('--pp-primary-light', `${color}1a`)
  }

  watch(themeMode, () => {
    applyThemeMode()
    localStorage.setItem('app_theme_mode', themeMode.value)
  })

  watch(selectedLanguage, (val) => {
    localStorage.setItem('app_lang', val)
  })

  watch(primaryColor, (val) => {
    localStorage.setItem('app_primary_color', val)
  })

  const initPreferences = () => {
    const savedTheme = localStorage.getItem('app_theme_mode') as ThemeMode
    if (savedTheme) themeMode.value = savedTheme
    
    const savedLang = localStorage.getItem('app_lang') as LanguageCode
    if (savedLang) selectedLanguage.value = savedLang

    const savedColor = localStorage.getItem('app_primary_color')
    if (savedColor) applyPrimaryColor(savedColor)
    else applyPrimaryColor('#3b82f6')

    applyThemeMode()
  }

  return {
    activeTab,
    searchQuery,
    selectedLanguage,
    themeMode,
    primaryColor,
    t,
    applyThemeMode,
    applyPrimaryColor,
    initPreferences
  }
}
