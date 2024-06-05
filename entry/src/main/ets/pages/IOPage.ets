import common from '@ohos.app.ability.common'
import fs from '@ohos.file.fs'
import hilog from '@ohos.hilog'

@Entry
@Component
struct IOPage {
  mContext = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Button('写文件').onClick((event) => {
        let fileName = `${this.mContext.filesDir}/test.txt`
        fs.open(fileName, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE).then((file) => {
          fs.write(file.fd, 'hello,world').then((length) => {
            hilog.debug(0x0001, 'IOPageTag', `${length}`)
          }).catch((err) => {

          })
        }).catch((err) => {

        })
      })
    }.width('100%')
  }
}