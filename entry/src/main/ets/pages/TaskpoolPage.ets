import taskpool from '@ohos.taskpool';
import hilog from '@ohos.hilog';

// @ts-ignore
@Concurrent
function add(num1: number, num2: number): number {
  return num1 + num2;
}

async function ConcurrentFunc(): Promise<void> {
  try {
    let task: taskpool.Task = new taskpool.Task(add, 1, 2);
    console.info("taskpool res is: " + await taskpool.execute(task));
  } catch (e) {
    console.error("taskpool execute error is: " + e);
  }
}

@Entry
@Component
struct TaskpoolPage {
  onPageShow() {
    this.test()
    hilog.debug(0x0001, 'TaskpoolPageTag', 'after')
  }

  test() {
    new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve("success")
      }, 1000)
    }).then((data) => {
      hilog.debug(0x0001, 'TaskpoolPageTag', 'then')
      return true
    }).catch((err) => {
      return false
    })
  }

  build() {
    Row() {
      Column() {
        Button('taskpool').onClick((event) => {
          ConcurrentFunc()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}



















