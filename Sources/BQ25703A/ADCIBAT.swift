//
//  ADCIBAT.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ADCIBAT
@RegisterBank
public struct ADCIBAT {
 
    @Register(bitWidth: 8)
    public struct _29H {
        @ReadOnly(bits: 7..<8, as: Bool.self)
        var reserved: RESERVED
        
        @ReadOnly(bits: 0..<7, as: UInt8.self)
        var batteryChargeCurrent: BatteryChargeCurrent
    }
    
    @Register(bitWidth: 8)
    public struct _28H {
        @ReadOnly(bits: 7..<8, as: Bool.self)
        var reserved: RESERVED
        
        @ReadOnly(bits: 0..<7, as: UInt8.self)
        var batteryDischargeCurrent: BatteryDischargeCurrent
    }
    
    @RegisterBank(offset: 0)
    public var _29h: Register<_29H>
    
    @RegisterBank(offset: 1)
    public var _28h: Register<_28H>
}
