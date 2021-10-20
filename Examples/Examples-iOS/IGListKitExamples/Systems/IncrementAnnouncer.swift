/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import UIKit

/// 增量监听协议【Increment：增量】
@objc protocol IncrementListener: class {
    ///【announcer：播音员、广播员】
    func didIncrement(announcer: IncrementAnnouncer, value: Int)
}

/// 增量广播员
/// 方法1: 添加监听者，监听者遵循“IncrementListener”协议
/// 方法2: 广播，遍历监听者调用其遵循协议中的响应方法
final class IncrementAnnouncer: NSObject {

    private var value: Int = 0
    private let map: NSHashTable<IncrementListener> = NSHashTable<IncrementListener>.weakObjects()

    func addListener(listener: IncrementListener) {
        map.add(listener)
    }

    func increment() {
        value += 1
        for listener in map.allObjects {
            listener.didIncrement(announcer: self, value: value)
        }
    }

}
