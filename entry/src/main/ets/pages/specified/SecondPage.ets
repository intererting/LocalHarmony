import common from '@ohos.app.ability.common'
import hilog from '@ohos.hilog'

@Component
@Entry
struct SecondPage {
  build() {
    Column() {
      Button('second click').onClick((event) => {
        const context = getContext(this) as common.UIAbilityContext
        context.startAbility({
          bundleName: 'com.example.myapplication',
          abilityName: "EntryAbility"
        }, (data, err) => {
          hilog.debug(0x0001, 'FirstPageTag', JSON.stringify(err))
        })
      })
    }
  }
}