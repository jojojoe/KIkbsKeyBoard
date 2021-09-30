//
//  KeyBKeyBtn.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit

//class KeyBKeyBtn: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}

import Foundation
import UIKit
import SnapKit

public struct KBKeyBackgroundColor {
    
}

public enum KBKeyBtnActionType {
    case TextInput
    case action_SHIFT
    case action_shift
    case action_Shift
    case action_BackClear
    case action_special123
    case action_jinghaojiahaodenghao
    case action_ABC
    case action_123
    case action_Gloab
    case action_Space
    case action_Emoji
    case action_Send
}

public enum KBKeyBtnRectType {
    //    case normal
    case hardWidth(multiplier: CGFloat)
    case spaceWidth
    case sendWidth
}


public struct KBKeyBtnType {
    var type: KBKeyBtnActionType = .TextInput
    var ShowText: String?
    var inputText: String?
    var Image: UIImage?
    var BackgroundColor: UIColor = KBKeyBtn.normalBackgroundColor
    var TextColor: UIColor = KBKeyBtn.textColor
    var rectType: KBKeyBtnRectType = .hardWidth(multiplier: 1)
    var action: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    
    init(type: KBKeyBtnActionType, showText: String?, inputText: String?, Image: UIImage?, backgroundColor: UIColor, textColor: UIColor, rectType: KBKeyBtnRectType, action: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)? ) {
        self.type = type
        self.ShowText = showText
        self.inputText = inputText
        self.Image = Image
        self.BackgroundColor = backgroundColor
        self.TextColor = textColor
        self.rectType = rectType
        self.action = action
        
    }
}


class KBKeyBtn: UIView {
    
    var contentBgView: UIView! = UIView()
    var keyLabel: UILabel! = UILabel()
    var keyImageView: UIImageView! = UIImageView()
    
    
    static var normalBackgroundColor = UIColor.white
    static var shiftBackgroundColor = UIColor(red: 172.0/255.0, green: 179.0/255.0, blue: 188.0/255.0, alpha: 1)
    static var textColor = UIColor.black
    
    
    var btnType: KBKeyBtnType
    init(currentBtnType: KBKeyBtnType) {
        btnType = currentBtnType
        super.init(frame: .zero)
        setupContentView()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentView() {
        self.addSubview(contentBgView)
        contentBgView.layer.cornerRadius = 4
        contentBgView.layer.shadowColor = UIColor.lightGray.cgColor
        contentBgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentBgView.layer.shadowOpacity = 1
        
        contentBgView.addSubview(keyLabel)
        keyLabel.font = UIFont.systemFont(ofSize: 18)
        keyLabel.textAlignment = .center
        contentBgView.addSubview(keyImageView)
        keyImageView.contentMode = .center
        
        let inset: CGFloat = 5.0
        contentBgView.snp.makeConstraints { (ConstraintMaker) in
            
            ConstraintMaker.left.top.equalToSuperview().offset(inset)
            ConstraintMaker.bottom.right.equalToSuperview().offset(-inset)
        }
        
        keyLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.top.bottom.right.equalToSuperview()
        }
        
        keyImageView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.top.bottom.right.equalToSuperview()
        }
        
    }
    
    func setupView() {
        
        if let showText = btnType.ShowText {
            keyLabel.text = showText
            keyLabel.isHidden = false
        } else {
            keyLabel.isHidden = true
        }
        
        if let keyIcon = btnType.Image {
            keyImageView.image = keyIcon
            keyImageView.isHidden = false
        } else {
            keyImageView.isHidden = true
        }
        contentBgView.backgroundColor = btnType.BackgroundColor
        keyLabel.textColor = btnType.TextColor
        
    }
}
