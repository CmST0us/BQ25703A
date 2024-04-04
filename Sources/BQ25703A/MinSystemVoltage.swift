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
        @ReadWrite(bits: 14..<16, as: Bool.self)
        public var reserved1: RESERVED1
        
        @ReadWrite(bits: 13..<14, as: Bool.self)
        public var bit5: BIT5
        
        @ReadWrite(bits: 12..<13, as: Bool.self)
        public var bit4: BIT4
        
        @ReadWrite(bits: 11..<12, as: Bool.self)
        public var bit3: BIT3
        
        @ReadWrite(bits: 10..<11, as: Bool.self)
        public var bit2: BIT2
        
        @ReadWrite(bits: 9..<10, as: Bool.self)
        public var bit1: BIT1
        
        @ReadWrite(bits: 8..<9, as: Bool.self)
        public var bit0: BIT0
        
        @ReadWrite(bits: 0..<8, as: Bool.self)
        public var reserved2: RESERVED2
    }
    
    @RegisterBank(offset: 0x0)
    public var value: Register<Voltage>
}
