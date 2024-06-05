@Entry
@Component
struct FlexLayout {
  build() {
    Flex({ direction: FlexDirection.Row }) {
      Column() {

      }.width(50).height(50).backgroundColor(Color.Blue)

      Column() {

      }.width(50).height(50).backgroundColor(Color.Red)

      Column() {

      }
      .width(50)
      .height(50)
      .backgroundColor(Color.Pink)
    }
  }
}