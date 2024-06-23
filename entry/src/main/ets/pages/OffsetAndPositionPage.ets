@Entry
@Component
struct OffsetAndPositionPage {
  build() {
    Column() {
      Row().width(100).height(100).backgroundColor(Color.Red)
      Row().width(100).height(100).backgroundColor(Color.Blue).position({ x: 100, y: 100 })
      Row().width(100).height(100).backgroundColor(Color.Pink)
    }
  }
}