import ArrayList from '@ohos.util.ArrayList'
import List from '@ohos.util.List'
import LinkedList from '@ohos.util.LinkedList'
import Queue from '@ohos.util.Queue'
import Deque from '@ohos.util.Deque'
import Stack from '@ohos.util.Stack'
import HashMap from '@ohos.util.HashMap'
import HashSet from '@ohos.util.HashSet'
import TreeMap from '@ohos.util.TreeMap'
import TreeSet from '@ohos.util.TreeSet'
import LightWeightMap from '@ohos.util.LightWeightMap'
import PlainArray from '@ohos.util.PlainArray'
import LightWeightSet from '@ohos.util.LightWeightSet'

@Entry
@Component
struct CollectionPage {
  onPageShow() {
    new ArrayList()
    new List()
    new LinkedList()
    new Queue()
    new Deque()
    new Stack()
    new HashMap()
    new HashSet()
    new TreeMap()
    new TreeSet()
    new LightWeightMap()
    new LightWeightSet()
    new PlainArray()
  }

  build() {

  }
}