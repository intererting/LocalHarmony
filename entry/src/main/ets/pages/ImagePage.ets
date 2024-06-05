import common from '@ohos.app.ability.common'
import image from '@ohos.multimedia.image'
import hilog from '@ohos.hilog'

@Component
@Entry
struct ImagePage {
  mContext = getContext(this) as common.UIAbilityContext
  @State pixelMap: PixelMap = undefined

  onPageShow() {
    const imagePackerApi = image.createImagePacker();
    this.mContext.resourceManager.getMediaContent($r('app.media.lufy')).then((result) => {
      let imageSource = image.createImageSource(result.buffer)
      imageSource.getImageInfo(0, (err, data) => {
        hilog.debug(0x0001, 'ImagePageTag', `${data.size.width}  ${data.size.height}`)
      })
      imageSource.createPixelMap({
        editable: true,
        desiredSize: {
          //像素
          width: 800,
          height: 1175
        },
        desiredPixelFormat: 3,
      }).then((data) => {
        data.crop({ size: {
          //像素
          width: 800, height: 1175
        }, x: 0, y: 0 },).then((result) => {
          this.pixelMap = data
        })
        data.getImageInfo().then((result) => {
          hilog.debug(0x0001, 'ImagePageTag', `${result.size.width}  ${result.size.height}`)
        })
        // hilog.debug(0x0001, 'ImagePageTag', `${data.getBytesNumberPerRow()}`)
      })
    })

  }

  build() {
    Column() {
      Image(this.pixelMap)
    }
  }
}