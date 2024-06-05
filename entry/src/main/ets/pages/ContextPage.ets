import common from '@ohos.app.ability.common'
import hilog from '@ohos.hilog'

@Component
@Entry
struct ContextPage {
  mContext = getContext(this) as common.UIAbilityContext

  aboutToAppear() {
    hilog.debug(0x0001, 'TestTag', `${this.mContext.area}`)
    hilog.debug(0x0001, 'TestTag', `${this.mContext.bundleCodeDir}`)
    hilog.debug(0x0001, 'TestTag', `${this.mContext.filesDir}`)
  }

  build() {
    Column() {
      Text('context').fontSize(16).padding(10)
    }.width('100%')
  }
}