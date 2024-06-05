import { exportObj } from './Fifth'

@Entry
@Component
struct Sixth {
  aboutToAppear() {
    exportObj.name = 'changed export name'
  }

  build() {
    Column() {
      Text('Sixth').fontSize(16)
    }.width('100%')
  }
}