//
//  KIkbsCardTextInputView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/6.
//

import UIKit

class KIkbsCardTextInputView: UIView {

    var backBtnClickBlock: (()->Void)?
    var okBtnClickBlock: ((String)->Void)?
    
    let contentBgView = UIView()
    let topLayoutLine1 = UIView()
    let topLayoutLine2 = UIView()
    
    var textInputTextView = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registKeyboradNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        let top = topLayoutLine1.frame.minY
        
        let bottom = topLayoutLine2.frame.maxY
        let safeHeight = bottom - top
        let topHeight = safeHeight - keyboardHeight
        
        let topContentBg = (topHeight) / 2
        contentBgView.snp.remakeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topContentBg)
        }
        
        print(keyboardHeight)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        print(keyboardHeight)
    }
    
    
    
}


extension KIkbsCardTextInputView {
    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let bgBtn = UIButton(type: .custom)
        addSubview(bgBtn)
        bgBtn.addTarget(self, action: #selector(bgBtnClick(sender:)), for: .touchUpInside)
        bgBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        contentBgView.backgroundColor = UIColor.white
        addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(90)
        }
        contentBgView.layer.cornerRadius = 20
        contentBgView.layer.masksToBounds = true
        
        
        //
        let okBtn = UIButton(type: .custom)
        okBtn
            .title("OK")
            .backgroundColor(UIColor.white)
            .titleColor(UIColor.black)
            .adhere(toSuperview: contentBgView)
        okBtn.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        
        //
        textInputTextView.textColor = UIColor.darkGray
        textInputTextView.textAlignment = .left
        textInputTextView.font = UIFont(name: Font_AvenirNext_Medium, size: 16)
        textInputTextView
            .adhere(toSuperview: contentBgView)
        textInputTextView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(okBtn.snp.top).offset(-12)
        }
        
        
        //
        let line1 = UIView()
        line1
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: contentBgView)
        line1.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(okBtn.snp.top)
            $0.height.equalTo(1)
        }
        //
        let cancelBtn = UIButton(type: .custom)
        cancelBtn
            .title("Cancel")
            .backgroundColor(UIColor.white)
            .titleColor(UIColor.black)
            .adhere(toSuperview: contentBgView)
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(contentBgView).offset(4)
            $0.right.equalTo(contentBgView).offset(-4)
            $0.width.height.equalTo(35)
        }
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick(sender:)), for: .touchUpInside)
        //
        topLayoutLine1.backgroundColor = .clear
        addSubview(topLayoutLine1)
        topLayoutLine1.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(1)
        }
        
        //
        topLayoutLine2.backgroundColor = .clear
        addSubview(topLayoutLine2)
        topLayoutLine2.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.left.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(1)
        }
        
    }
    
    @objc func bgBtnClick(sender: UIButton) {
        textInputTextView.resignFirstResponder()
        backBtnClickBlock?()
    }
    
    @objc func cancelBtnClick(sender: UIButton) {
        textInputTextView.resignFirstResponder()
        backBtnClickBlock?()
    }
    
    @objc func okBtnClick(sender: UIButton) {
        textInputTextView.resignFirstResponder()
        okBtnClickBlock?(textInputTextView.text)
    }
    
    
    
    
}
