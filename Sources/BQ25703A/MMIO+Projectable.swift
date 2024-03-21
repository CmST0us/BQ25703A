//
//  MMIO+Projectable.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

public extension UInt8: BitFieldProjectable {
    func storage<Storage>(_ type: Storage.Type) -> Storage where Storage : FixedWidthInteger, Storage : UnsignedInteger {
        return type.init(self)
    }
    
    init<Storage>(storage: Storage) where Storage: FixedWidthInteger & UnsignedInteger {
        self.init(storage)
    }
}
