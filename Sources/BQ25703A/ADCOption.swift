//
//  ADCOption.swift
//
//
//  Created by Eric Wu on 2024/3/21.
//

import Foundation
import MMIO

/// ADCOption Register
@RegisterBank
public struct ADCOption {
    
    @Register(bitWidth: 8)
    public struct _3BH {
        
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var adc_conv: ADC_CONV
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var adc_start: ADC_START
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var adc_fullscale: ADC_FULLSCALE
        
        @ReadWrite(bits: 0..<5, as: Bool.self)
        public var reserved: RESERVED
        
    }
    
    @Register(bitWidth: 8)
    public struct _3AH {
        @ReadWrite(bits: 7..<8, as: Bool.self)
        public var en_adc_cmpin: EN_ADC_CMPIN
        
        @ReadWrite(bits: 6..<7, as: Bool.self)
        public var en_adc_vbus: EN_ADC_VBUS
        
        @ReadWrite(bits: 5..<6, as: Bool.self)
        public var en_adc_psys: EN_ADC_PSYS
        
        @ReadWrite(bits: 4..<5, as: Bool.self)
        public var en_adc_iin: EN_ADC_IIN
        
        @ReadWrite(bits: 3..<4, as: Bool.self)
        public var en_adc_idchg: EN_ADC_IDCHG
        
        @ReadWrite(bits: 2..<3, as: Bool.self)
        public var en_adc_ichg: EN_ADC_ICHG
        
        @ReadWrite(bits: 1..<2, as: Bool.self)
        public var en_adc_vsys: EN_ADC_VSYS
        
        @ReadWrite(bits: 0..<1, as: Bool.self)
        public var en_adc_vbat: EN_ADC_VBAT
    }
    
    @RegisterBank(offset: 0x00)
    public var _3Bh: Register<_3BH>
    
    @RegisterBank(offset: 0x01)
    public var _3Ah: Register<_3AH>
}
