//
//  ChargeOption3.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// Charge Option 3
@RegisterBank
public struct ChargerOption3 {
    
    @Register(bitWidth: 8)
    public struct _35H {
        
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var en_hiz: EN_HIZ
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var reset_reg: RESET_REG
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var reset_vindpm: RESET_VINDPM
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var en_otg: EN_OTG
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var en_ico_mode: EN_ICO_MODE
        
        @ReadWrite(bits: 0..<3, as: Bool.self)
        public var reserved: RESERVED
        
    }
    
    @Register(bitWidth: 8)
    public struct _34H {
        @ReadWrite(bits: 2..<8, as: Bool.self)
        public var reserved: RESERVED
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var batfetoff_hiz: BATFETOFF_HIZ
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var psys_otg_idchg: PSYS_OTG_IDCHG
    }
    
    @RegisterBank(offset: 0x00)
    public var _35h: Register<_35H>
    
    @RegisterBank(offset: 0x01)
    public var _34h: Register<_34H>
}
