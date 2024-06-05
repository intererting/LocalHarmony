import common from '@ohos.app.ability.common'
import continuationManager from '@ohos.continuation.continuationManager';
import hilog from '@ohos.hilog';

@Entry
@Component
struct CoroutinesPage {
  mContext = getContext(this) as common.UIAbilityContext

  onPageShow() {
    hilog.debug(0x0001, 'CoroutinesPage', 'onPageShow')
  }

  build() {
    Column() {
      Button('本地设备连接').onClick((event) => {
        let token = -1;
        try {
          continuationManager.registerContinuation((err, data) => {
            if (err.code != 0) {
              console.error('registerContinuation failed, cause: ' + JSON.stringify(err));
              return;
            }
            console.info('registerContinuation finished, ' + JSON.stringify(data));
            token = data;

            try {
              continuationManager.on("deviceSelected", token, (data) => {
                console.info('onDeviceSelected len: ' + data.length);
                for (let i = 0; i < data.length; i++) {
                  console.info('onDeviceSelected deviceId: ' + JSON.stringify(data[i].id));
                  console.info('onDeviceSelected deviceType: ' + JSON.stringify(data[i].type));
                  console.info('onDeviceSelected deviceName: ' + JSON.stringify(data[i].name));
                }
              });
            } catch (e) {
              hilog.debug(0x0001, 'CoroutinesPage', 'continuationManager on error')
            }
            continuationManager.startContinuationDeviceManager(token, (err, data) => {
              if (err.code != 0) {
                console.error('startContinuationDeviceManager failed, cause: ' + JSON.stringify(err));
                return;
              }
              console.info('startContinuationDeviceManager finished, ' + JSON.stringify(data));
            });

          });
        } catch (err) {
          console.error('registerContinuation failed, cause: ' + JSON.stringify(err));
        }
      })
    }
  }
}