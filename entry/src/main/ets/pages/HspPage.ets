import router from '@ohos.router'

@Component
@Entry
struct HspPage {
  build() {
    Column() {
      Button('click').onClick((event) => {
        router.pushUrl({ url: "@bundle:com.example.myapplication/hspLib/ets/pages/Index" }, (err, data) => {

        })
      })
    }
  }
}