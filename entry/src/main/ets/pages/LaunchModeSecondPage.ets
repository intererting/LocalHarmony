import router from '@ohos.router'

@Entry
@Component
struct LaunchModeSecondPage {
  build() {
    Column() {
      Text('LaunchModeSecondPage')
      Button('start').onClick((event) => {
        router.pushUrl({ url: 'pages/LaunchModePage' }, router.RouterMode.Single, (err, data) => {

        })
      })
    }.width('100%').margin({ top: 10 })
  }
}