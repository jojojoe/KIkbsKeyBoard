//
//  KIkbsSettingVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

import UIKit

class KIkbsSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView() {
        let topBanner = UIView()
        topBanner
            .backgroundColor(.darkGray)
            .adhere(toSuperview: view)
        topBanner.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        //
        let topTitleLabel = UILabel()
        topTitleLabel
            .fontName(15, Font_AvenirNext_Medium)
            .color(UIColor.white)
            .text("Account Setting")
            .textAlignment(.center)
            .adhere(toSuperview: view)
        topTitleLabel
            .snp.makeConstraints {
                $0.bottom.equalTo(topBanner.snp.bottom)
                $0.height.equalTo(44)
                $0.centerX.equalToSuperview()
                $0.width.greaterThanOrEqualTo(1)
            }
        
        //
        let contentBgView = UIView()
        contentBgView
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: view)
        contentBgView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(topBanner.snp.bottom)
        }
        
    }
     

}
