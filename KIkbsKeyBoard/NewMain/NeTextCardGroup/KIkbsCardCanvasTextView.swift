//
//  KIkbsCardCanvasTextView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/6.
//

import UIKit
import AttributedStringBuilder


class KIkbsCardCanvasTextView: UIView {

    
    var contentTextLabel = UILabel()
    var canvasContentOverlayerImgV = UIImageView()
    //
    var currentString: String = ""
    var currentColorItem: TextCardThemeColor?
    var currentOverlayerItem: TextCardThemeOverlayerItem?
    var currentAlignment: NSTextAlignment = .center
//    var currentBuilder = AttributedStringBuilder()
    var currentAttribuList: [[AttributedStringBuilder.Attribute]] = []
    var currentWordList: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     

}

extension KIkbsCardCanvasTextView {
    func setupView() {
        backgroundColor(UIColor.white)
        
        //
        contentTextLabel.numberOfLines = 0
        contentTextLabel.adjustsFontSizeToFitWidth = true
        contentTextLabel
            .adhere(toSuperview: self)
        contentTextLabel.snp.makeConstraints {
            $0.top.left.equalTo(30)
            $0.center.equalToSuperview()
        }
        
        //
        canvasContentOverlayerImgV
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: self)
        canvasContentOverlayerImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    
    
}
 
extension KIkbsCardCanvasTextView {
    func processCanvasCustomText() {
        var str = currentString.trimmingCharacters(in: .whitespacesAndNewlines)
        str = str.replacingOccurrences(of: "\n", with: " ")
        let wordList = str.components(separatedBy: " ")

        let builder = AttributedStringBuilder()
        
        if currentAlignment == .center {
            builder.defaultAttributes = [.alignment(.center)]
        } else if currentAlignment == .left {
            builder.defaultAttributes = [.alignment(.left)]
        } else if currentAlignment == .right {
            builder.defaultAttributes = [.alignment(.right)]
        }
        
        let lineReturnPersent: Int = 7
        
        currentAttribuList = []
        currentWordList = []
        
        for (index, word) in wordList.enumerated() {
            let yu = index % 2
            var fontName = Font_Avenir_Heavy
            var colorStr = "#FFFFFF"
            if yu == 0 {
                fontName = KIkbsDataManager.default.textCardThemeHilightFontList.randomElement() ?? Font_Avenir_Heavy
                colorStr = currentColorItem?.hilightTextColors.randomElement() ?? "#FFFFFF"
            } else {
                fontName = KIkbsDataManager.default.textCardThemeNormalFontList.randomElement() ?? Font_Avenir_Heavy
                colorStr = currentColorItem?.normalTextColor ?? "#FFFFFF"
            }
            
            let font = UIFont(name: fontName, size: 22) ?? UIFont.systemFont(ofSize: 22)
            let color = UIColor(hexString: colorStr) ?? UIColor.white
            let titleAttributes: [AttributedStringBuilder.Attribute] = [
                .font(font),
                .textColor(color),
            ]
            builder.text(word, attributes: titleAttributes)
            currentWordList.append(word)
            builder.space()
            currentWordList.append(" ")
            //
            let perLine = [0, 1, 2, 3, 4 ,5 ,6 ,7, 8, 9, 10]
            let item = perLine.randomElement() ?? 5
            if item > lineReturnPersent {
                builder.newline()
                currentWordList.append("\n")
            }
            //
            currentAttribuList.append(titleAttributes)
            
        }
        
        contentTextLabel.attributedText = builder.attributedString
        
    }
}



extension KIkbsCardCanvasTextView {
    
    func updateCanvasTextStr(text: String) {
        currentString = text
        //  分解text 把介词和随机的一些词 进行高亮状态
        
        processCanvasCustomText()
    }
    
    func updateTextAlignment(alignment: NSTextAlignment) {
        currentAlignment = alignment
        let builder = AttributedStringBuilder()
        builder.defaultAttributes = [.alignment(alignment)]
        
        var realWorlIndex: Int = 0
        
        for word in currentWordList {
            if word == " " {
                builder.space()
            } else if word == "\n" {
                builder.newline()
            } else {
                let attri = currentAttribuList[realWorlIndex]
                builder.text(word, attributes: attri)
                realWorlIndex += 1
            }
        }
        
        contentTextLabel.attributedText = builder.attributedString
        
    }
    
    

    func updateCanvasThemeColor(themeColorItem: TextCardThemeColor) {
        
        currentColorItem = themeColorItem
        
        backgroundColor(UIColor(hexString: themeColorItem.bgColor) ?? UIColor.white)
        
        processCanvasCustomText()
    }

    func updateCanvasOverlayerImg(overlayerItem: TextCardThemeOverlayerItem) {
        
        currentOverlayerItem = overlayerItem
        
        canvasContentOverlayerImgV
            .image(overlayerItem.big)
    }
}






/*
 let titleAttributes: [AttributedStringBuilder.Attribute] = [
     .font(UIFont(name: "Futura-Bold", size: 40)!),
     .textColor(UIColor.white),
     .strokeColor(UIColor.magenta),
     .strokeWidth(-8),
     .kerning(5)
 ]
 
 let shadow = NSShadow()
 shadow.shadowColor = UIColor.black
 shadow.shadowBlurRadius = 5

 let awesomeAttributes: [AttributedStringBuilder.Attribute] = [
     .font(UIFont(name: "AvenirNext-Bold", size: 40)!),
     .textColor(UIColor.yellow),
     .kerning(5),
     .shadow(shadow),
     .skew(0.3),
     .underline(true)
 ]
 
 let image = UIImage(named: "PurpleMonster")!
         
 builder
     .image(image, withSizeFittingFontUppercase: font)
     .text("Hello")
     .image(image, withSizeFittingFontLowercase: font)
 
 */


