//
//  KEkeyNeInfoPagePreviewVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/10.
//

import UIKit

class KEkeyNeInfoPagePreviewVC: UIViewController {
    let topBar = UIView()
    let bottomCanvasView = UIView()
    let toplabel = UILabel()
    let contentTextV = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.clipsToBounds = true
        
        contentViewSetup()
        
    }
    func contentViewSetup() {
        view.backgroundColor(UIColor(hexString: "FFFAF3")!)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "D0BBFE")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        
        toplabel.adhere(toSuperview: topBar)
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        toplabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let backBtn = UIButton()
        topBar.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.width.height.equalTo(44)
        }
        backBtn.setImage(UIImage(named: "ic_pop_close"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
        //
        contentTextV.backgroundColor = .white
        contentTextV.layer.cornerRadius = 10
        contentTextV.clipsToBounds = true
        bottomCanvasView.addSubview(contentTextV)
        contentTextV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.top.equalToSuperview().offset(2)
        }
        contentTextV.font = UIFont(name: "AvenirNext-Medium", size: 16)
        contentTextV.textAlignment = .left
        contentTextV.textColor = .black
        contentTextV.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
         
    }
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
