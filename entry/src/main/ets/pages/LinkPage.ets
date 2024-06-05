import { exportObj } from './Fifth'

@Component
@Entry
struct LinkPage {
  @State name: string = 'default'

  build() {
    Column() {
      Text(`${this.name}`)
      ChildA({ name: $name })
      Button('change').onClick((event) => {
        this.name = 'changed'
      })
    }
  }
}

@Component
struct ChildA {
  @Link name: string

  build() {
    ChildB({ name: $name })
  }
}

@Component
struct ChildB {
  @Link name: string

  build() {
    Column() {
      Text(`${this.name}`)
      Button('inner change').onClick((event) => {
        this.name = "inner change"
      })
    }
  }
}

export { }