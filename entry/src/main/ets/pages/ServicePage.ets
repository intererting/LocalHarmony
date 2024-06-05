import common from '@ohos.app.ability.common'

@Entry
@Component
struct ServicePage {
  mContext = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Button('service').onClick((event) => {
      })
    }
  }
}