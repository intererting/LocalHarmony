@Component
@Entry
struct ProvidePage {
  @Provide("name") name: string = 'default'

  build() {
    Column() {
      Text(`${this.name}`)
      ChildA()
      Button('change').onClick((event) => {
        this.name = 'changed'
      })
    }
  }
}

@Component
struct ChildA {
  @Consume("name") name: string

  build() {
    ChildB()
  }
}

@Component
struct ChildB {
  @Consume("name") name: string

  build() {
    Column() {
      Text(`${this.name}`)
      Button('inner change provide').onClick((event) => {
        this.name = "inner change"
      })
    }
  }
}