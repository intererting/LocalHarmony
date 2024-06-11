@Component
@Entry
struct ViewPage {
  build() {
    Column() {
      Image('/img/lufy.webp').clip(new Circle({
        width: 100, height: 100
      })).width(100).height(100)
    }
  }
}