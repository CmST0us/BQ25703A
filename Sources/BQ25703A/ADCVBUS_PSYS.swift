//
//  ADCVBUS_PSYS.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ADCVBUS_PSYS
@RegisterBank
public struct ADCVBUS_PSYS {
 
    @Register(bitWidth: 8)
    public struct _27H {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var inputVoltage: InputVoltage
    }
    
    @Register(bitWidth: 8)
    public struct _26H {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var systemPower: SystemPower
    }
    
    @RegisterBank(offset: 0)
    public var _27h: Register<_27H>
    
    @RegisterBank(offset: 1)
    public var _26h: Register<_26H>
}
