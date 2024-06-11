import router from '@ohos.router'

@Component
@Entry
struct ExportPageA {
  @State info: string = "default"

  onPageShow() {
    this.info = a.name
  }

  build() {
    Column() {
      Text(`${this.info}`)
      Button('click').onClick((event) => {
        router.pushUrl({ url: 'pages/ExportPageB' }, (data, err) => {

        })
      })
    }
  }
}

var a = { name: 'yu' }

export { a }