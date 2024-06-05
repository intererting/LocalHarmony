@Entry
@Component
struct BuildParamPage {
  state: string = 'default'

  @Builder
  childComponent() {
    Text(this.state)
  }

  build() {
    Column() {
      this.childComponent()
      OuterComponent({ child: this.childComponent.bind(this) })
    }
  }
}

@Component
struct OuterComponent {
  state: string = "changed"
  @BuilderParam child: () => void

  build() {
    this.child()
  }
}