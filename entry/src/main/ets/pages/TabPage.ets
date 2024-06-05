@Entry
@Component
struct TabPage {
  @Builder
  tabBuilder() {
    Column() {
      Image($r('app.media.icon'))
    }
  }

  build() {
    Column() {
      Tabs() {
        TabContent() {
          Text('首页')
        }.tabBar(this.tabBuilder())

        TabContent() {
          Text('我的')
        }.tabBar('我的')
      }.barMode(BarMode.Fixed).tabIndex(1)

    }.width('100%').height('100%')
  }
}