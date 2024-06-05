import router from '@ohos.router';
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
struct Index extends   {
    constructor(// @Entry
    // @Entry
    // @Entry
    ) {
        // @Entry
    }
    onPageShow() {
        console.log("onPageShow 1");
    }
    onPageHide() {
        console.log('onPageHide');
    }
    onBackPress() {
        console.log('onBackPress');
    }
    aboutToAppear() {
    }
    aboutToDisappear() {
    }
    myBuilderComponent($$) {
        ;
    }
    myBuildParamComponent() {
        ;
    }
    build() {
        .justifyContent(FlexAlign.Center).height('100%');
    }
}
struct MyComponentLambda extends   {
    constructor(// @Entry
    // @Entry
    // @Entry
    ) {
        // @Entry
    }
    build() {
        this.buildParam();
    }
}
struct MyComponent extends   {
    constructor(// @Entry
    // @Entry
    // @Entry
    ) {
        // @Entry
    }
    aboutToAppear() {
    }
    aboutToDisappear() {
    }
    build() {
        // this.buildParam()
        this.buildParamWithParam({ message: 'param in build' });
    }
    onPageShow() {
        console.log('onPageShow 2');
    }
}
function commonTextStyle() {
    
  
        .fontSize(15);
}
export { globalTest };
function globalTest() {
    console.log('globalTest');
}
//# sourceMappingURL=Index.js.map