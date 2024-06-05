import abilityAccessCtrl from '@ohos.abilityAccessCtrl'
import bundleManager from '@ohos.bundle.bundleManager';
import hilog from '@ohos.hilog';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct PermissionPage {
  context = getContext(this) as common.UIAbilityContext

  async requestPermission() {
    let tokenId: number;
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
      let atManager = abilityAccessCtrl.createAtManager();
      let grantStatus = await atManager.checkAccessToken(tokenId, 'ohos.permission.CAMERA');
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        hilog.debug(0x0001, "PermissionPageTag", "授权成功")
      } else {
        atManager.requestPermissionsFromUser(this.context, ['ohos.permission.CAMERA'], (err, result) => {
          let totalResult = true
          for (let r of result.authResults) {
            totalResult &&= (r === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
          }
          if (totalResult) {
            hilog.debug(0x0001, "PermissionPageTag", "授权成功")
          } else {
            hilog.debug(0x0001, "PermissionPageTag", "授权失败")
          }
        })
      }
    } catch (err) {
      console.error(`getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`);
    }
  }

  startSettingPage() {
    let wantInfo = {
      action: 'action.settings.app.info',
      parameters: {
        settingsParamBundleName: 'com.example.myapplication' // 打开指定应用的详情页面
      }
    }
    this.context.startAbility(wantInfo).then(() => {
    }).catch((err) => {
    })
  }

  build() {
    Column() {
      Button("申请权限").onClick((event) => {
        // 获取应用程序的accessTokenID
        // this.requestPermission()
        this.startSettingPage()
      })
    }
  }
}


