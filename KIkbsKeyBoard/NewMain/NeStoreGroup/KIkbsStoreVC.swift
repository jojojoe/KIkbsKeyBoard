//
//  KIkbsStoreVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

import UIKit
import DeviceKit

class KIkbsStoreVC: UIViewController {

    let weekPrice: Double = 0.99
    let monthPrice: Double = 1.99
    let yearPrice: Double = 10.99
    
    let weekPriceLabel = UILabel().text("").color(UIColor.black).textAlignment(.center)
    let monthPriceLabel = UILabel().text("").color(UIColor.black).textAlignment(.center)
    var yearPriceLabel = UILabel().text("").color(UIColor.black).textAlignment(.center)
    
    let subBtnWeek = UIButton(type: .custom).title("".uppercased(), .normal)
    let subBtnMonth = UIButton(type: .custom).title("".uppercased(), .normal)
    let subBtnYear = UIButton(type: .custom).title("".uppercased(), .normal)
    
    let bottomCanvasView = UIView()
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(UIColor.white)
        contentViewSetup()
        setupContentBtns()
        setupPriceLabel()
    }
    
    func setupPriceLabel() {
        if let list = KIkbsPurchaseManager.localIAPProducts {
            configPricelabel(iapProductsInfo: list)
        }
        KIkbsPurchaseManager.default.purchaseInfo {[weak self] (iapProductsInfo) in
            guard let `self` = self else {return}
            debugPrint("\(iapProductsInfo)")
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                self.configPricelabel(iapProductsInfo: iapProductsInfo)
            }
        }
    }
    
    func configPricelabel(iapProductsInfo: [KIkbsPurchaseManager.IAPProduct]) {
        let weekItem = iapProductsInfo.filter { $0.iapID == IAPType.week.rawValue }.first
        let monthItem = iapProductsInfo.filter { $0.iapID == IAPType.month.rawValue }.first
        let yearItem = iapProductsInfo.filter { $0.iapID == IAPType.year.rawValue }.first
        let currencyCode = yearItem?.priceLocale.currencySymbol ?? "$"
        
        // week
        let weekPriceStr = "\(currencyCode)\(String(format: "%.2f", weekItem?.price ?? self.weekPrice))/\("Week".localized())"
        subBtnWeek.setTitle(weekPriceStr, for: .normal)
        
        // month
        let monthPriceStr = "\(currencyCode)\(String(format: "%.2f", monthItem?.price ?? self.monthPrice))/\("Month".localized())"
        subBtnMonth.setTitle(monthPriceStr, for: .normal)
        
        // year
        let yearPriceStr = "\(currencyCode)\(String(format: "%.2f", yearItem?.price ?? self.yearPrice))/\("Year".localized())"
        subBtnYear.setTitle(yearPriceStr, for: .normal)
        
    }
    
    
    func contentViewSetup() {
        view.backgroundColor(.black)
            .clipsToBounds(true)
        //
        let topBar = UIView()
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "F0D380")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        let titNameLabel = UILabel()
        titNameLabel.adhere(toSuperview: topBar)
            .text("Subscription Plan")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        titNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let backbtn = UIButton()
        backbtn.setImage(UIImage(named: "ic_pop_close"), for: .normal)
        topBar.addSubview(backbtn)
        backbtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        backbtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        //
        bottomCanvasView
            .backgroundColor(UIColor(hexString: "F2F2F7")!)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom).offset(6)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
        
        //
        //"🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉",
        let subJoinLabel = UILabel()
        subJoinLabel.adhere(toSuperview: bottomCanvasView)
            .text("🅹🅾🅸🅽 🆅🅸🅿 🅽🅾🆆")
            .color(UIColor(hexString: "#F0D380")!)
            .fontName(24, "Futura-CondensedExtraBold")
        subJoinLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalToSuperview().offset(20)
            } else {
                $0.top.equalToSuperview().offset(40)
            }
            
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let desLabel1 = UILabel()
        desLabel1.textColor = .black
        desLabel1.adhere(toSuperview: bottomCanvasView)
        desLabel1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(subJoinLabel.snp.bottom).offset(30)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        desLabel1.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        desLabel1.text = "◆ You can use as many fonts as you like"
        
        //
        let infoLabel1 = UILabel()
        infoLabel1.textColor = UIColor.lightGray
        infoLabel1.adhere(toSuperview: bottomCanvasView)
        infoLabel1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(desLabel1.snp.bottom).offset(2)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        infoLabel1.numberOfLines = 0
        infoLabel1.textAlignment = .left
        infoLabel1.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        infoLabel1.text = "𝓣𝓮𝔁𝓵 𝕋𝕖𝕩𝕥 ꪻꫀ᥊ꪻ ʇxǝ⊥ 🆃🅴🆇🆃 ₜₑₓₜ Ⓣⓔⓧⓣ tēxt ₮ɆӾ₮"
        
        //
        let desLabel2 = UILabel()
        desLabel2.textColor = .black
        desLabel2.adhere(toSuperview: bottomCanvasView)
        desLabel2.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalTo(desLabel1.snp.bottom).offset(40)
            } else {
                $0.top.equalTo(desLabel1.snp.bottom).offset(60)
            }
            
            $0.width.height.greaterThanOrEqualTo(10)
        }
        desLabel2.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        desLabel2.text = "◆ You can use as many Special symbols as you like"
        
        //
        let infoLabel2 = UILabel()
        infoLabel2.textColor = UIColor.lightGray
        infoLabel2.adhere(toSuperview: bottomCanvasView)
        infoLabel2.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(desLabel2.snp.bottom).offset(2)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        infoLabel2.numberOfLines = 0
        infoLabel2.textAlignment = .left
        infoLabel2.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        infoLabel2.text = "✿.｡.:* ☆::.::.☆*.:｡.✿ ↬↬↬↬↬ ↫↫↫↫↫ ♡¸.• •.¸♡"
        
        
        //
        let desLabel3 = UILabel()
        desLabel3.textColor = .black
        desLabel3.adhere(toSuperview: bottomCanvasView)
        desLabel3.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalTo(desLabel2.snp.bottom).offset(40)
            } else {
                $0.top.equalTo(desLabel2.snp.bottom).offset(60)
            }
            
            $0.width.height.greaterThanOrEqualTo(10)
        }
        desLabel3.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        desLabel3.text = "◆ You can use as many Emoji as you like"
        
        //
        let infoLabel3 = UILabel()
        infoLabel3.textColor = UIColor.lightGray
        infoLabel3.adhere(toSuperview: bottomCanvasView)
        infoLabel3.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(desLabel3.snp.bottom).offset(2)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        infoLabel3.numberOfLines = 0
        infoLabel3.textAlignment = .left
        infoLabel3.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        infoLabel3.text = "(๑>◡<๑) (⺻▽⺻) (❁´▽`❁) ( >﹏<。)"
        
        //
//        let andlabel = UILabel()
//        andlabel.textColor = UIColor.lightGray
//        andlabel.adhere(toSuperview: bottomCanvasView)
//        andlabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview().offset(-24)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
//            $0.width.height.greaterThanOrEqualTo(10)
//        }
//        andlabel.numberOfLines = 0
//        andlabel.textAlignment = .center
//        andlabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
//        andlabel.text = "&"
        //
        let subscriNoticeBtn = UIButton()
        subscriNoticeBtn.setTitleColor(UIColor.lightGray, for: .normal)
        subscriNoticeBtn.setTitle("Subscription Notice", for: .normal)
        subscriNoticeBtn.adhere(toSuperview: bottomCanvasView)
        subscriNoticeBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        subscriNoticeBtn.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        subscriNoticeBtn.addTarget(self, action: #selector(subscriNoticeBtnAction(sender: )), for: .touchUpInside)
        
        //
        let restoreBtn = UIButton()
        restoreBtn.setTitleColor(UIColor.lightGray, for: .normal)
        restoreBtn.setTitle("Restore", for: .normal)
        restoreBtn.adhere(toSuperview: bottomCanvasView)
        restoreBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(subscriNoticeBtn.snp.top).offset(-2)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        restoreBtn.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        restoreBtn.addTarget(self, action: #selector(restoreAction(sender: )), for: .touchUpInside)
        
        
        
    }
    func setupContentBtns() {
        bottomCanvasView.addSubview(subBtnWeek)
        subBtnWeek.addTarget(self, action: #selector(weekSbuBtnClick(sender: )), for: .touchUpInside)
        subBtnWeek.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalTo(bottomCanvasView.snp.centerY).offset(-15)
            } else {
                $0.top.equalTo(bottomCanvasView.snp.centerY)
            }
            $0.left.equalToSuperview().offset(34)
            $0.height.equalTo(60)
        }
        subBtnWeek.layer.borderWidth = 1.5
        subBtnWeek.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        subBtnWeek.layer.shadowColor = UIColor.black.cgColor
        subBtnWeek.layer.shadowOffset = CGSize(width: -2, height: 2)
        subBtnWeek.layer.shadowRadius = 0
        subBtnWeek.layer.shadowOpacity = 1
        subBtnWeek.setTitle("$4.99/Week", for: .normal)
        subBtnWeek.setTitleColor(.black, for: .normal)
        subBtnWeek.setBackgroundColor(UIColor(hexString: "B0D287")!, for: .normal)
        subBtnWeek.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        
        //
        bottomCanvasView.addSubview(subBtnMonth)
        subBtnMonth.addTarget(self, action: #selector(monthSbuBtnClick(sender: )), for: .touchUpInside)
        subBtnMonth.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalTo(subBtnWeek.snp.bottom).offset(15)
            } else {
                $0.top.equalTo(subBtnWeek.snp.bottom).offset(30)
            }
            $0.width.equalTo(subBtnWeek.snp.width)
            $0.height.equalTo(60)
        }
        subBtnMonth.layer.borderWidth = 1.5
        subBtnMonth.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        subBtnMonth.layer.shadowColor = UIColor.black.cgColor
        subBtnMonth.layer.shadowOffset = CGSize(width: -2, height: 2)
        subBtnMonth.layer.shadowRadius = 0
        subBtnMonth.layer.shadowOpacity = 1
        subBtnMonth.setTitle("$9.99/Month", for: .normal)
        subBtnMonth.setTitleColor(.black, for: .normal)
        subBtnMonth.setBackgroundColor(UIColor(hexString: "D0BBFE")!, for: .normal)
        subBtnMonth.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        //
        bottomCanvasView.addSubview(subBtnYear)
        subBtnYear.addTarget(self, action: #selector(yearSubBtnClick(sender: )), for: .touchUpInside)
        subBtnYear.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 7.9 {
                $0.top.equalTo(subBtnMonth.snp.bottom).offset(15)
            } else {
                $0.top.equalTo(subBtnMonth.snp.bottom).offset(30)
            }
            $0.width.equalTo(subBtnMonth.snp.width)
            $0.height.equalTo(60)
        }
        subBtnYear.layer.borderWidth = 1.5
        subBtnYear.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        subBtnYear.layer.shadowColor = UIColor.black.cgColor
        subBtnYear.layer.shadowOffset = CGSize(width: -2, height: 2)
        subBtnYear.layer.shadowRadius = 0
        subBtnYear.layer.shadowOpacity = 1
        subBtnYear.setTitle("$19.99/Year", for: .normal)
        subBtnYear.setTitleColor(.black, for: .normal)
        subBtnYear.setBackgroundColor(UIColor(hexString: "FCAFCF")!, for: .normal)
        subBtnYear.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 15)
        
         
        
    }

}

extension KIkbsStoreVC {
    
    func purchaseOrderIAP(iapType: IAPType) {
        KIkbsPurchaseManager.default.order(iapType: iapType, source: "unknown", page: "", isInTest: false, success: {
            [weak self] in
            guard let `self` = self else {return}
            
            let status = KIkbsPurchaseManager.default.inSubscription
            debugPrint("purchase status : \(status)")
            
            if self.navigationController != nil {
                self.navigationController?.popViewController()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

extension KIkbsStoreVC {
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func yearSubBtnClick(sender: UIButton) {
        purchaseOrderIAP(iapType: .year)
    }
    
    @objc func monthSbuBtnClick(sender: UIButton) {
        purchaseOrderIAP(iapType: .month)
    }
    
    @objc func weekSbuBtnClick(sender: UIButton) {
        purchaseOrderIAP(iapType: .week)
    }
    
    @objc func restoreAction(sender: UIButton) {
        HUD.show()
        KIkbsPurchaseManager.default.restore {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                HUD.hide()

                if self.navigationController != nil {
                    self.navigationController?.popViewController()
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func subscriNoticeBtnAction(sender: UIButton) {
        
    }
    

}
