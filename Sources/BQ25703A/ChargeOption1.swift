//
//  ChargeOption1.swift
//  
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// Charge Option 1
@RegisterBank
public struct ChargerOption1 {
    public enum EnableProchotOnlyLowPowerMode: Int, BitFieldProjectable {
        case disable
        case enableIDCHG
        case enableVSYS
        case reserved

        public static var bitWidth: Int = 2
    }
    
    public enum IndependentComparatorDeglitchTime: Int, BitFieldProjectable {
        case disable
        case enable1us
        case enable2ms
        case enable5s
        
        public static var bitWidth: Int = 2
    }
    
    @Register(bitWidth: 8)
    public struct _31H {
        
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var en_ibat: EN_IBAT
        
        @ReadWrite(bits: 5..<7, as: EnableProchotOnlyLowPowerMode.self)
        public var en_prochot_lpwr: EN_PROCHOT_LPWR
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public  var en_psys: EN_PSYS
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var rsns_rac: RSNS_RAC
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var rsns_rsr: RSNS_RSR
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var psys_ratio: PSYS_RATIO
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var reserved: RESERVED
        
    }
    
    @Register(bitWidth: 8)
    public struct _30H {
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var cmp_ref: CMP_REF
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var cmp_pol: CMP_POL
        
        @ReadWrite(bits: 4..<6, as: IndependentComparatorDeglitchTime.self)
        public var cmp_deg: CMP_DEG
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var force_latchoff: FORCE_LATCHOFF
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var reserved: RESERVED
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var en_ship_dchg: EN_SHIP_DCHG
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var auto_wakeup_en: AUTO_WAKEUP_EN
    }
    
    @RegisterBank(offset: 0x00)
    public var _31h: Register<_31H>
    
    @RegisterBank(offset: 0x01)
    public var _30h: Register<_30H>
}
