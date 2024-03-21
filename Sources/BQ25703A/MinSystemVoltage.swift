//
//  MinSystemVoltage.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// MinSystemVoltage
@RegisterBank
public struct MinSystemVoltage {
    
    @Register(bitWidth: 16)
    public struct Voltage {
        @ReadOnly(bits: 14..<16, as: Bool.self)
        public var reserved1: RESERVED1
        
        @ReadOnly(bits: 13..<14, as: Bool.self)
        public var bit5: BIT5
        
        @ReadOnly(bits: 12..<13, as: Bool.self)
        public var bit4: BIT4
        
        @ReadOnly(bits: 11..<12, as: Bool.self)
        public var bit3: BIT3
        
        @ReadOnly(bits: 10..<11, as: Bool.self)
        public var bit2: BIT2
        
        @ReadOnly(bits: 9..<10, as: Bool.self)
        public var bit1: BIT1
        
        @ReadOnly(bits: 8..<9, as: Bool.self)
        public var bit0: BIT0
        
        @ReadOnly(bits: 0..<8, as: Bool.self)
        public var reserved2: RESERVED2
    }
    
    @RegisterBank(offset: 0x0)
    public var value: Register<Voltage>
}
