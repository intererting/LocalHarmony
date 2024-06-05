import emitter from '@ohos.events.emitter';
import hilog from '@ohos.hilog';

let localStorage = new LocalStorage({ 'name': 'default name' })
// let localStorage = LocalStorage.GetShared()
// AppStorage.SetOrCreate('age', 1)

const pStorage = PersistentStorage.PersistProp('pData', 'default')

@Entry(localStorage)
@Component
struct Fourth {
  // @LocalStorageProp('name')
  @LocalStorageLink('name')
  name: string = ''
  @StorageLink('age') @Watch('onAgeChange')
  age: number = -1
  @StorageLink('pData')
  pData: string = ''
  @StorageProp('colorMode')
  deviceColorMode: number = 0
  @StorageProp('fontScale')
  fontScale: number = 0

  onAgeChange() {
    console.log(`onAgeChange ${this.age}`);
  }

  aboutToAppear() {

    log(`${1 / 0}`)

    new Promise((resolve, reject) => {
      setTimeout(() => {
        // reject('error')
        try {
          throw 'throw err'
        } catch (e) {
          hilog.debug(0x0001, 'Fourth', 'catch %s', (e as Error).message)
        } finally {
          resolve('success')
        }
      }, 2000)

    }).then((data) => {
      hilog.debug(0x0001, 'Fourth', 'then %s', data)
    }).catch((reason: Error) => {
      hilog.debug(0x0001, 'Fourth', 'reason %s', reason.message)
    })

    // let emitterEvent: emitter.InnerEvent = { eventId: 1 }
    // emitter.on(emitterEvent, (data) => {
    //   // console.log(`emitter receive ${data.data['name']}`)
    //   hilog.debug(0x0001, 'Fourth', 'emitter data %s', data.data.name)
    // })
  }

  build() {
    Column({ space: 20 }) {
      Text('fourth')

      Text(`${this.fontScale}`)

      Text(`${Season.Spring == 'spring'}`)

      Text(`${this.pData}`)

      // Text(`${this.name}`)
      // Text(`${this.age}`)

      // Inner()
      Button('change state').onClick((evnet) => {
        // this.name = 'changed'
        // this.age = 100
        // localStorage.set('name', 'changed')
        // AppStorage.Set('age', 100)

        this.pData = 'change persistence data'
      })

      Button() {
        Text('emitter').padding(10)
      }.onClick((event) => {
        let emitterEvent: emitter.InnerEvent = { eventId: 1 }
        emitter.emit(emitterEvent, { data: { 'name': 'yu', 'age': 20 } })
      })

    }.width('100%')
  }
}

@Component
struct Inner {
  @LocalStorageProp('name')
  name: string = 'default'

  build() {
    Text(`${this.name}`)
  }
}

function log(msg: string) {
  hilog.debug(0x0001, 'Fourth', 'reason %s', msg)
}

enum Season {
  Spring = 'spring', Summer = 'summer', Autumn = 'autumn', Winter = 'winter'
}