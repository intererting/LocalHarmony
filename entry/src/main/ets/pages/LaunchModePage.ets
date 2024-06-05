import router from '@ohos.router'

@Entry
@Component
struct LaunchModePage {
  build() {
    Column() {
      Button('start').onClick((event) => {
        router.pushUrl({ url: 'pages/LaunchModeSecondPage', }, router.RouterMode.Standard, (err, data) => {

        })
      })
    }.width('100%')
  }
}