import worker from '@ohos.worker'
import hilog from '@ohos.hilog'

@Component
@Entry
struct WorkerPage {
  build() {
    Column() {
      Button() {
        Text('start worker').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        let myWorker = new worker.ThreadWorker('entry/ets/workers/MyWorker.ts')
        myWorker.onexit = function (code) {
          hilog.debug(0x0001, "WorkerPage", `onexit ${code}`)
        }

        myWorker.onerror = function (err) {
          hilog.debug(0x0001, "WorkerPage", `onerror ${err.message}`)
        }
        myWorker.postMessage('message from main')
        myWorker.onmessage = function (message) {
          hilog.debug(0x0001, 'WorkerPage', `${message.data}`)
          myWorker.terminate()
        }
      })
    }.width("100%")
  }
}