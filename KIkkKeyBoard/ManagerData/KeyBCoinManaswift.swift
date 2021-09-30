//
//  KeyBCoinManaswift.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import Foundation
import UIKit

class KBCoinManager: NSObject {
    static var `default` = KBCoinManager()
    let costCount = 50
    var AppGroup = "group.com.keyinsfont.superone"
    var kUserDefaultsCoinCount = "kCoinCount"
    override init() {
        super.init()
    }
    
    
    func currentCoinCount() -> Int {
        
        guard let userDefault = UserDefaults.init(suiteName: AppGroup) else { return 100 }
        let coinCount = userDefault.integer(forKey: kUserDefaultsCoinCount)
        debugPrint("keyboard coinCount ** \(coinCount)")
        return coinCount
    }
    
    func consumeCoin() {
        guard let userDefault = UserDefaults.init(suiteName: AppGroup) else { return }
        let costCoin = currentCoinCount() - costCount
        userDefault.set(costCoin, forKey: kUserDefaultsCoinCount)
    }
    
}
