//
//  KIkbsMorseCodeTransformView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/23.
//

import UIKit
import JXPagingView


class KIkbsMorseCodeTransformView: UIView {

    var wordToMorseVBtnClickBlock: (()->Void)?
    var morseToWordVBtnClickBlock: (()->Void)?
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor(UIColor.white)
        
        //
        let wordToMorseV = KIkbsMorseToolBtn(frame: .zero, titleStr: "Word to morse", infoStr: "abcd to .-.-")
        wordToMorseV
            .adhere(toSuperview: self)
        wordToMorseV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.centerY).offset(-10)
            $0.width.equalTo(200)
            $0.height.equalTo(80)
        }
        wordToMorseV.addTarget(self, action: #selector(wordToMorseVBtnClick(sender:)), for: .touchUpInside)
        //
        let morseToWordV = KIkbsMorseToolBtn(frame: .zero, titleStr: "Morse to word", infoStr: ".-.- to abcd")
        morseToWordV
            .adhere(toSuperview: self)
        morseToWordV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(snp.centerY).offset(10)
            $0.width.equalTo(200)
            $0.height.equalTo(80)
        }
        morseToWordV.addTarget(self, action: #selector(morseToWordVBtnClick(sender:)), for: .touchUpInside)
        
        
    }
    

    @objc func wordToMorseVBtnClick(sender: UIButton) {
        wordToMorseVBtnClickBlock?()
    }
    
    @objc func morseToWordVBtnClick(sender: UIButton) {
        morseToWordVBtnClickBlock?()
    }
    
    
}


extension KIkbsMorseCodeTransformView: JXPagingViewListViewDelegate {
    
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return UIScrollView()
    }
}




class KIkbsMorseToolBtn: UIButton {
    var titleStr: String
    var infoStr: String
    
    init(frame: CGRect, titleStr: String, infoStr: String) {
        self.titleStr = titleStr
        self.infoStr = infoStr
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor(UIColor.darkGray)
        //
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        //
        let titleLabel = UILabel()
        titleLabel
            .fontName(16, Font_AvenirNext_Medium)
            .text(titleStr)
            .color(UIColor.white)
            .textAlignment(.center)
            .adhere(toSuperview: self)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.centerY).offset(-1)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        let infoLabel = UILabel()
        infoLabel
            .fontName(12, Font_AvenirNext_Medium)
            .text(infoStr)
            .color(UIColor.white.withAlphaComponent(0.5))
            .textAlignment(.center)
            .adhere(toSuperview: self)
        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(snp.centerY).offset(2)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        
    }
    
}
