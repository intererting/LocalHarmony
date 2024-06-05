import emitter from '@ohos.events.emitter';
import hilog from '@ohos.hilog';
let localStorage = new LocalStorage({ 'name': 'default name' });
// let localStorage = LocalStorage.GetShared()
// AppStorage.SetOrCreate('age', 1)
const pStorage = PersistentStorage.PersistProp('pData', 'default');
struct Fourth extends   {
    constructor() { }
    onAgeChange() {
        console.log(`onAgeChange ${this.age}`);
    }
    aboutToAppear() {
        log(`${1 / 0}`);
        new Promise((resolve, reject) => {
            setTimeout(() => {
                // reject('error')
                try {
                    throw 'throw err';
                }
                catch (e) {
                    hilog.debug(0x0001, 'Fourth', 'catch %s', e.message);
                }
                finally {
                    resolve('success');
                }
            }, 2000);
        }).then((data) => {
            hilog.debug(0x0001, 'Fourth', 'then %s', data);
        }).catch((reason) => {
            hilog.debug(0x0001, 'Fourth', 'reason %s', reason.message);
        });
        // let emitterEvent: emitter.InnerEvent = { eventId: 1 }
        // emitter.on(emitterEvent, (data) => {
        //   // console.log(`emitter receive ${data.data['name']}`)
        //   hilog.debug(0x0001, 'Fourth', 'emitter data %s', data.data.name)
        // })
    }
    build() {
        .width('100%');
    }
}
struct Inner extends   {
    constructor() { }
    build() {
        ;
    }
}
function log(msg) {
    hilog.debug(0x0001, 'Fourth', 'reason %s', msg);
}
var Season;
(function (Season) {
    Season["Spring"] = "spring";
    Season["Summer"] = "summer";
    Season["Autumn"] = "autumn";
    Season["Winter"] = "winter";
})(Season || (Season = {}));
//# sourceMappingURL=Fourth.js.map