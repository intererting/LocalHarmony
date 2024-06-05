import { StringDataSource } from '../datasource/StringDataSource'

@Entry
@Component
struct LazeForeachList {
  myDataSource: StringDataSource = new StringDataSource()

  aboutToAppear() {
    let datas: string[] = []
    for (let i = 0; i < 30; i++) {
      datas.push(`index_${i}`)
    }
    this.myDataSource.setDatas(datas)
  }

  build() {
    Column() {
      Button() {
        Text('add').padding(10).fontSize(15).fontColor(Color.White)
      }.type(ButtonType.Capsule).onClick((event) => {

      })

      Divider().strokeWidth(10).margin(10)
      List({ initialIndex: 3, space: 2 }) {
        LazyForEach(this.myDataSource, (item, index) => {
          ListItem() {
            Text(item as string).fontSize(16).width('100%').textAlign(TextAlign.Center)
              .height(44)
          }
        }, (item, index) => {
          return JSON.stringify(item)
        })
      }.width('100%').height('auto').flexShrink(1)

      Button() {
        Text('delete').padding(10).fontSize(15).fontColor(Color.White)
      }.type(ButtonType.Capsule)
      .margin({ top: 10 })
      .onClick((event) => {

      })
    }.height('100%')
    .width('100%')
  }
}