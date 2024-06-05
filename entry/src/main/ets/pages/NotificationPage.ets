import notificationManager from '@ohos.notificationManager'
import wantAgent from '@ohos.app.ability.wantAgent'
import hilog from '@ohos.hilog'

@Component
@Entry
struct NotificationPage {
  wantAgentInfo = {
    wants: [
      {
        deviceId: '',
        bundleName: 'com.example.myapplication',
        abilityName: 'EntryAbility',
      }
    ],
    operationType: wantAgent.OperationType.START_ABILITY,
    requestCode: 0,
    wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
  }

  build() {
    Column() {
      Button('发布通知').onClick((event) => {
        wantAgent.getWantAgent(this.wantAgentInfo, (data, err) => {
          if (err) {
            hilog.debug(0x0001, 'NotificationPage', `${JSON.stringify(err)}`)
          }
          if (data) {
            notificationManager.publish({
              id: 1,
              // wantAgent: data,
              deliveryTime: Date.now(),
              content: { contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
                normal: {
                  title: 'test title',
                  text: 'test test',
                  additionalText: "additionalText test"
                }
              },
              // template: {
              //   name: 'downloadTemplate',
              //   data: { title: 'File Title', fileName: 'music.mp4', progressValue: 45 }
              // }
            }, (err, data) => {

            })
          }
        })
      })
    }
  }
}