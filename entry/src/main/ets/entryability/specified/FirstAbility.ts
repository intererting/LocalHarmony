import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import window from '@ohos.window';

export default class FirstAbility extends UIAbility {
  onCreate(want: Want, param: AbilityConstant.LaunchParam) {

  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    windowStage.loadContent("pages/specified/FirstPage")
  }
}