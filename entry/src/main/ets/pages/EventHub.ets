import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import hilog from '@ohos.hilog'

@Entry
@Component
struct EventHub {
  context = getContext() as common.UIAbilityContext

  aboutToAppear() {
    let want = globalThis.abilityWant as Want
    hilog.debug(0x0001, 'EventHub', `bundle name ${want.bundleName}`)
  }

  build() {
    Column() {
      Button() {
        Text('eventHub').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        this.context.eventHub.emit("event_hub_1", '123')
      })
    }.width("100%")
    .alignItems(HorizontalAlign.Center)
  }
}