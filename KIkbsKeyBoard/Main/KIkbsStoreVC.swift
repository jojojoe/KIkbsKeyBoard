//
//  KIkbsStoreVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

import UIKit

class KIkbsStoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(UIColor.white)
        setupView()
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupView() {
        let backBtn = UIButton(type: .custom)
        backBtn
            .image(UIImage(named: "stitch_ic_back"))
            .title("Set")
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        let topTitleLabel = UILabel()
        topTitleLabel
            .fontName(16, Font_AvenirNext_Medium)
            .color(UIColor.white)
            .text("Subscription")
            .adhere(toSuperview: self.view)
        topTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.centerX.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
    }

}

extension KIkbsStoreVC {
    @objc func yearSubBtnClick(sender: UIButton) {
        purchaseOrderIAP(iapType: .year)
    }
    
    @objc func monthSbuBtnClick(sender: UIButton) {
        purchaseOrderIAP(iapType: .month)
    }
    
    @objc func restoreAction(sender: UIButton) {
        HUD.show()
        KIkbsPurchaseManager.default.restore {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                HUD.hide()
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success),
                    object: nil,
                    userInfo: nil
                )
                if self.navigationController != nil {
                    self.navigationController?.popViewController()
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func purchaseOrderIAP(iapType: IAPType) {
        KIkbsPurchaseManager.default.order(iapType: iapType, source: "unknown", page: "", isInTest: false, success: {
            [weak self] in
            guard let `self` = self else {return}
            
            let status = KIkbsPurchaseManager.default.inSubscription
            print("purchase status : \(status)")
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success),
                object: nil,
                userInfo: nil
            )
            if self.navigationController != nil {
                self.navigationController?.popViewController()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }

}
