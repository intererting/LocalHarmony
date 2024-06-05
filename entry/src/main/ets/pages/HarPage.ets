import { MainPage } from 'harLib'
import { nativeAdd } from 'hspLib'
import router from '@ohos.router'
import hilog from '@ohos.hilog'

@Entry
@Component
struct HarPage {
  aboutToAppear() {
    console.log(`nativeAdd ${nativeAdd(1, 2)}`)
  }

  build() {
    Column() {
      MainPage()
        .flexBasis(0)
        .layoutWeight(1)
      Button() {
        Text('打开hsp页面').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        router.pushUrl({ url: '@bundle:com.example.myapplication/hspLib/ets/pages/Index' })
      })
    }
  }
}