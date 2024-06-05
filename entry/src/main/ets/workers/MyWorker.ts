import worker from '@ohos.worker'
import hilog from '@ohos.hilog'

const TAG = 'workerTag'

let parent = worker.workerPort

parent.onmessage = function (message) {
  hilog.debug(0x0001, TAG, message.data)
  parent.postMessage('message from worker')
  // terminate()
  // parent.close()
  // throw new Error('error from worker')
}