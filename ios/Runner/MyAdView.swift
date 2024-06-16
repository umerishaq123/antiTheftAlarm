//
//  MyAdView.swift
//  Runner
//
//  Created by Muhammad Bilal on 16/06/2024.
//

import Foundation
import UIKit
import GoogleMobileAds

class MyAdView : NSObject,
                 FlutterPlatformView, GADNativeAdLoaderDelegate, GADNativeAdDelegate, GADVideoControllerDelegate{
    private var _view: UIView
    private var adLoader: GADAdLoader!
    
    let adView: GADNativeAdView = {
        let view = GADNativeAdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    
}

