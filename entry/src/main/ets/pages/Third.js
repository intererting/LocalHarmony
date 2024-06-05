var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
import router from '@ohos.router';
let localStorage = LocalStorage.GetShared();
AppStorage.SetOrCreate('pData', "pData in appStorage");
struct Thrid extends   {
    constructor() { }
    build() {
        .width("100%").justifyContent(FlexAlign.Center);
    }
}
function commonTextStyle(fontSize) {
    
  
        .fontSize(fontSize);
}
struct StateComponent extends   {
    constructor() { }
    build() {
        // Text(`${this.title} ${this.age}`).onClick(() => {
        //   this.title = 'change from component'
        //   this.age = 50
        // })
        .onClick(() => {
            this.b.msg = 'change from component';
        });
    }
}
let A = class A {
    constructor() {
        this.b = new B('default');
    }
};
A = __decorate([
    Observed
], A);
let B = class B {
    constructor(msg) {
        this.msg = msg;
    }
};
B = __decorate([
    Observed
], B);
//# sourceMappingURL=Third.js.map