import { a as pageA } from './ExportPageA'

@Component
@Entry
struct ExportPageB {
  aboutToAppear() {
    pageA.name = "changed"
  }

  build() {
    Column() {
      Text(`${pageA}`)
    }
  }
}