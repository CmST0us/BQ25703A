//
//  ChargeOption2.swift
//  
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// Charge Option 2
@RegisterBank
public struct ChargerOption2 {
    public enum PeakPowerModeInputOverloadTime: Int, BitFieldProjectable {
        case time1ms
        case time2ms
        case time10ms
        case time20ms

        public static var bitWidth: Int = 2
    }
    
    public enum PeakPowerModeOverloadAndRelaxCycleTime: Int, BitFieldProjectable {
        case time5ms
        case time10ms
        case time20ms
        case time40ms
        
        public static var bitWidth: Int = 2
    }
    
    @Register(bitWidth: 8)
    public struct _33H {
        
        @ReadWrite(bits: 6..<8, as: PeakPowerModeInputOverloadTime.self)
        public var pkpwr_tovld_deg: PKPWR_TOVLD_DEG
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var en_pkpwr_idpm: EN_PKPWR_IDPM
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var en_pkpwr_vsys: EN_PKPWR_VSYS
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var pkpwr_ovld_stat: PKPWR_OVLD_STAT
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var pkpwr_relax_stat: PKPWR_RELAX_STAT
        
        @ReadWrite(bits: 0..<2, as: PeakPowerModeOverloadAndRelaxCycleTime.self)
        public var pkpwr_tmax: PKPWR_TMAX
        
    }
    
    @Register(bitWidth: 8)
    public struct _32H {
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var en_extilim: EN_EXTILIM
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var en_ichg_idchg: EN_ICHG_IDCHG
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var q2_ocp: Q2_OCP
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var acx_ocp: ACX_OCP
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var en_acoc: EN_ACOC
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var acoc_vth: ACOC_VTH
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var en_batoc: EN_BATOC
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var batoc_vth: BATOC_VTH
    }
    
    @RegisterBank(offset: 0x00)
    public var _33h: Register<_33H>
    
    @RegisterBank(offset: 0x01)
    public var _32h: Register<_32H>
}
