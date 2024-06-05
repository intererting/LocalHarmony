import router from '@ohos.router'
import { globalTest } from './Index'

@Component
@Entry
struct Second {
  @State person: Person = new Person('default name', 1)
  @State
  outer: Outer = new Outer()

  @Styles
  normalBackground(){
    .backgroundColor('#f00')
  }

  @Styles
  pressBackground(){
    .backgroundColor('#0f0')
  }

  aboutToAppear() {
    // globalTest()
    // let obj = { name: 'yu' }
    // for (const element of Object.keys(obj)) {
    //   console.log(element)
    // }
    // console.log(this.person?.name)
  }

  build() {
    Column({ space: 30 }) {
      Text(`${this.outer?.items?.length}`).fontWeight(FontWeight.Bold)
      Button('change state').onClick(() => {
        // this.person.name = 'change person name'
        // this.person = new Person('change person name', 11)
        // this.outer.person = new Person('change person name', 22)
        //级联的属性更新没用
        // this.outer.person.name = 'change person name'
        let itemArray = this.outer.items
        if (itemArray) {
          itemArray.shift()
          //嵌套的不行
          // itemArray.push(1)
          let copyArray = [...itemArray]
          this.outer.items = copyArray
        } else {
          console.log('empty array');
        }
      })

      Button('third').onClick((event) => {
        router.pushUrl({ url: 'pages/Third' }).catch((err) => {
        })
      })

      // Button() {
      //   Text('stateStyle')
      // }.stateStyles({
      //   normal: this.normalBackground,
      //   pressed: this.pressBackground })
      // .padding(10)

    }.width('100%')
  }
}

class Person {
  name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }
}

class Outer {
  person: Person
  tag: string
  items: number[] = [1, 2, 3]
}