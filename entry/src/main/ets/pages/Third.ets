import router from '@ohos.router'

let localStorage = LocalStorage.GetShared()
AppStorage.SetOrCreate('pData', "pData in appStorage")

@Entry(localStorage)
@Component
struct Thrid {
  @State
  title: string = ''
  @Provide('number')
  age: number = 0
  @State
  a: A = new A()
  @LocalStorageLink('name')
  name: string = 'default'

  build() {
    Column({ space: 30 }) {
      Text(this.name).onClick((event) => {
        this.name = 'changed from Third'
      })

      // Text(`${this.title} ${this.age}`)

      Text(`${this.a.b.msg}`)

      StateComponent({ title: $title, b: this.a.b })

      Button('state test').onClick(() => {
        // this.title = 'changed title'
        // this.age = 30

        // this.a.b = new B('changed')
        this.a.b.msg = 'change msg'

      })

      Button('back').onClick((event) => {
        router.back({ url: 'pages/Index', params: { name: 'yuliyang' } })
      })

      Button('next').onClick((event) => {
        router.pushUrl({ url: 'pages/Fourth' })
      })

    }.width("100%").justifyContent(FlexAlign.Center)
  }
}

@Extend(Text) function commonTextStyle(fontSize: number) {
  .fontSize(fontSize)
}

@Component
struct StateComponent {
  // @Prop
  @Link
  title: string
  @Consume('number') age: number
  @ObjectLink
  b: B

  build() {
    // Text(`${this.title} ${this.age}`).onClick(() => {
    //   this.title = 'change from component'
    //   this.age = 50
    // })
    Text(`${this.b.msg}`).onClick(() => {
      this.b.msg = 'change from component'
    })
  }
}

@Observed
class A {
  b: B = new B('default')
}

@Observed
class B {
  msg: string

  constructor(msg: string) {
    this.msg = msg
  }
}