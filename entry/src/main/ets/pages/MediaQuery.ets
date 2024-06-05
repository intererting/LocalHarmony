import mediaquery from '@ohos.mediaquery'
import hilog from '@ohos.hilog'
import common from '@ohos.app.ability.common';

@Component
@Entry
struct MediaQuery {
  listener!: mediaquery.MediaQueryListener

  aboutToAppear() {
    this.listener = mediaquery.matchMediaSync('(orientation: landscape)');
    let callback = (data: mediaquery.MediaQueryResult) => {
      if (data.matches) {
        hilog.debug(0x0001, 'MediaQueryTag', '%s', '横屏')
      }
    }
    this.listener.on('change', callback)
  }

  onPageShow() {

  }

  aboutToDisappear() {
    this.listener.off("change", (data) => {
      hilog.debug(0x0001, 'MediaQueryTag', data.media)
    })
  }

  build() {
  }
}