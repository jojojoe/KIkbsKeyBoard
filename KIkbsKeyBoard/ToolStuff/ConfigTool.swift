//
//  ConfigTool.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/17.
//

import Foundation
import Defaults
import NoticeObserveKit

let Font_AvenirNext_Medium = "AvenirNext-Medium"
let Font_Avenir_Heavy = "Avenir-Heavy"

public enum IAPType: String {
    case year = "IAP_id_year"
    case month = "IAP_id_month"
    
}

var AppName: String = "App_Name"
var FeedbackEmail: String = ""
var AppBundleID: String = "com.xxx"
var IAPsharedSecret: String = ""


extension Defaults.Keys {
    static let localIAPReceiptInfo = Key<Data?>("Purchase.localIAPReceiptInfo")
    static let localIAPProducts = Key<[KIkbsPurchaseManager.IAPProduct]?>("Purchase.LocalIAPProducts")
    static let localIAPCacheTime = Key<TimeInterval?>("Purchase.localIAPCacheTime")
    
}

extension Notice.Names {
    static let receiptInfoDidChange =
        Notice.Name<Any?>(name: "ReceiptInfoDidChange")
    
//    Notice.Center.default
//        .post(name: Notice.Names.receiptInfoDidChange, with: nil)
    
}
