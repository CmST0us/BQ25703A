// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftTUI
import MMIO
import MMIOMacros
import MMIOUtilities
import MMIOVolatile
import BQ25703A
import PeripheryKit

struct ContentView: View {
    
    @State var maxChargeVoltage: Int = 0
    
    @State var chargerCurrent: Int = 0
    
    @State var minSystemVoltage: Int = 0
    
    @State var isCharging: Bool = false

    let i2c: I2CTransfer = I2CTransfer(chip: .i2c("/dev/i2c-2"), address: 0x6b)
    
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

                HStack {
                    Button("Get Charging Status") {
                        var data = self.i2c.readBigEndianUInt16(register: .msb_lsb(0x2120))!.toData()
                        data.withUnsafeBytes { ptr in
                            if let bufferBaseAddress = ptr.baseAddress {
                                let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                let control = ChargerStatus(unsafeAddress: bufferMemoryAddress)
                                isCharging = control._21h.read().ac_stat
                            }
                        }

                        data = self.i2c.readBigEndianUInt16(register: .msb_lsb(0x0504))!.toData()
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

                        data = self.i2c.readBigEndianUInt16(register: .msb_lsb(0x0302))!.toData()
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

                        data = self.i2c.readBigEndianUInt16(register: .msb_lsb(0x0D0C))!.toData()
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

                    Button("Start Charger") {
                        var data = Data([0x0, 0x0])
                        data.withUnsafeMutableBytes { ptr in
                            if let bufferBaseAddress = ptr.baseAddress {
                                let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                let control = MinSystemVoltage(unsafeAddress: bufferMemoryAddress)
                                control.value.modify {
                                    $0.bit2 = true
                                    $0.bit3 = true
                                    $0.bit4 = true
                                }
                                
                            }
                        }
                        var v = data.toBigEndianUInt16()!
                        self.i2c.writeUInt16(register: .msb_lsb(0x0D0C), value: v)

                        data = Data([0x0, 0x0])
                        data.withUnsafeMutableBytes { ptr in
                            if let bufferBaseAddress = ptr.baseAddress {
                                let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                let control = MaxChargeVoltage(unsafeAddress: bufferMemoryAddress)
                                control.value.modify {
                                    $0.bit3 = true
                                    $0.bit9 = true
                                }
                                
                            }
                        }
                        v = data.toBigEndianUInt16()!
                        self.i2c.writeUInt16(register: .msb_lsb(0x0504), value: v)

                        data = Data([0x0, 0x0])
                        data.withUnsafeMutableBytes { ptr in
                            if let bufferBaseAddress = ptr.baseAddress {
                                let bufferMemoryAddress = UInt(bitPattern: bufferBaseAddress)
                                let control = ChargerCurrent(unsafeAddress: bufferMemoryAddress)
                                control.value.modify {
                                    $0.bit3 = true
                                    $0.bit5 = true
                                }
                                
                            }
                        }
                        v = data.toBigEndianUInt16()!
                        self.i2c.writeUInt16(register: .msb_lsb(0x0302), value: v)
                    }
                }
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
                        Text("Charger Current (03h/02h): ")
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

