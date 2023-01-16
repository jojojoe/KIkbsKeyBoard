//
//  KEkeyMainVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/5.
//

import UIKit

class KEkeyMainVC: UIViewController {

    let canvasBgV = UIView()
    
    let transBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
    let spaceilBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
    let collectionBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
    let textcardBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
    let settingBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
    
    let transPageVC = KEkeyNeTransformVC()
    let specialTextPageVC = KEkeyNeSpecialTextVC()
    let favoriteStringPageVC = KEkeyNeFavoriteStringVC()
    let textCardPageVC = KEkeyNeTextCardVC()
    let settingPageVC = KEkeyNeSettingVC()
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentViewSetup()
        setupCanvasBgV()
    }
    
    func contentViewSetup() {
        view.backgroundColor(UIColor(hexString: "#FFFAF3")!)
        
        //
        let bgV = UIView()
        bgV
            .adhere(toSuperview: view)
            .backgroundColor(.black)
        bgV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        //
        let bottomBar = UIView()
        bottomBar
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: bgV)
            .clipsToBounds(true)
        bottomBar.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.height.equalTo(60)
        }
        bottomBar.layer.cornerRadius = 10
        
        //
        
        canvasBgV
            .backgroundColor(.black)
            .adhere(toSuperview: bgV)
        canvasBgV.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(bottomBar.snp.top).offset(-4)
        }
        
        //
        transBtn.adjustsImageWhenHighlighted = false
        spaceilBtn.adjustsImageWhenHighlighted = false
        collectionBtn.adjustsImageWhenHighlighted = false
        textcardBtn.adjustsImageWhenHighlighted = false
        settingBtn.adjustsImageWhenHighlighted = false
        //
        bottomBar.addSubview(transBtn)
        transBtn
            .image(UIImage(named: "ic_trans"), .normal)
            .image(UIImage(named: "ic_trans-1"), .selected)
        transBtn.addTarget(self, action: #selector(transBtnClick(sender: )), for: .touchUpInside)
        //

        bottomBar.addSubview(spaceilBtn)
        spaceilBtn
            .image(UIImage(named: "ic_spacel"), .normal)
            .image(UIImage(named: "ic_spacel-1"), .selected)
        spaceilBtn.addTarget(self, action: #selector(spaceilBtnClick(sender: )), for: .touchUpInside)
        //

        bottomBar.addSubview(collectionBtn)
        collectionBtn
            .image(UIImage(named: "ic_colle"), .normal)
            .image(UIImage(named: "ic_colle-1"), .selected)
        collectionBtn.addTarget(self, action: #selector(collectionBtnClick(sender: )), for: .touchUpInside)
        //

        bottomBar.addSubview(textcardBtn)
        textcardBtn
            .image(UIImage(named: "ic_card"), .normal)
            .image(UIImage(named: "ic_card-1"), .selected)
        textcardBtn.addTarget(self, action: #selector(textcardBtnClick(sender: )), for: .touchUpInside)
        //
        
        bottomBar.addSubview(settingBtn)
        settingBtn
            .image(UIImage(named: "ic_setting"), .normal)
            .image(UIImage(named: "ic_setting-1"), .selected)
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        //
        let stackV = UIStackView(arrangedSubviews: [transBtn, spaceilBtn, collectionBtn, textcardBtn, settingBtn])
        stackV.axis = .horizontal
        stackV.distribution = .fillEqually
        stackV.alignment = .center
        stackV.adhere(toSuperview: bottomBar)
        stackV.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
    }
    
    func setupCanvasBgV() {
        //
        self.addChild(transPageVC)
        canvasBgV.addSubview(transPageVC.view)
        transPageVC.view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }

        
        self.addChild(specialTextPageVC)
        canvasBgV.addSubview(specialTextPageVC.view)
        specialTextPageVC.view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        
        canvasBgV.addSubview(favoriteStringPageVC.view)
        favoriteStringPageVC.view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        
        canvasBgV.addSubview(textCardPageVC.view)
        textCardPageVC.view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        settingPageVC.fatherVC = self
        canvasBgV.addSubview(settingPageVC.view)
        settingPageVC.view.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        showToolContentView(btn: transBtn, toolV: transPageVC.view)
    }
    

}

extension KEkeyMainVC {
    func showToolContentView(btn: UIButton, toolV: UIView) {
        transBtn.isSelected = false
        spaceilBtn.isSelected = false
        collectionBtn.isSelected = false
        textcardBtn.isSelected = false
        settingBtn.isSelected = false
        //
        transPageVC.view.isHidden = true
        specialTextPageVC.view.isHidden = true
        favoriteStringPageVC.view.isHidden = true
        textCardPageVC.view.isHidden = true
        settingPageVC.view.isHidden = true
        
        //
        btn.isSelected = true
        toolV.isHidden = false
        
    }
}

extension KEkeyMainVC {
    @objc func transBtnClick(sender: UIButton) {
        showToolContentView(btn: sender, toolV: transPageVC.view)
    }
    @objc func spaceilBtnClick(sender: UIButton) {
        showToolContentView(btn: sender, toolV: specialTextPageVC.view)
    }
    @objc func collectionBtnClick(sender: UIButton) {
        showToolContentView(btn: sender, toolV: favoriteStringPageVC.view)
    }
    @objc func textcardBtnClick(sender: UIButton) {
        showToolContentView(btn: sender, toolV: textCardPageVC.view)
    }
    @objc func settingBtnClick(sender: UIButton) {
        showToolContentView(btn: sender, toolV: settingPageVC.view)
    }
    
}
