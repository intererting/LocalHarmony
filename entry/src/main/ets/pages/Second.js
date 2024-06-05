import router from '@ohos.router';
struct Second extends   {
    constructor() { }
    normalBackground() {
        
    
            .backgroundColor('#f00');
    }
    pressBackground() {
        
    
            .backgroundColor('#0f0');
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
        .width('100%');
    }
}
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
}
class Outer {
    constructor() {
        this.items = [1, 2, 3];
    }
}
//# sourceMappingURL=Second.js.map