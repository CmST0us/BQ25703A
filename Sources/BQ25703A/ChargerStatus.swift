//
//  RegisterBuffer.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO
import MMIOMacros
import MMIOUtilities
import MMIOVolatile

@RegisterBank
public struct ChargerStatus {
    @Register(bitWidth: 8)
    public struct _21H {
        @ReadOnly(bits: 7..<8, as: Bool.self)
        public var ac_stat: AC_STAT
        
        @ReadOnly(bits: 6..<7, as: Bool.self)
        public var ico_done: ICO_DONE
        
        @ReadOnly(bits: 5..<6, as: Bool.self)
        public var reserved: RESERVED

        @ReadOnly(bits: 4..<5, as: Bool.self)
        public var in_vindpm: IN_VINDPM

        @ReadOnly(bits: 3..<4, as: Bool.self)
        public var in_iindpm: IN_IINDPM

        @ReadOnly(bits: 2..<3, as: Bool.self)
        public var in_fchrg: IN_FCHRG

        @ReadOnly(bits: 1..<2, as: Bool.self)
        public var in_pchrg: IN_PCHRG

        @ReadOnly(bits: 0..<1, as: Bool.self)
        public var in_otg:IN_OTG
    }
    
    @Register(bitWidth: 8)
    public struct _20H {
        @ReadOnly(bits: 7..<8, as: Bool.self)
        public var fault_acov: FAULT_ACOV
        
        @ReadOnly(bits: 6..<7, as: Bool.self)
        public var fault_batoc: FAULT_BATOC
        
        @ReadOnly(bits: 5..<6, as: Bool.self)
        public var fault_acoc: FAULT_ACOC

        @ReadOnly(bits: 4..<5, as: Bool.self)
        public var sysovp_stat: SYSOVP_STAT

        @ReadOnly(bits: 3..<4, as: Bool.self)
        public var reserved: RESERVED

        @ReadOnly(bits: 2..<3, as: Bool.self)
        public var fault_latchoff: FAULT_LATCHOFF

        @ReadOnly(bits: 1..<2, as: Bool.self)
        public var fault_otg_ovp: FAULT_OTG_OVP

        @ReadOnly(bits: 0..<1, as: Bool.self)
        public var fault_otg_ucp: FAULT_OTG_UCP
    }
    
    @RegisterBank(offset: 0)
    public var _21h: Register<_21H>
    
    @RegisterBank(offset: 0x1)
    public var _20h: Register<_20H>
}
