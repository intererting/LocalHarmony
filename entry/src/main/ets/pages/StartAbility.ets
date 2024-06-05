import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import hilog from '@ohos.hilog';

@Entry
@Component
struct StartAbility {
  context = getContext() as common.UIAbilityContext

  startAbility() {
    let myWant: Want = {
      deviceId: '',
      bundleName: 'com.example.myapplication',
      moduleName: 'entry', // moduleName非必选
      abilityName: 'FunctionAbility',
      parameters: {
        instanceKey: "func"
      },
    }
    this.context.startAbilityForResult(myWant, (err, data) => {
      if (100 == data.resultCode) {
        hilog.debug(0x0001, 'TestTag', `${data.want?.parameters?.age}`)
      }
    })
  }

  startImplictAbility() {
    let want: Want = {
      action: 'ohos.want.action.test',
      entities: ['entity.test']
    }
    this.context.startAbility(want)
  }

  build() {
    Column() {
      Button() {
        Text('打开Ability').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        this.startAbility()
      })

      Button() {
        Text('打开隐式Ability').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        this.startImplictAbility()
      })
    }
  }
}