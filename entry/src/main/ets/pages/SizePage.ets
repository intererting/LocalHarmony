import hilog from '@ohos.hilog'
import display from '@ohos.display'

@Component
@Entry
struct SizePage {
  @State layoutHeight: string | number = '30%'

  onPageShow() {
    hilog.debug(0x0001, 'SizePageTag', `${display.getDefaultDisplaySync().width}`)
  }

  build() {
    Column() {
      Column().width('30%').height(this.layoutHeight).onAreaChange((oldArea, newArea) => {
        this.layoutHeight = newArea.height as number
        hilog.debug(0x0001, 'SizePageTag', `${oldArea.width} ${oldArea.height} ${newArea.width}  ${newArea.height}`)
      })
    }
  }
}