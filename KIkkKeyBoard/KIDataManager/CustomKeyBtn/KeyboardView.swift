//
//  KeyboardView.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import Foundation
import UIKit

class KeyboardView: UIView {
 
    let padding: CGFloat = 0
    var normalWidth: CGFloat = 20
    var normalHeight: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 189.0/255.0, green: 192.0/255.0, blue: 197.0/255.0, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    

}

extension KeyboardView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let touchPoint: CGPoint = touch.location(in: self)
             
            let currentKeyBtn: KBKeyBtn? = self.subviews.first { (subView) -> Bool in
                if subView.frame.contains(touchPoint) {
                    return true
                }
                return false
                } as? KBKeyBtn
            guard let keyBtn = currentKeyBtn else { return }
            keyBtn.btnType.action?(keyBtn.btnType.type, keyBtn.btnType.inputText ?? "")
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
}

extension KeyboardView {
    func setupKeyboardWithStyle(keyBtnListStyle: [[KBKeyBtn]]) {
        self.subviews.forEach { $0.removeFromSuperview() }
        
        let keyBtnList: [[KBKeyBtn]] = keyBtnListStyle
        setupNormalKeyWidth(keyBtnList: keyBtnList)

        for (indexLine, keyBtnLine) in keyBtnList.enumerated() {
            for (indexCount, keyBtn) in keyBtnLine.enumerated() {
                var leftBtn: KBKeyBtn? = nil
                if indexCount != 0 {
                     leftBtn = keyBtnLine[indexCount - 1]
                }
                
                let keyTypeInputBtns: [KBKeyBtn] = keyBtnLine.filter({ (keyBtn: KBKeyBtn) -> Bool in
                    if keyBtn.btnType.type == .TextInput {
                        return true
                    } else {
                        return false
                    }
                })
                
                keyBtn.frame = processKeyBtnFrame(lineIndex: indexLine, countIndex: indexCount, keyBtn: keyBtn, leftKeyBtn: leftBtn, lineTextInputBtnsCount: keyTypeInputBtns.count)
                self.addSubview(keyBtn)
            }
        }
    }
    
}

extension KeyboardView {
    func setupNormalKeyWidth(keyBtnList: [[KBKeyBtn]]) {
 
        normalWidth = self.frame.size.width / CGFloat(keyBtnList[0].count)
        normalHeight = self.frame.size.height / CGFloat(keyBtnList.count)
   }
   
    func processKeyBtnFrame(lineIndex: Int, countIndex: Int, keyBtn: KBKeyBtn, leftKeyBtn: KBKeyBtn?, lineTextInputBtnsCount: Int) -> CGRect {
        var rect = CGRect.zero
       
        var leftOffsetX: CGFloat = 0
        if let leftKeyBtn = leftKeyBtn {
            leftOffsetX = leftKeyBtn.frame.maxX
            if keyBtn.btnType.type == .TextInput {
                if leftKeyBtn.btnType.type == .action_SHIFT || leftKeyBtn.btnType.type == .action_Shift || leftKeyBtn.btnType.type == .action_shift || leftKeyBtn.btnType.type == .action_special123 || leftKeyBtn.btnType.type == .action_jinghaojiahaodenghao {
                    
                    if lineTextInputBtnsCount < 7 {
                        let padding = ((self.frame.size.width - leftKeyBtn.frame.size.width * 2) - (CGFloat(7) * normalWidth)) / 2
                         
                        leftOffsetX += padding
                    } else {
                        let padding = ((self.frame.size.width - leftKeyBtn.frame.size.width * 2) - (CGFloat(lineTextInputBtnsCount) * normalWidth)) / 2
                        debugPrint("**(self.frame.size.width - leftKeyBtn.frame.size.width * 2) = \((self.frame.size.width - leftKeyBtn.frame.size.width * 2))")
                        debugPrint("**lineBtnsCount = \(lineTextInputBtnsCount)")
                        debugPrint("**padding = \(padding)")
                        leftOffsetX += padding
                    }
                }
            }
        } else {
            if keyBtn.btnType.type == .TextInput {
                if (CGFloat(lineTextInputBtnsCount) * normalWidth) < (self.frame.size.width - 4) {
                    leftOffsetX = normalWidth / 2
                }
            }
        }
        
        var originalX = leftOffsetX
            
        var leftOffsetY: CGFloat = CGFloat(lineIndex) * normalHeight
        if let leftKeyBtn = leftKeyBtn {
            leftOffsetY = leftKeyBtn.frame.minY
        }
        let originalY = leftOffsetY
        
        let rectType = keyBtn.btnType.rectType
        var keyWidth = normalWidth
        
        switch rectType {
        case let .hardWidth(multiplier: multi):
            keyWidth = keyWidth * multi
            
            //TODO: 特殊符号 第三行 单独设置
            if keyBtn.btnType.type == .TextInput {
                if lineTextInputBtnsCount < 7 {
                    if let leftKeyBtn = leftKeyBtn {
                        leftOffsetX = leftKeyBtn.frame.maxX
                        if keyBtn.btnType.type == .TextInput {
                            if leftKeyBtn.btnType.type == .action_SHIFT || leftKeyBtn.btnType.type == .action_Shift || leftKeyBtn.btnType.type == .action_shift || leftKeyBtn.btnType.type == .action_special123 || leftKeyBtn.btnType.type == .action_jinghaojiahaodenghao {
                                let padding = ((self.frame.size.width - leftKeyBtn.frame.size.width * 2) - (CGFloat(7) * normalWidth)) / 2
                                let spacielkeyWidth = (self.frame.size.width - (leftKeyBtn.frame.size.width * 2) - (padding * 2)) / CGFloat(lineTextInputBtnsCount)
                                keyWidth = spacielkeyWidth
                                
                            } else {
                                keyWidth = leftKeyBtn.frame.size.width
                            }
                        }
                    }
                }
            }
            
            break
        case .spaceWidth:
            keyWidth = normalWidth * 5
            break
        case .sendWidth:
            keyWidth = self.frame.size.width - originalX
            break
        }
        
        if keyBtn.btnType.type == .action_BackClear {
            originalX = self.frame.size.width - keyWidth
        }
        
        rect = CGRect.init(x: originalX, y: originalY, width: keyWidth, height: normalHeight)
         
 
       return rect
   }
}
