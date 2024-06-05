import hilog from '@ohos.hilog'

const TAG = "ExtendPage"

@Component
@Entry
struct ExtendPage {
  name: string = "default"

  clickEvent() {
    hilog.debug(0x0001, TAG, this.name)
  }

  @Builder childComponent() {
    Text(this.name)
  }

  build() {
    Column() {
      // Text('click').textStyle(this.clickEvent.bind(this))
      // ChildComponent({ child: this.childComponent })

      //default
      // ChildComponent() {
      //   this.childComponent()
      // }
    }
  }
}

@Component
struct ChildComponent {
  name: string = "ChildComponent"
  @BuilderParam
  child: () => void

  build() {
    this.child()
  }
}

@Extend(Text) function textStyle(click: () => void) {
  .onClick(click)
}