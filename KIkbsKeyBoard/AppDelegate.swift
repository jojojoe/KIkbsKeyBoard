//
//  AppDelegate.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/7/2.
//

import UIKit
import SwiftyStoreKit
import AdSupport
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainVC: KEkeyMainVC = KEkeyMainVC()

    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }
    
    
    
    func trackeringAuthor() {
       
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: {[weak self] status in
                guard let `self` = self else {return}
                
            })
        }
    }
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // init db
        KIkbsKeboardFavoriteDB.default.prepareDB()
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
        //
        setupIAP()
        initMainVC()
        trackeringAuthor()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
         
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }

    
}

extension AppDelegate {
    func setupIAP() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }    
        }
        
        checkSubscription()
                
        SwiftyStoreKit.shouldAddStorePaymentHandler = { (payment, product) -> Bool in
            // TODO: Store page
            return false
        }
    }
    
    func checkSubscription() {
        
        if KIkbsPurchaseManager.default.isLocalVerify {
            KIkbsPurchaseManager.default.refreshReceipt { (_, _) in
                KIkbsPurchaseManager.default.isPurchased { (status) in
                    debugPrint("current is in purchased \(status)")
                    KIkbsPurchaseManager.default.inSubscription = status
                    if !status {
                        KIkbsPurchaseManager.default.purchaseInfo { (products) in
                            debugPrint(products)
                        }
                    }
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success),
                        object: nil,
                        userInfo: nil
                    )
                }
            }
        } else {
            let status = KIkbsPurchaseManager.default.inSubscription
            if !status {
                KIkbsPurchaseManager.default.purchaseInfo { (products) in
                    debugPrint(products)
                }
            }
        }
    }
}
