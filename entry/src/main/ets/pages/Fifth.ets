import router from '@ohos.router'

@Entry
@Component
struct Fifth {
  @State
  datas: string[] = ['a', 'b', 'c']

  onPageShow() {
    console.log(`${exportObj.name}`)
  }

  build() {
    Column({ space: 30 }) {
      Text('fifth').fontSize(15)
      Button() {
        Text('change array').padding(10).fontColor(Color.White)
      }.onClick((event) => {
        this.datas[2]='new c'
      })

      Button() {
        Text('sixth').padding(10)
      }.onClick((event) => {
        router.pushUrl({ url: 'pages/Sixth' })
      })

      ForEach(this.datas, (item, index) => {
        ChildItem({ data: `${item as string} ${index}` })
      }, (item: string) => item)

    }.width('100%')
  }
}

let exportObj = { name: 'yuliyang' }

export { exportObj }

@Component
struct ChildItem {
  @Prop
  data: string

  build() {
    Text(this.data)
  }
}