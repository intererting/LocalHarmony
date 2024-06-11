import AbilityStage from '@ohos.app.ability.AbilityStage';
import Want from '@ohos.app.ability.Want';
import hilog from '@ohos.hilog';

export default class MyAbilityStage extends AbilityStage {
  onCreate() {

  }

  onAcceptWant(want: Want): string {
    if (want.abilityName == 'EntryAbility') {
      hilog.debug(0x0001, 'MyAbilityStageTag', "onAcceptWant")
      return `specified_entry ${Math.random()}'}`
    }
    return ''
  }
}