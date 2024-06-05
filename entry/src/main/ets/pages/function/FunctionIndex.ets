import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import hilog from '@ohos.hilog'

@Entry
@Component
struct FunctionIndex {
  context = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Text('function index')
      Button() {
        Text('close page').padding(10)
      }.onClick((event) => {
        this.context.terminateSelfWithResult({ resultCode: 100, want: {
          parameters: { age: 30 } }
        }, (err, data) => {

        })
      })

      Button() {
        Text('打开single ability').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        let myWant: Want = {
          deviceId: '',
          bundleName: 'com.example.myapplication',
          moduleName: 'entry', // moduleName非必选
          abilityName: 'EntryAbility',
          parameters: {
            instanceKey: "func"
          },
        }
        this.context.startAbility(myWant, (err, data) => {
        })
      })
    }
  }
}