import { BaseDataSource } from './BaseDataSource';

export class StringDataSource extends BaseDataSource {
  private datas: string[] = []

  setDatas(datas: string[]) {
    this.datas.length = 0
    this.datas.push(...datas)
  }

  totalCount(): number {
    return this.datas.length
  }

  getData(index: number) {
    return this.datas[index]
  }

  addData(index: number, newData: string) {
    this.datas.splice(index, 0, newData)
    this.notifyDataAdd(index)
  }

  public deleteData(index: number): void {
    this.datas.splice(index, 1);
    this.notifyDataDelete(index);
    //刷新后面的索引
    this.notifyDataReload()
  }

  public moveData(from: number, to: number): void {
    let temp: string = this.datas[from];
    this.datas[from] = this.datas[to];
    this.datas[to] = temp;
    this.notifyDataMove(from, to);
  }

  public changeData(index: number): void {
    this.notifyDataChange(index);
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(): void {
    this.datas = this.datas.map((item: string) => {
      return item + '0';
    })
  }
}