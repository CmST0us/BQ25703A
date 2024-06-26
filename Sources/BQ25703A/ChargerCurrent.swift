//
//  ChargerCurrent.swift
//  
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ChargerCurrent
@RegisterBank
public struct ChargerCurrent {
    
    @Register(bitWidth: 16)
    public struct Current {
        @ReadWrite(bits: 13..<16, as: Bool.self)
        public var reserved1: RESERVED1
        
        @ReadWrite(bits: 12..<13, as: Bool.self)
        public var bit6: BIT6
        
        @ReadWrite(bits: 11..<12, as: Bool.self)
        public var bit5: BIT5
        
        @ReadWrite(bits: 10..<11, as: Bool.self)
        public var bit4: BIT4
        
        @ReadWrite(bits: 9..<10, as: Bool.self)
        public var bit3: BIT3
        
        @ReadWrite(bits: 8..<9, as: Bool.self)
        public var bit2: BIT2
        
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var bit1: BIT1
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var bit0: BIT0
        
        @ReadWrite(bits: 0..<6, as: Bool.self)
        public var reserved2: RESERVED2
    }
    

    @RegisterBank(offset: 0x0)
    public var value: Register<Current>
}
