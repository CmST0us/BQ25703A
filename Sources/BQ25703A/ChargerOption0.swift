//
//  ChargerOption0.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// Charge Option 0
@RegisterBank
public struct ChargerOption0 {
    public enum WatchDogTimerAdjust: Int, BitFieldProjectable {
        case disabled
        case enable5Second
        case enable88Second
        case enable175Second

        public static var bitWidth: Int = 2
    }
    
    @Register(bitWidth: 8)
    public struct _01H {
        
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var en_lwpwr: EN_LWPWR
        
        @ReadWrite(bits: 5..<7, as: WatchDogTimerAdjust.self)
        public var wdtmr_adj: WDTMR_ADJ
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var idpm_auto_disable: IDPM_AUTO_DISABLE
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var otg_on_chrgok: OTG_ON_CHRGOK
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var en_ooa: EN_OOA
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var pwm_freq: PWM_FREQ
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var reserved: RESERVED
        
    }
    
    @Register(bitWidth: 8)
    public struct _00H {
        @ReadWrite(bits: 6..<8, as: Bool.self)
        public var reserved: RESERVED
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var en_learn: EN_LEARN
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var iadpt_gain: IADPT_GAIN
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var ibat_gain: IBAT_GAIN
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var en_ldo: EN_LDO
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var en_idpm: EN_IDPM
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var chrg_inhibit: CHRG_INHIBIT
    }
    
    @RegisterBank(offset: 0x00)
    public var _01h: Register<_01H>
    
    @RegisterBank(offset: 0x01)
    public var _00h: Register<_00H>
}
