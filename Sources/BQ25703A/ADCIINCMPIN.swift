//
//  ADCIINCMPIN.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ADCVBUS_PSYS
@RegisterBank
public struct ADCIINCMPIN {
 
    @Register(bitWidth: 8)
    public struct _2BH {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var inputCurrent: InputCurrent
    }
    
    @Register(bitWidth: 8)
    public struct _2AH {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var cmpinVoltage: CMPINVoltage
    }
    
    @RegisterBank(offset: 0)
    public var _2Bh: Register<_2BH>
    
    @RegisterBank(offset: 1)
    public var _2Ah: Register<_2AH>
}
