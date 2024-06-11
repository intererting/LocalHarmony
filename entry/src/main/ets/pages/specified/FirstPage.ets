import common from '@ohos.app.ability.common'
import hilog from '@ohos.hilog'

@Component
@Entry
struct FirstPage {
  build() {
    Column() {
      Button('click first').onClick((event) => {
        const context = getContext(this) as common.UIAbilityContext
        context.startAbility({
          bundleName: 'com.example.myapplication',
          abilityName: "SecondAbility"
        }, (data, err) => {
          hilog.debug(0x0001, 'FirstPageTag', JSON.stringify(err))
        })
      })
    }
  }
}