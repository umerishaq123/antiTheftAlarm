//
//  MyAdViewNativeViewFactory.swift
//  Runner
//
//  Created by Muhammad Bilal on 16/06/2024.
//

import Foundation
import Flutter
import UIKit

class MyAdViewNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?) -> FlutterPlatformView {
        return MyAdView(frame: frame, viewId: viewId, args: args, messenger: messenger)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
