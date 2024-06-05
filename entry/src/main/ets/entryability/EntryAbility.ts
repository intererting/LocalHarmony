import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import display from '@ohos.display';
import hiAppEvent from '@ohos.hiviewdfx.hiAppEvent';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import appRecovery from '@ohos.app.ability.appRecovery';
import errorManager from '@ohos.app.ability.errorManager';

let localStorage = new LocalStorage({ 'name': 'default name' })

let TAG = 'TestTag'

var registerId = -1;
var callback = {
  onUnhandledException(errMsg) {
    hilog.debug(0x0001, TAG, `onUnhandledException ${errMsg}`)
    appRecovery.saveAppState();
    appRecovery.restartApp();
  }
}

export default class EntryAbility extends UIAbility {
  lifecycleId: number = -1

  onSaveState(reason: AbilityConstant.StateType, wantParam: {
    [key: string]: Object;
  }): AbilityConstant.OnSaveResult {
    wantParam['saveState'] = 'yuliyang'
    return AbilityConstant.OnSaveResult.ALL_AGREE
  }

  onWindowStageRestore(windowStage: window.WindowStage) {

  }

  onCreate(want: Want, launchParam) {
    appRecovery.enableAppRecovery(appRecovery.RestartFlag.ALWAYS_RESTART,
      appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR | appRecovery.SaveOccasionFlag.SAVE_WHEN_BACKGROUND,
      appRecovery.SaveModeFlag.SAVE_WITH_FILE);

    hilog.debug(0x0001, TAG, `${want.parameters?.saveState}`)

    hilog.debug(0x0001, TAG, `${display.getDefaultDisplaySync().scaledDensity}`)

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    this.context.eventHub.on("event_hub_1", this.eventHubFunction)

    globalThis.abilityWant = want

    let abilityLifecycleCallback = {
      onAbilityCreate(ability) {
        console.info(TAG, "onAbilityCreate ability:" + JSON.stringify(ability));
      },
      onWindowStageCreate(ability, windowStage) {
        console.info(TAG, "onWindowStageCreate ability:" + JSON.stringify(ability));
        console.info(TAG, "onWindowStageCreate windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageActive(ability, windowStage) {
        console.info(TAG, "onWindowStageActive ability:" + JSON.stringify(ability));
        console.info(TAG, "onWindowStageActive windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageInactive(ability, windowStage) {
        console.info(TAG, "onWindowStageInactive ability:" + JSON.stringify(ability));
        console.info(TAG, "onWindowStageInactive windowStage:" + JSON.stringify(windowStage));
      },
      onWindowStageDestroy(ability, windowStage) {
        console.info(TAG, "onWindowStageDestroy ability:" + JSON.stringify(ability));
        console.info(TAG, "onWindowStageDestroy windowStage:" + JSON.stringify(windowStage));
      },
      onAbilityDestroy(ability) {
        console.info(TAG, "onAbilityDestroy ability:" + JSON.stringify(ability));
      },
      onAbilityForeground(ability) {
        console.info(TAG, "onAbilityForeground ability:" + JSON.stringify(ability));
      },
      onAbilityBackground(ability) {
        console.info(TAG, "onAbilityBackground ability:" + JSON.stringify(ability));
      },
      onAbilityContinue(ability) {
        console.info(TAG, "onAbilityContinue ability:" + JSON.stringify(ability));
      }
    }

    this.lifecycleId = this.context.getApplicationContext().on("abilityLifecycle", abilityLifecycleCallback)

    hiAppEvent.addWatcher({
      // 开发者可以自定义观察者名称，系统会使用名称来标识不同的观察者
      name: "watcher1",
      // 开发者可以订阅感兴趣的应用事件，此处是订阅了按钮事件
      appEventFilters: [{
        domain: "button"
      }],
      // 开发者可以设置订阅回调触发的条件，此处是设置为事件打点数量满足1个
      triggerCondition: {
        row: 1
      },
      // 开发者可以自行实现订阅回调函数，以便对订阅获取到的事件打点数据进行自定义处理
      onTrigger: function (curRow, curSize, holder) {
        // 返回的holder对象为null，表示订阅过程发生异常，因此在记录错误日志后直接返回
        if (holder == null) {
          hilog.error(0x0000, 'testTag', "HiAppEvent holder is null")
          return
        }
        let eventPkg = null
        // 根据设置阈值大小（默认为512KB）去获取订阅事件包，直到将订阅数据全部取出
        // 返回的事件包对象为null，表示当前订阅数据已被全部取出，此次订阅回调触发结束
        while ((eventPkg = holder.takeNext()) != null) {
          // 开发者可以对事件包中的事件打点数据进行自定义处理，此处是将事件打点数据打印在日志中
          hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.packageId=%{public}d`, eventPkg.packageId)
          hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.row=%{public}d`, eventPkg.row)
          hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.size=%{public}d`, eventPkg.size)
          for (const eventInfo of eventPkg.data) {
            hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.info=%{public}s`, eventInfo)
          }
        }
      }
    })
  }

  eventHubFunction(...data) {
    hilog.debug(0x0000, 'testTag', data[0]);
  }

  onDestroy() {
    this.context.getApplicationContext().off("abilityLifecycle", this.lifecycleId)
    this.context.eventHub.off("event_hub_1")
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // registerId = errorManager.on('error', callback);

    windowStage.getMainWindow().then((window) => {
      // window.setWindowSystemBarEnable([])
      // window.setWindowLayoutFullScreen(true)
    })

    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/AxiosPage', localStorage, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onNewWant() {

  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
