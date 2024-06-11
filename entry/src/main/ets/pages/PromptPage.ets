import router from '@ohos.router';

@Entry
@Component
struct PromptPage {
  build() {
    Column() {
      Button('click').onClick((event) => {
        try {
          router.showAlertBeforeBackPage({
            message: 'Message Info'
          });
        } catch (err) {
          console.error(`Invoke showAlertBeforeBackPage failed, code is ${err.code}, message is ${err.message}`);
        }
        router.back()
      })
    }
  }
}