import relationalStore from '@ohos.data.relationalStore';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct SqlitePage {
  context = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Button("sqlite").onClick((event) => {
        const STORE_CONFIG = {
          name: 'RdbTest.db', // 数据库文件名
          securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
        };

        const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB)'; // 建表Sql语句

        relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
          if (err) {
            console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info(`Succeeded in getting RdbStore.`);
          store.executeSql(SQL_CREATE_TABLE); // 创建数据表
          let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
          predicates.equalTo('NAME', 'Lisa');
          store.query(predicates, ['ID', 'NAME', 'AGE', 'SALARY', 'CODES'], (err, resultSet) => {
            if (err) {
              console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
              return;
            }
            console.info(`ResultSet column names: ${resultSet.columnNames.toString()}`);
            console.info(`ResultSet column count: ${resultSet.columnCount}`);
          })


          // const valueBucket = {
          //   'NAME': 'Lisa',
          //   'AGE': 18,
          //   'SALARY': 100.5,
          //   'CODES': new Uint8Array([1, 2, 3, 4, 5])
          // };
          // store.insert('EMPLOYEE', valueBucket, (err, rowId) => {
          //   if (err) {
          //     console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
          //     return;
          //   }
          //   console.info(`Succeeded in inserting data. rowId:${rowId}`);
          // })
        });
      })
    }.width('100%')
  }
}