import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';

export default class FunctionAbility extends UIAbility {
  onCreate(want: Want, param: AbilityConstant.LaunchParam) {
    hilog.debug(0x0001, "TestTag", `${want.parameters?.instanceKey}`)
  }

  onWindowStageCreate(windowState: window.WindowStage) {
    windowState.loadContent("pages/function/FunctionIndex", (err, data) => {

    })
  }
}