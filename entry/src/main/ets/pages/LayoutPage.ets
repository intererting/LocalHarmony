@Entry
@Component
struct LayoutPage {
  datas = [1, 2, 3, 4, 5]
  scroller = new Scroller()

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text('1').height(50).backgroundColor(0xF5DEB3).margin({ right: 10 })
      Flex() {
        Text('222222222222222222222222222222222222222222')
          .height(50)
          .backgroundColor(0xD2B48C)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text('333333333').width(50).height(50).backgroundColor(Color.Red).textOverflow({overflow:TextOverflow.Clip})
      }
    }
    .width('100%').height('50%')
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }
}