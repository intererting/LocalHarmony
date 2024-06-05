import AbilityStage from '@ohos.app.ability.AbilityStage';
import Want from '@ohos.app.ability.Want';

export default class MyAbilityStage extends AbilityStage {
  onCreate() {

  }

  onAcceptWant(want: Want): string {
    if (want.abilityName == 'FunctionAbility') {
      return `specified_${want.parameters?.instanceKey ?? ''}`
    }
    return ''
  }
}