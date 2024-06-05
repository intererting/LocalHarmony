import axios, { AxiosInstance, AxiosResponse, FormData } from '@ohos/axios';
import hilog from '@ohos.hilog';
import fs from '@ohos.file.fs'
import fileIo from '@ohos.file.fs'
import image from '@ohos.multimedia.image';
import picker from '@ohos.file.picker';
import util from '@ohos.util';
import request from '@ohos.request';

const TAG = "AxiosPageTag"

@Entry
@Component
struct AxiosPage {
  instance: AxiosInstance

  aboutToAppear() {
    this.instance = axios.create({
      baseURL: 'http://192.168.0.108:8080/',
      timeout: 30000,
    });

    // Add a request interceptor
    this.instance.interceptors.request.use(function (config) {
      // Do something before request is sent
      // hilog.debug(0x0001, TAG, JSON.stringify(config))
      return config;
    }, function (error) {
      // Do something with request error
      return Promise.reject(error);
    });
  }

  build() {
    Column({ space: 10 }) {

      Image("/img/lufy.webp").width(100).height(100)

      Button('Get请求').onClick((event) => {
        this.instance.get <HttpResponseEntity>("get", {
          params: {
            param: 12345
          }
        }).then(result => {
          hilog.debug(0x0001, TAG, JSON.stringify(result.data.result))
        })
          .catch(err => {
            hilog.debug(0x0001, TAG, JSON.stringify(err))
          })
          .finally(() => {
            hilog.debug(0x0001, TAG, 'finally')
          })
      })

      Button('Post请求urlencoded').onClick((event) => {
        this.instance.post <HttpResponseEntity>("post", "name=yuliyang&age=1", {}).then(result => {
          hilog.debug(0x0001, TAG, result.data.result)
        })
          .catch(err => {
            hilog.debug(0x0001, TAG, `error ${JSON.stringify(err)}`)
          })
          .finally(() => {
            hilog.debug(0x0001, TAG, 'finally')
          })
      })

      Button('Post请求json').onClick((event) => {
        this.instance.post <HttpResponseEntity>("post/json", { name: "yuliyang" }, {}).then(result => {
          hilog.debug(0x0001, TAG, result.data.result)
        })
          .catch(err => {
            hilog.debug(0x0001, TAG, `error ${JSON.stringify(err)}`)
          })
          .finally(() => {
            hilog.debug(0x0001, TAG, 'finally')
          })
      })

      Button('file').onClick((event) => {
        let PhotoSelectOptions = new picker.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
        PhotoSelectOptions.maxSelectNumber = 5;
        let photoPicker = new picker.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions).then((result) => {
          hilog.debug(0x0001, TAG, JSON.stringify(result))
          let uri = result.photoUris[0]
          const file = fs.openSync(uri, fs.OpenMode.READ_ONLY)
          const cacheDir = getContext(this).cacheDir
          const cacheFilePath = cacheDir + "/lufy.webp"
          const cacheFile = fs.openSync(cacheFilePath, fs.OpenMode.WRITE_ONLY | fs.OpenMode.CREATE)
          const buffer = new ArrayBuffer(4096)
          let offset = 0
          while (true) {
            let hasRead = fs.readSync(file.fd, buffer, { offset: offset })
            if (hasRead > 0) {
              fs.writeSync(cacheFile.fd, buffer, { offset: offset, length: hasRead })
              offset += hasRead
            } else {
              break
            }
          }
          fs.fsyncSync(cacheFile.fd)
          fs.closeSync(cacheFile.fd)
          fs.closeSync(file.fd)
          let uploadConfig = {
            url: 'http://192.168.0.108:8080/file',
            method: 'POST',
            header: {},
            files: [
              { filename: 'lufy.webp', name: 'lufy', uri: 'internal://cache/lufy.webp', type: 'image/webp' }
            ],
            data: [
              { name: 'name', value: 'yuliyang' }
            ]
          }
          request.uploadFile(getContext(this), uploadConfig)
            .then((uploadTask) => {
              uploadTask.on('complete', (taskStates) => {
                hilog.debug(0x0001, TAG, "success")
              });
            })
            .catch((err) => {
              console.error(`Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
            })
        }).catch((err) => {
          hilog.debug(0x0001, TAG, `error ${JSON.stringify(err)}`)
        });


      })
    }
  }
}

class HttpResponseEntity {
  constructor(public result: string) {
  }
}
