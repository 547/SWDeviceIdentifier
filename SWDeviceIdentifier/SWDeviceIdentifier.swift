//
//  SWDeviceIdentifier.swift
//  SWDeviceIdentifier
//
//  Created by Supernova SanDick SSD on 2019/6/24.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation
import KeychainAccess
public class SWDeviceIdentifier {
    public var deviceIdentifier:String {
        return currentDeviceIdentifier
    }
    private var currentDeviceIdentifier: String = ""
    public let deviceIdentifierKey = "SW_DEVICE_IDENTIFIER"
    public init() {
        setupDeviceIdentifier()
    }
}
extension SWDeviceIdentifier {
    func setupDeviceIdentifier() -> () {
        guard let serviceIdentifierKey = Bundle.main.bundleIdentifier else {
            print("获取 bundleID 失败，SWDeviceIdentifier 初始化也失败")
            return
        }
        let keychain = Keychain.init(service: serviceIdentifierKey)
        if let deviceId = keychain[deviceIdentifierKey] {
            currentDeviceIdentifier = deviceId
        }else{
            let deviceId = UUID.init().uuidString
            currentDeviceIdentifier = deviceId
            keychain[deviceIdentifierKey] = deviceId
        }
    }
}
