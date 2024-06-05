import native from "libhsp_library.so"

export function nativeAdd(a: number, b: number) {
  return native.add(a, b);
}

@Entry
@Component
export struct Index {
  @State message: string = 'Page from hsp'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}