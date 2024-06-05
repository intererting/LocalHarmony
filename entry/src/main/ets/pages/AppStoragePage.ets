AppStorage.SetOrCreate("key", 'yuliyang')

@Entry
@Component
struct AppStoragePage {
  @StorageProp('key') name: string = 'default'

  build() {
    Column() {
      Text(`${this.name}`)
      // AppStorageChildComponent({ name: this.name })
    }
  }
}

@Component
struct AppStorageChildComponent {
  @Prop name: string

  build() {
    Text(`${this.name}`)
  }
}