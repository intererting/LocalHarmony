// @Entry
import hilog from '@ohos.hilog'
import router from '@ohos.router'
// @Component
// struct Index {
//   @State message: string = 'Hello World'
//
//   build() {
//     Row() {
//       Column() {
//         Text(this.message)
//           .fontSize(50)
//           .fontWeight(FontWeight.Bold)
//       }
//       .width('100%')
//     }
//     .height('100%')
//   }
// }

@Entry
@Component
struct Index {
  @State
  message: string = "Hello World"

  onPageShow() {
    console.log("onPageShow 1")
  }

  onPageHide() {
    console.log('onPageHide')
  }

  onBackPress() {
    console.log('onBackPress')
  }

  aboutToAppear() {

  }

  aboutToDisappear() {

  }

  @Builder
  myBuilderComponent($$: { message: string }) {
    Text(`myBuilderComponent ${$$.message}`)
  }

  @Builder
  myBuildParamComponent() {
    Text(`myBuildParamComponent ${this.message}`)
  }

  build() {
    Row({ space: 3 }) {
      Column({ space: 30 }) {
        // this.myBuilderComponent({ message: this.message })

        // MyComponent({
        //   param1: this.message,
        //   param2: true,
        //   buildParamWithParam: this.myBuilderComponent
        // }).width(200)

        MyComponentLambda() {
          Text('lambda').commonTextStyle()
        }


        // Text(`${this.message}`).fontColor($r('app.color.red'))
        //   .fontStyle(FontStyle.Italic)
        //   .fontWeight(500)
        Button() {
          Text($r('app.string.next')).padding(10).fontSize(14)
        }.type(ButtonType.Circle)
        .onClick(event => {
          router.pushUrl({ url: 'pages/Second' }).then((data) => {
            console.log('1');
            console.log(`back ${data}`)
          }, (err) => {
            console.log('2')
          }).catch((error) => {
            console.log('3')
          })
        }).width(100).height(100)

        // Image($r('app.media.app_icon')).objectFit(ImageFit.Contain).width(100).height(100)
        //   .onClick(function(event){
        //     console.log('xxx')
        //     this.message = 'changed'
        //   }.bind(this))

      }.justifyContent(FlexAlign.Center).width('100%')
    }.justifyContent(FlexAlign.Center).height('100%')

  }
}

@Component
struct MyComponentLambda {
  @BuilderParam buildParam: () => void

  build() {
    this.buildParam()
  }
}

@Component
struct MyComponent {
  @Prop
  param1: string
  param2: boolean = false
  @BuilderParam
  buildParam: () => void
  @BuilderParam
  buildParamWithParam: ($$: { message: string }) => void
  message: string = 'message in MyComponent'

  aboutToAppear() {

  }

  aboutToDisappear() {

  }

  build() {
    // this.buildParam()
    this.buildParamWithParam({ message: 'param in build' })
  }

  onPageShow() {
    console.log('onPageShow 2')
  }
}

@Extend(Text) function commonTextStyle() {
  .fontSize(15)
}

export { globalTest }

function globalTest() {
  console.log('globalTest')
}















