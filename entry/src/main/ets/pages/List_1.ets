@Entry
@Component
struct List1 {
  @State
  datas: Array<String> = ['1', '2', '3']

  build() {
    Column() {
      ForEach(this.datas, (item) => {
        SkeletonView().margin({ top: 20 })
      }, (item) => item)
    }.padding({ left: 20, right: 20 }).width('100%').height('100%')
  }
}

@Builder
function skeletonItem(width: string | number | Resource = '100%',
                      height: string | number | Resource) {

  Column()
    .width(width)
    .height(height)
    .backgroundColor('#FFF2F3F4')

}

@Component
struct SkeletonView {
  build() {
    Row() {
      Column() {
        skeletonItem(80, 80)
      }.margin({ right: 20, left: 20 })

      Column() {
        skeletonItem('50%', 20)
        skeletonItem('50%', 20)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Start)
      .height('100%')
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width("100%")
    .height(120)
    .backgroundColor('#FFECECEC')
    .borderRadius(8)
  }
}