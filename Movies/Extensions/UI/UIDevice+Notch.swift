// UIDevice+Notch.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

enum DeviceType: String, CaseIterable {
    case iPhone2G
    case iPhone3G
    case iPhone3GS
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhoneSE
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone12mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone13mini
    case iPhone13
    case iPhone13Pro
    case iPhone13ProMax
    case iPhoneSEGen2
    case iPodTouch1G
    case iPodTouch2G
    case iPodTouch3G
    case iPodTouch4G
    case iPodTouch5G
    case iPodTouch6G
    case simulator

    // MARK: - Constants

    static var current: DeviceType? {
        #if targetEnvironment(simulator)
        guard let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] else { return nil }
        return DeviceType(identifier: identifier)
        #else
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""

        for child in mirror.children {
            if let value = child.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }

        return DeviceType(identifier: identifier)
        #endif
    }

    // MARK: - Variables

    var displayName: String {
        switch self {
        case .iPhone2G: return "iPhone 2G"
        case .iPhone3G: return "iPhone 3G"
        case .iPhone3GS: return "iPhone 3GS"
        case .iPhone4: return "iPhone 4"
        case .iPhone4S: return "iPhone 4S"
        case .iPhone5: return "iPhone 5"
        case .iPhone5C: return "iPhone 5C"
        case .iPhone5S: return "iPhone 5S"
        case .iPhone6Plus: return "iPhone 6 Plus"
        case .iPhone6: return "iPhone 6"
        case .iPhone6S: return "iPhone 6S"
        case .iPhone6SPlus: return "iPhone 6S Plus"
        case .iPhoneSE: return "iPhone SE"
        case .iPhone7: return "iPhone 7"
        case .iPhone7Plus: return "iPhone 7 Plus"
        case .iPhone8: return "iPhone 8"
        case .iPhone8Plus: return "iPhone 8 Plus"
        case .iPhoneX: return "iPhone X"
        case .iPhoneXS: return "iPhone XS"
        case .iPhoneXSMax: return "iPhone XS Max"
        case .iPhoneXR: return "iPhone XR"
        case .iPhone11: return "iPhone 11"
        case .iPhone11Pro: return "iPhone 11 Pro"
        case .iPhone11ProMax: return "iPhone 11 Pro Max"
        case .iPhone12mini: return "iPhone 12 Mini"
        case .iPhone12: return "iPhone 12"
        case .iPhone12Pro: return "iPhone 12 Pro"
        case .iPhone12ProMax: return "iPhone 12 Pro Max"
        case .iPhone13mini: return "iPhone 13 Mini"
        case .iPhone13: return "iPhone 13"
        case .iPhone13Pro: return "iPhone 13 Pro"
        case .iPhone13ProMax: return "iPhone 13 Pro Max"
        case .iPhoneSEGen2: return "iPhone SE (2nd Gen)"
        case .iPodTouch1G: return "iPod Touch 1G"
        case .iPodTouch2G: return "iPod Touch 2G"
        case .iPodTouch3G: return "iPod Touch 3G"
        case .iPodTouch4G: return "iPod Touch 4G"
        case .iPodTouch5G: return "iPod Touch 5G"
        case .iPodTouch6G: return "iPod Touch 6G"
        case .simulator: return "Simulator"
        }
    }

    internal var identifiers: [String] {
        switch self {
        case .simulator: return ["i386", "x86_64"]
        case .iPhone2G: return ["iPhone1,1"]
        case .iPhone3G: return ["iPhone1,2"]
        case .iPhone3GS: return ["iPhone2,1"]
        case .iPhone4: return ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
        case .iPhone4S: return ["iPhone4,1"]
        case .iPhone5: return ["iPhone5,1", "iPhone5,2"]
        case .iPhone5C: return ["iPhone5,3", "iPhone5,4"]
        case .iPhone5S: return ["iPhone6,1", "iPhone6,2"]
        case .iPhone6: return ["iPhone7,2"]
        case .iPhone6Plus: return ["iPhone7,1"]
        case .iPhone6S: return ["iPhone8,1"]
        case .iPhone6SPlus: return ["iPhone8,2"]
        case .iPhoneSE: return ["iPhone8,4"]
        case .iPhone7: return ["iPhone9,1", "iPhone9,3"]
        case .iPhone7Plus: return ["iPhone9,2", "iPhone9,4"]
        case .iPhone8: return ["iPhone10,1", "iPhone10,4"]
        case .iPhone8Plus: return ["iPhone10,2", "iPhone10,5"]
        case .iPhoneX: return ["iPhone10,3", "iPhone10,6"]
        case .iPhoneXS: return ["iPhone11,2"]
        case .iPhoneXSMax: return ["iPhone11,4", "iPhone11,6"]
        case .iPhoneXR: return ["iPhone11,8"]
        case .iPhone11: return ["iPhone12,1"]
        case .iPhone11Pro: return ["iPhone12,3"]
        case .iPhone11ProMax: return ["iPhone12,5"]
        case .iPhoneSEGen2: return ["iPhone12,8"]
        case .iPhone12mini: return ["iPhone13,1"]
        case .iPhone12: return ["iPhone13,2"]
        case .iPhone12Pro: return ["iPhone13,3"]
        case .iPhone12ProMax: return ["iPhone13,4"]
        case .iPhone13mini: return ["iPhone14,4"]
        case .iPhone13: return ["iPhone14,5"]
        case .iPhone13Pro: return ["iPhone14,2"]
        case .iPhone13ProMax: return ["iPhone14,3"]
        case .iPodTouch1G: return ["iPod1,1"]
        case .iPodTouch2G: return ["iPod2,1"]
        case .iPodTouch3G: return ["iPod3,1"]
        case .iPodTouch4G: return ["iPod4,1"]
        case .iPodTouch5G: return ["iPod5,1"]
        case .iPodTouch6G: return ["iPod7,1"]
        }
    }

    // MARK: - Initializer

    init?(identifier: String) {
        guard let device = Self.allCases.first(where: { $0.identifiers.contains(identifier) })
        else { return nil }
        self = device
    }
}

extension UIDevice {
    var type: DeviceType? {
        DeviceType.current
    }
}

extension UIDevice {
    var hasNotch: Bool {
        guard let currentDeviceType = UIDevice.current.type else { return false }
        let iPhonesWithOutNotch: [DeviceType] = [
            .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4, .iPhone4S, .iPhone5, .iPhone5C, .iPhone5S, .iPhone6,
            .iPhone6Plus, .iPhone6, .iPhone6SPlus, .iPhoneSE, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus,
            .iPhoneSEGen2, .iPodTouch1G, .iPodTouch2G, .iPodTouch3G, .iPodTouch4G, .iPodTouch5G, .iPodTouch6G
        ]
        return !iPhonesWithOutNotch.contains(currentDeviceType)
    }
}
