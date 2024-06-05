import hilog from '@ohos.hilog'
import commonEventManager from '@ohos.commonEventManager';

const TAG = 'CommonEvent'

@Entry
@Component
struct CommonEvent {
  // @ts-ignore
  subscriber0: CommonEventSubscriber = null
  // @ts-ignore
  subscriber100: CommonEventSubscriber = null

  aboutToAppear() {
    commonEventManager.createSubscriber({ events: ['custom_event'], priority: 0 }, (err, data) => {
      if (err) {
        hilog.debug(0x0001, TAG, err.message)
      } else if (data) {
        this.subscriber0 = data
      }
    })

    commonEventManager.createSubscriber({ events: ['custom_event'], priority: 100 }, (err, data) => {
      if (err) {
        hilog.debug(0x0001, TAG, err.message)
      } else if (data) {
        this.subscriber100 = data
      }
    })
  }

  aboutToDisappear() {
    if (this.subscriber0) {
      commonEventManager.unsubscribe(this.subscriber0)
    }
    if (this.subscriber100) {
      commonEventManager.unsubscribe(this.subscriber100)
    }
  }

  build() {
    Column() {
      Button() {
        Text('订阅事件').fontColor(Color.White).padding(10)
      }.onClick((event) => {
        commonEventManager.subscribe(this.subscriber0, (err, data) => {
          if (err) {
            hilog.debug(0x0001, TAG, err.message)
          } else if (data) {
            hilog.debug(0x0001, TAG, `订阅回调成功0 ${data.parameters?.name?? ''}`)
          }
        })

        commonEventManager.subscribe(this.subscriber100, (err, data) => {
          if (err) {
            hilog.debug(0x0001, TAG, err.message)
          } else if (data) {
            hilog.debug(0x0001, TAG, `订阅回调成功100 ${data.parameters?.name??''}`)
          }
        })
      })

      Button() {
        Text('发送事件').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        commonEventManager.publish('custom_event', { code: 100, parameters: {
          name: 'yuliyang'
        } }, (err, data) => {
          if (err) {
            hilog.debug(0x0001, TAG, `发布失败${err.message}`)
          }
          hilog.debug(0x0001, TAG, '发布成功')
        })
      })
    }.width('100%')
  }
}