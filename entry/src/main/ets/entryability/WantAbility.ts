import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';

export default class WantAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/WantIndex', (err, data) => {
    })
  }
}