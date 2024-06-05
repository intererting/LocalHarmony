@Entry
@Component
struct GridColumnRow {
  @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue, Color.Brown];

  build() {
    Column() {
      GridRow({
        // columns: 8
        columns: 10
        // breakpoints: {
        //   value: ['200vp', '300vp', '400vp', '500vp', '600vp'],
        //   reference: BreakpointsReference.WindowSize
        // }
      }) {
        ForEach(this.bgColors, (color, index) => {
          GridCol({
            // span: {
            //   xs: 2, // 在最小宽度类型设备上，栅格子组件占据的栅格容器2列。
            //   sm: 3, // 在小宽度类型设备上，栅格子组件占据的栅格容器3列。
            //   md: 4, // 在中等宽度类型设备上，栅格子组件占据的栅格容器4列。
            //   lg: 6, // 在大宽度类型设备上，栅格子组件占据的栅格容器6列。
            //   xl: 8, // 在特大宽度类型设备上，栅格子组件占据的栅格容器8列。
            //   xxl: 12 // 在超大宽度类型设备上，栅格子组件占据的栅格容器12列。
            // }
            // span: 2//单个item占的列数，一共8列，一个GridCol占2列，一共四列
            span: 2,
            //间隔多少个item
            offset: 1,
            order: 8 - index
          }) {
            Row() {
              Text(`${index}`)
            }.width("10%").height('50vp') //设置宽度没用
          }.backgroundColor(color)
        })
      }
    }
  }
}