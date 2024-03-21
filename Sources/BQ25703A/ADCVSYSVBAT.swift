//
//  ADCVSYSVBAT.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ADCVSYSVBAT
@RegisterBank
public struct ADCVSYSVBAT {
 
    @Register(bitWidth: 8)
    public struct _2DH {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var systemVoltage: SystemVoltage
    }
    
    @Register(bitWidth: 8)
    public struct _2CH {
        @ReadOnly(bits: 0..<8, as: UInt8.self)
        public var batteryVoltage: BatteryVoltage
    }
    
    @RegisterBank(offset: 0)
    public var _2Dh: Register<_2DH>
    
    @RegisterBank(offset: 1)
    public var _2Ch: Register<_2CH>
}
