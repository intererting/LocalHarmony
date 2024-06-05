import backgroundTaskManager from '@ohos.resourceschedule.backgroundTaskManager';
import hilog from '@ohos.hilog';

let id: number; // 申请短时任务ID
let delayTime: number; // 本次申请短时任务的剩余时间

// 申请短时任务
function requestSuspendDelay() {
  throw new Error('测试appRecovery')

  // hilog.debug(0x0001, 'requestSuspendDelayTag', `result ${canIUse("SystemCapability.ResourceSchedule.BackgroundTaskManager.TransientTask")}`)
  //
  //
  // try {
  //   let myReason = 'test requestSuspendDelay'; // 申请原因。每调用一次申请接口就会有一个新id，短时任务的数量会增加一个
  //   let delayInfo = backgroundTaskManager.requestSuspendDelay(myReason, () => {
  //     // 回调函数。应用申请的短时任务即将超时，通过此函数回调应用，执行一些清理和标注工作，并取消短时任务
  //     console.info('suspend delay task will timeout');
  //     backgroundTaskManager.cancelSuspendDelay(id);
  //   })
  //   id = delayInfo.requestId;
  //   delayTime = delayInfo.actualDelayTime;
  //   hilog.debug(0x0001, 'BackgroundTaskPageTag', `${delayTime}`)
  // } catch (e) {
  //   hilog.debug(0x0001, 'BackgroundTaskPageTag', `${(e as Error).message}`)
  // }
}

@Entry
@Component
struct BackgroundTaskPage {
  build() {
    Column() {
      Button('requestSuspendDelay').onClick((event) => {
        requestSuspendDelay()
      })
    }.width('100%')
  }
}