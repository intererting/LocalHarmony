@Entry
@Component
struct ObservedAndLink {
  @State outer: Outer = new Outer(new Inner(0))

  build() {
    Column() {
      Text(`index ${this.outer.inner.index}`)
      InnerComponent({ inner: this.outer.inner })
      Button('changeInner').onClick((event) => {
        // this.outer.inner.index = 100
        this.outer.inner = new Inner(1000)
      })
    }
  }
}

@Component
struct InnerComponent {
  @ObjectLink
  inner: Inner

  build() {
    Column() {
      Text(`index ${this.inner.index}`)
      Button('changeInner-1').onClick((event) => {
        this.inner.index = 200
      })
    }
  }
}

@Observed
class Outer {
  constructor(public inner: Inner) {
  }
}

@Observed
class Inner {
  constructor(public index: number) {
  }
}