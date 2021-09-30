//
//  KIkbsCardTextInputBar.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/1.
//

import UIKit
import JXPagingView

enum TextCardCanvasSize {
    case size1_1
    case size4_3
    case size3_4
}

class KIkbsCardTextInputBar: UIView {

    var textinputBtnClickBlock: (()->Void)?
    var textRandomBtnClickBlock: (()->Void)?
    var alightmentBtnClickBlock: ((NSTextAlignment)->Void)?
    var canvasSizeBtnClickBlock: ((TextCardCanvasSize)->Void)?
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var currentContentStr: String = ""
    
    var contentAligment: NSTextAlignment = .center
    var cardCanvasSize: TextCardCanvasSize = .size1_1
    
    let textInputBtn = UIButton(type: .custom)
    let textRandomBtn = UIButton(type: .custom)
    let alightmenBtn = UIButton(type: .custom)
    let canvasSizeBtn = UIButton(type: .custom)
    
//    
    func udpateTextContent(contentStr: String) {
        currentContentStr = contentStr
        textInputBtn
            .title(contentStr)
    }
    
    
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
        textInputBtn.layer.cornerRadius = 6
        textInputBtn.contentHorizontalAlignment = .left
        textInputBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        textInputBtn
            .font(14, Font_AvenirNext_Medium)
            .titleColor(UIColor.darkText)
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: self)
        textInputBtn.snp.makeConstraints {
            $0.bottom.equalTo(snp.centerY).offset(-6)
            $0.left.equalTo(24)
            $0.right.equalTo(-84)
            $0.height.equalTo(40)
        }
        textInputBtn.addTarget(self, action: #selector(textInputBtnClick(sender:)), for: .touchUpInside)
        textInputBtn.layer.borderWidth = 1
        textInputBtn.layer.borderColor = UIColor(hexString: "#1F1F1F")?.cgColor
        textInputBtn.layer.cornerRadius = 8
        //

        textRandomBtn.layer.cornerRadius = 6
        textRandomBtn
            .title("Ra")
            .image(UIImage(named: ""))
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: self)
        textRandomBtn.snp.makeConstraints {
            $0.centerY.equalTo(textInputBtn.snp.centerY)
            $0.right.equalTo(-24)
            $0.width.equalTo(54)
            $0.height.equalTo(40)
        }
        textRandomBtn.layer.cornerRadius = 8
        textRandomBtn.addTarget(self, action: #selector(textRandomBtnClick(sender:)), for: .touchUpInside)
        
        //

        alightmenBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        alightmenBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        alightmenBtn
            .font(14, Font_AvenirNext_Medium)
            .titleColor(UIColor.darkText)
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: self)
        alightmenBtn.snp.makeConstraints {
            $0.right.equalTo(snp.centerX).offset(-20)
            $0.top.equalTo(textInputBtn.snp.bottom).offset(12)
            $0.left.equalTo(textInputBtn.snp.left)
            $0.height.equalTo(40)
        }
        alightmenBtn.layer.cornerRadius = 8
        alightmenBtn.addTarget(self, action: #selector(alightmentBtnClick(sender:)), for: .touchUpInside)
        
        //
        
        canvasSizeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        canvasSizeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        canvasSizeBtn
            .font(14, Font_AvenirNext_Medium)
            .titleColor(UIColor.darkText)
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: self)
        canvasSizeBtn.snp.makeConstraints {
            $0.left.equalTo(snp.centerX).offset(20)
            $0.top.equalTo(alightmenBtn.snp.top)
            $0.right.equalTo(textRandomBtn.snp.right)
            $0.height.equalTo(40)
        }
        canvasSizeBtn.layer.cornerRadius = 8
        canvasSizeBtn.addTarget(self, action: #selector(canvasSizeBtnClick(sender:)), for: .touchUpInside)
        
        
    }
    

     
    @objc func textInputBtnClick(sender: UIButton) {
        textinputBtnClickBlock?()
    }
    
    @objc func textRandomBtnClick(sender: UIButton) {
        textRandomBtnClickBlock?()
    }
    
    @objc func alightmentBtnClick(sender: UIButton) {
        if contentAligment == .center {
            updateTextAligment(aligment: .left)
        } else if contentAligment == .left {
            updateTextAligment(aligment: .right)
        } else if contentAligment == .right {
            updateTextAligment(aligment: .center)
        }
        alightmentBtnClickBlock?(contentAligment)
    }
    
    @objc func canvasSizeBtnClick(sender: UIButton) {
        if cardCanvasSize == .size1_1 {
            cardCanvasSize = .size4_3
            updateCanvasSize(sizeType: cardCanvasSize)
        } else if cardCanvasSize == .size4_3 {
            cardCanvasSize = .size3_4
            updateCanvasSize(sizeType: cardCanvasSize)
        } else if cardCanvasSize == .size3_4 {
            cardCanvasSize = .size1_1
            updateCanvasSize(sizeType: cardCanvasSize)
        }
        canvasSizeBtnClickBlock?(cardCanvasSize)
    }
    
    
    func updateTextAligment(aligment: NSTextAlignment) {
        contentAligment = aligment
        if aligment == .left {
            alightmenBtn
                .image(UIImage(named: "alignment_left"))
                .title("Left")
        } else if aligment == .center {
            alightmenBtn
                .image(UIImage(named: "alignment_center"))
                .title("Center")
        } else if aligment == .right {
            alightmenBtn
                .image(UIImage(named: "alignment_right"))
                .title("Right")
        }
    }
    
    func updateCanvasSize(sizeType: TextCardCanvasSize) {
        if sizeType == .size1_1 {
            canvasSizeBtn
                .image(UIImage(named: "canvas_1_1"))
                .title("1:1")
        } else if sizeType == .size4_3 {
            canvasSizeBtn
                .image(UIImage(named: "canvas_4_3"))
                .title("4:3")
        } else if sizeType == .size3_4 {
            canvasSizeBtn
                .image(UIImage(named: "canvas_3_4"))
                .title("3:4")
        }
    }
    
    
    
    
}


extension KIkbsCardTextInputBar: JXPagingViewListViewDelegate {
    
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



 
