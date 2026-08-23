import { ref } from 'vue'

export function useSettingsViewModel() {
  const settings = ref({
    portalName: 'Enterprise Mini Portal Management Console',
    sandboxMode: true,
    autoPurgeLogsDays: 30,
    enforceMfa: true,
    telemetryRateLimit: 500,
    notificationChannel: 'Slack & Email',
    ssoProvider: 'OpenID Connect (Keycloak / Auth0)'
  })

  const saved = ref(false)

  const handleSave = () => {
    saved.value = true
    setTimeout(() => {
      saved.value = false
    }, 2500)
  }

  return {
    settings,
    saved,
    handleSave
  }
}
