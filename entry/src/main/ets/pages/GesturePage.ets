// xxx.ets
@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Gesture').fontSize(28)
        // 采用gesture手势绑定方法绑定TapGesture
        .gesture(
          TapGesture()
            .onAction(() => {
              console.info('TapGesture is onAction');
            }))
    }.gesture(TapGesture().onAction((event => {
      console.info('column TapGesture is onAction');
    })), GestureMask.IgnoreInternal)
    .height(200)
    .width(250)
  }
}