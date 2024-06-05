import huks from '@ohos.security.huks';
import userIAM_userAuth from '@ohos.userIAM.userAuth';

/*
 * 确定密钥别名和封装密钥属性参数集
 */
let keyAlias = 'dh_key_fingerprint_access';
let propertiesKey = new Array();
propertiesKey[0] = {
  tag: huks.HuksTag.HUKS_TAG_ALGORITHM,
  value: huks.HuksKeyAlg.HUKS_ALG_SM4,
}
propertiesKey[1] = {
  tag: huks.HuksTag.HUKS_TAG_PURPOSE,
  value: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT | huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
}
propertiesKey[2] = {
  tag: huks.HuksTag.HUKS_TAG_KEY_SIZE,
  value: huks.HuksKeySize.HUKS_SM4_KEY_SIZE_128,
}
propertiesKey[3] = {
  tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE,
  value: huks.HuksCipherMode.HUKS_MODE_CBC,
}
propertiesKey[4] = {
  tag: huks.HuksTag.HUKS_TAG_PADDING,
  value: huks.HuksKeyPadding.HUKS_PADDING_NONE,
}
// 指定密钥身份认证的类型：指纹
propertiesKey[5] = {
  tag: huks.HuksTag.HUKS_TAG_USER_AUTH_TYPE,
  value: huks.HuksUserAuthType.HUKS_USER_AUTH_TYPE_FINGERPRINT
}
// 指定密钥安全授权的类型（失效类型）：新录入生物特征（指纹）后无效
propertiesKey[6] = {
  tag: huks.HuksTag.HUKS_TAG_KEY_AUTH_ACCESS_TYPE,
  value: huks.HuksAuthAccessType.HUKS_AUTH_ACCESS_INVALID_NEW_BIO_ENROLL
}
// 指定挑战值的类型：默认类型
propertiesKey[7] = {
  tag: huks.HuksTag.HUKS_TAG_CHALLENGE_TYPE,
  value: huks.HuksChallengeType.HUKS_CHALLENGE_TYPE_NORMAL
}
let huksOptionsKey = {
  properties: propertiesKey,
  inData: new Uint8Array(new Array())
}

/*
 *生成密钥
 */
function generateKeyItem(keyAlias: string, huksOptions: huks.HuksOptions, throwObject) {
  return new Promise((resolve, reject) => {
    try {
      huks.generateKeyItem(keyAlias, huksOptions, function (error, data) {
        if (error) {
          reject(error);
        } else {
          resolve(data);
        }
      });
    } catch (error) {
      throwObject.isThrow = true;
      throw (error);
    }
  });
}

async function publicGenKeyFunc(keyAlias: string, huksOptions: huks.HuksOptions) {
  console.info(`enter callback generateKeyItem`);
  let throwObject = { isThrow: false };
  try {
    await generateKeyItem(keyAlias, huksOptions, throwObject)
      .then((data) => {
        console.info(`callback: generateKeyItem success, data = ${JSON.stringify(data)}`);
      })
      .catch(error => {
        if (throwObject.isThrow) {
          throw (error);
        } else {
          console.error(`callback: generateKeyItem failed, code: ${error.code}, msg: ${error.message}`);
        }
      });
  } catch (error) {
    console.error(`callback: generateKeyItem input arg invalid, code: ${error.code}, msg: ${error.message}`);
  }
}


/*
 * 确定密钥别名和封装密钥属性参数集
 */
let srcKeyAlias = 'sm4_key_fingerprint_access';
let handle;
let challenge;
let fingerAuthToken;
let authType = userIAM_userAuth.UserAuthType.FINGERPRINT;
let authTrustLevel = userIAM_userAuth.AuthTrustLevel.ATL1;

/* 集成生成密钥参数集 & 加密参数集 */
let properties = new Array();
properties[0] = {
  tag: huks.HuksTag.HUKS_TAG_ALGORITHM,
  value: huks.HuksKeyAlg.HUKS_ALG_SM4,
}
properties[1] = {
  tag: huks.HuksTag.HUKS_TAG_PURPOSE,
  value: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT | huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT,
}
properties[2] = {
  tag: huks.HuksTag.HUKS_TAG_KEY_SIZE,
  value: huks.HuksKeySize.HUKS_SM4_KEY_SIZE_128,
}
properties[3] = {
  tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE,
  value: huks.HuksCipherMode.HUKS_MODE_CBC,
}
properties[4] = {
  tag: huks.HuksTag.HUKS_TAG_PADDING,
  value: huks.HuksKeyPadding.HUKS_PADDING_NONE,
}
let huksOptions = {
  properties: properties,
  inData: new Uint8Array(new Array())
}

function initSession(keyAlias: string, huksOptions: huks.HuksOptions, throwObject): Promise<huks.HuksSessionHandle> {
  return new Promise((resolve, reject) => {
    try {
      huks.initSession(keyAlias, huksOptions, function (error, data) {
        if (error) {
          reject(error);
        } else {
          resolve(data);
        }
      });
    } catch (error) {
      throwObject.isThrow = true;
      throw (error);
    }
  });
}

async function publicInitFunc(keyAlias: string, huksOptions: huks.HuksOptions) {
  console.info(`enter callback doInit`);
  let throwObject = { isThrow: false };
  try {
    await initSession(keyAlias, huksOptions, throwObject)
      .then((data) => {
        console.info(`callback: doInit success, data = ${JSON.stringify(data)}`);
        handle = data.handle;
        challenge = data.challenge;
      })
      .catch((error) => {
        if (throwObject.isThrow) {
          throw (error);
        } else {
          console.error(`callback: doInit failed, code: ${error.code}, msg: ${error.message}`);
        }
      });
  } catch (error) {
    console.error(`callback: doInit input arg invalid, code: ${error.code}, msg: ${error.message}`);
  }
}

function userIAMAuthFinger(huksChallenge: Uint8Array) {
  // 获取认证对象
  let auth;
  try {
    auth = userIAM_userAuth.getAuthInstance(huksChallenge, authType, authTrustLevel);
    console.log("get auth instance success");
  } catch (error) {
    console.log("get auth instance failed" + error);
  }

  // 订阅认证结果
  try {
    auth.on("result", {
      callback: (result: userIAM_userAuth.AuthResultInfo) => {
        console.log("fingerAuthToken event success");
        /* 认证成功获取认证令牌 */
        fingerAuthToken = result.token;
      }
    });
    console.log("subscribe authentication event success");
  } catch (error) {
    console.log("subscribe authentication event failed " + error);
  }

  // 开始认证
  try {
    auth.start();
    console.info("authV9 start auth success");
  } catch (error) {
    console.info("authV9 start auth failed, error = " + error);
  }
}

async function testInitAndAuthFinger() {
  /* 初始化密钥会话获取挑战值 */
  await publicInitFunc(keyAlias, huksOptions);
  /* 调用userIAM进行身份认证 */
  userIAMAuthFinger(challenge);
}

/*
 * 确定密钥别名和封装密钥属性参数集
 */
let IV = '1234567890123456';
let cipherInData = 'Hks_SM4_Cipher_Test_101010101010101010110_string';
let finishOutData;

/* 集成生成密钥参数集 & 加密参数集 */
let propertiesEncrypt = new Array();
propertiesEncrypt[0] = {
  tag: huks.HuksTag.HUKS_TAG_ALGORITHM,
  value: huks.HuksKeyAlg.HUKS_ALG_SM4,
}
propertiesEncrypt[1] = {
  tag: huks.HuksTag.HUKS_TAG_PURPOSE,
  value: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT,
}
propertiesEncrypt[2] = {
  tag: huks.HuksTag.HUKS_TAG_KEY_SIZE,
  value: huks.HuksKeySize.HUKS_SM4_KEY_SIZE_128,
}
propertiesEncrypt[3] = {
  tag: huks.HuksTag.HUKS_TAG_PADDING,
  value: huks.HuksKeyPadding.HUKS_PADDING_NONE,
}
propertiesEncrypt[4] = {
  tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE,
  value: huks.HuksCipherMode.HUKS_MODE_CBC,
}
propertiesEncrypt[5] = {
  tag: huks.HuksTag.HUKS_TAG_IV,
  value: StringToUint8Array(IV),
}
let encryptOptions = {
  properties: propertiesEncrypt,
  inData: new Uint8Array(new Array())
}

function StringToUint8Array(str) {
  let arr = [];
  for (let i = 0, j = str.length; i < j; ++i) {
    arr.push(str.charCodeAt(i));
  }
  return new Uint8Array(arr);
}

function updateSession(handle: number, huksOptions: huks.HuksOptions, token: Uint8Array, throwObject): Promise<huks.HuksReturnResult> {
  return new Promise((resolve, reject) => {
    try {
      huks.updateSession(handle, huksOptions, token, function (error, data) {
        if (error) {
          reject(error);
        } else {
          resolve(data);
        }
      });
    } catch (error) {
      throwObject.isThrow = true;
      throw (error);
    }
  });
}

async function publicUpdateFunc(handle: number, token: Uint8Array, huksOptions: huks.HuksOptions) {
  console.info(`enter callback doUpdate`);
  let throwObject = { isThrow: false };
  try {
    await updateSession(handle, huksOptions, token, throwObject)
      .then((data) => {
        console.info(`callback: doUpdate success, data = ${JSON.stringify(data)}`);
      })
      .catch(error => {
        if (throwObject.isThrow) {
          throw (error);
        } else {
          console.error(`callback: doUpdate failed, code: ${error.code}, msg: ${error.message}`);
        }
      });
  } catch (error) {
    console.error(`callback: doUpdate input arg invalid, code: ${error.code}, msg: ${error.message}`);
  }
}

function finishSession(handle: number, huksOptions: huks.HuksOptions, token: Uint8Array, throwObject): Promise<huks.HuksReturnResult> {
  return new Promise((resolve, reject) => {
    try {
      huks.finishSession(handle, huksOptions, token, function (error, data) {
        if (error) {
          reject(error);
        } else {
          resolve(data);
        }
      });
    } catch (error) {
      throwObject.isThrow = true;
      throw (error);
    }
  });
}

async function publicFinishFunc(handle: number, token: Uint8Array, huksOptions: huks.HuksOptions) {
  console.info(`enter callback doFinish`);
  let throwObject = { isThrow: false };
  try {
    await finishSession(handle, huksOptions, token, throwObject)
      .then((data) => {
        finishOutData = data.outData;
        console.info(`callback: doFinish success, data = ${JSON.stringify(data)}`);
      })
      .catch(error => {
        if (throwObject.isThrow) {
          throw (error);
        } else {
          console.error(`callback: doFinish failed, code: ${error.code}, msg: ${error.message}`);
        }
      });
  } catch (error) {
    console.error(`callback: doFinish input arg invalid, code: ${error.code}, msg: ${error.message}`);
  }
}

async function testSm4Cipher() {
  encryptOptions.inData = StringToUint8Array(cipherInData);
  /* 传入认证令牌 */
  await publicUpdateFunc(handle, fingerAuthToken, encryptOptions);

  encryptOptions.inData = new Uint8Array(new Array());
  /* 传入认证令牌 */
  await publicFinishFunc(handle, fingerAuthToken, encryptOptions);
  console.info(`result ${finishOutData}`);
  if (finishOutData === cipherInData) {
    console.info('test finish encrypt err ');
  } else {
    console.info('test finish encrypt success');
  }
}


@Entry
@Component
struct KeyStorePage {
  build() {
    Column() {
      Button("生成key").onClick((event) => {
        publicGenKeyFunc(keyAlias, huksOptionsKey);
      })

      Button("授权").onClick((event) => {
        testInitAndAuthFinger()
      })

      Button("加密测试").onClick((event) => {
        testSm4Cipher()
      })
    }
  }
}