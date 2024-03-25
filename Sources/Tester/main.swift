// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftTUI
import MMIO
import MMIOMacros
import MMIOUtilities
import MMIOVolatile
import BQ25703A

struct ContentView: View {
    
    @State var maxChargeVoltage: Int = 0
    
    @State var chargerCurrent: Int = 0
    
    @State var minSystemVoltage: Int = 0
    
    @State var isCharging: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            VStack {
                Text("BQ25703 Charging Status")
                VStack(alignment: .leading, spacing: 1) {
                    Text(isCharging ? "Charging" : "Discharging")
                    Text("Max Charge Voltage: \(maxChargeVoltage)")
                    Text("Charger Current: \(chargerCurrent)")
                    Text("Min System Voltage: \(minSystemVoltage)")
                }.border()
            }
            
            VStack {
                Text("BQ25703 Data Mock")
                VStack(alignment: .leading) {
                    HStack {
                        Text("ChargerStatus (21h/20h): ")
                        TextField { currentString in
                            if let data = currentString.data(using: .hexadecimal) {
                                data.withUnsafeBytes { ptr in
                                    if let bufferBaseAddress = ptr.baseAddress {
                                        let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                        let control = ChargerStatus(unsafeAddress: bufferMemoryAddress)
                                        isCharging = control._21h.read().ac_stat
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Max Charge Voltage (05h/04h): ")
                        TextField { currentString in
                            if let data = currentString.data(using: .hexadecimal) {
                                data.withUnsafeBytes { ptr in
                                    if let bufferBaseAddress = ptr.baseAddress {
                                        let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                        let control = MaxChargeVoltage(unsafeAddress: bufferMemoryAddress)
                                        let storage = UInt16(bigEndian: control.value.read().raw.storage)
                                        
                                        var voltage: Int = 0
                                        for bit in 4..<15 {
                                            let enable = (storage >> bit) & 0x01
                                            let addVoltage = 16 * powf(2, Float(bit - 4))
                                            if enable == 1 {
                                                voltage = voltage + Int(addVoltage)
                                            }
                                        }
                                        maxChargeVoltage = voltage
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Charger Current (05h/04h): ")
                        TextField { currentString in
                            if let data = currentString.data(using: .hexadecimal) {
                                data.withUnsafeBytes { ptr in
                                    if let bufferBaseAddress = ptr.baseAddress {
                                        let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                        let control = ChargerCurrent(unsafeAddress: bufferMemoryAddress)
                                        let storage = UInt16(bigEndian: control.value.read().raw.storage)
                                        
                                        var current: Int = 0
                                        for bit in 6..<13 {
                                            let enable = (storage >> bit) & 0x01
                                            let addCurrent = 64 * powf(2, Float(bit - 6))
                                            if enable == 1 {
                                                current = current + Int(addCurrent)
                                            }
                                        }
                                        chargerCurrent = current
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Min System Voltage (0Dh/0Ch): ")
                        TextField { currentString in
                            if let data = currentString.data(using: .hexadecimal) {
                                data.withUnsafeBytes { ptr in
                                    if let bufferBaseAddress = ptr.baseAddress {
                                        let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                        let control = MinSystemVoltage(unsafeAddress: bufferMemoryAddress)
                                        let storage = UInt16(bigEndian: control.value.read().raw.storage)
                                        
                                        var voltage: Int = 0
                                        for bit in 8..<14 {
                                            let enable = (storage >> bit) & 0x01
                                            let addVoltage = 256 * powf(2, Float(bit - 8))
                                            if enable == 1 {
                                                voltage = voltage + Int(addVoltage)
                                            }
                                        }
                                        minSystemVoltage = voltage
                                    }
                                }
                            }
                        }
                    }
                }
                .border()
            }
        }
        .padding()
        .border()
        .background(.blue)
        .frame(maxWidth: .max, maxHeight: .max, alignment: .center)
    }
}



Application(rootView: ContentView()).start()

