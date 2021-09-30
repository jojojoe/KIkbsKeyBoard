//
//  KBKeyBtnManager.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit


import Foundation
import UIKit

public struct KBKeyBtnFontTypeItem: Codable {
    var title: String = ""
    var needPurchase: Bool = false
    var lowercase: [String] = []
    var uppercase: [String] = []
    
}
 

class KBKeyBtnManager: NSObject {
    static let `default` = KBKeyBtnManager()
    let shiftBtnWidthMulti: CGFloat = 1.17
    
    let fontDatasList: [KBKeyBtnFontTypeItem] = KeyBStuffDataMana.loadJson([KBKeyBtnFontTypeItem].self, name: "KeyBstyleList") ?? []
    var currentFontItem: KBKeyBtnFontTypeItem? = KeyBStuffDataMana.loadJson([KBKeyBtnFontTypeItem].self, name: "KeyBstyleList")?.first {
        didSet {
            UserDefaults.standard.setValue(currentFontItem?.title, forKey: "kCurrentFontItem")
        }
    }
    
    // key action block
    var action_textInputBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    var action_SHIFTBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_ShiftBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_shiftBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    var action_backClearBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    var action_special123Block: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_jinghaojiahaodenghaoBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    var action_123Block: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_ABCBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_GlobeBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_SpaceBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_EmojiBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    var action_sendBlock: ((_ type: KBKeyBtnActionType, _ inputText: String)->Void)?
    
    
    override init() {
        super.init()
        
        // init history font
        
        if let saveFontTitle = UserDefaults.standard.object(forKey: "kCurrentFontItem") as? String {
            let item = fontDatasList.first {
                return $0.title == saveFontTitle
            }
            currentFontItem = item
        }
        
    }
    
}

extension KBKeyBtnManager {
    // 字母输入键位
    
    //
    func inputKeyss_Lines(inputKeys: [String], separatedBy: String) -> [[KBKeyBtn]] {
        let maxCount: Int = KBKeyBtnManager.default.currentFontItem?.lowercase.count ?? 0
        var keyLines:[[KBKeyBtn]] = []
        for i in 0..<maxCount {
            var btnLine: [KBKeyBtn] = []
            let keyLine1 = inputKeys[i].components(separatedBy: separatedBy)
            for keyName in keyLine1 {
                // frame
                let keyBtn = key_input(contentString: keyName)
                btnLine.append(keyBtn)
            }
            keyLines.append(btnLine)
        }    
        return keyLines
    }
}

extension KBKeyBtnManager {
    
    // 小写 键盘 键位 格式
    /*
     q w e r t y u i o p
      a s d f g h j k l
   shif z x c v b n m back
   123 global space emoji send
     */
    func keyboardMappingStyle_1() -> [[KBKeyBtn]] {
 
        guard let keys = KBKeyBtnManager.default.currentFontItem?.lowercase else { return [] }
        let inputKeyBtns = inputKeyss_Lines(inputKeys: keys, separatedBy: "--")
        
        let line_1 = inputKeyBtns[0]
        let line_2 = inputKeyBtns[1]
        var line_3 = inputKeyBtns[2]
        line_3.insert(KBKeyBtnManager.default.key_shift(), at: 0)
        line_3.append(KBKeyBtnManager.default.key_backClear())
        
        
        let line_4 = [KBKeyBtnManager.default.key_123(),
        KBKeyBtnManager.default.key_Globe(),
        KBKeyBtnManager.default.key_Space(),
        KBKeyBtnManager.default.key_emoji(),
        KBKeyBtnManager.default.key_send()]
        
        return [line_1, line_2, line_3, line_4]
    }
    
    // 大写 键盘 键位 格式
     /*
      Q W E R T Y U I O P
       A S D F G H J K L
    SHIFT Z X C V B N M back
    123 global space emoji send
      */
     func keyboardMappingStyle_2() -> [[KBKeyBtn]] {
          
         guard let keys = KBKeyBtnManager.default.currentFontItem?.uppercase else { return [] }
         let inputKeyBtns = inputKeyss_Lines(inputKeys: keys, separatedBy: "--")
         
         let line_1 = inputKeyBtns[0]
         let line_2 = inputKeyBtns[1]
         var line_3 = inputKeyBtns[2]
        line_3.insert(KBKeyBtnManager.default.key_SHIFT(), at: 0)
        line_3.append(KBKeyBtnManager.default.key_backClear())
         
         
         let line_4 = [KBKeyBtnManager.default.key_123(),
         KBKeyBtnManager.default.key_Globe(),
         KBKeyBtnManager.default.key_Space(),
         KBKeyBtnManager.default.key_emoji(),
         KBKeyBtnManager.default.key_send()]
         
         return [line_1, line_2, line_3, line_4]
     }
    
    // 首字母大写 键盘 键位 格式
     /*
      Q W E R T Y U I O P
       A S D F G H J K L
    Shift Z X C V B N M back
    123 global space emoji send
      */
     func keyboardMappingStyle_3() -> [[KBKeyBtn]] {
          
        guard let keys = KBKeyBtnManager.default.currentFontItem?.uppercase else { return [] }
        let inputKeyBtns = inputKeyss_Lines(inputKeys: keys, separatedBy: "--")
         
        let line_1 = inputKeyBtns[0]
        let line_2 = inputKeyBtns[1]
        var line_3 = inputKeyBtns[2]
        line_3.insert(KBKeyBtnManager.default.key_Shift(), at: 0)
        line_3.append(KBKeyBtnManager.default.key_backClear())
         
         
        let line_4 = [KBKeyBtnManager.default.key_123(),
        KBKeyBtnManager.default.key_Globe(),
        KBKeyBtnManager.default.key_Space(),
        KBKeyBtnManager.default.key_emoji(),
        KBKeyBtnManager.default.key_send()]
         
        return [line_1, line_2, line_3, line_4]
     }
    
    //  数字 键盘 键位 格式
     /*
      1 2 3 4 5 6 7 8 9 0
      - / : ; ( ) $ & @ "
      #+=  . , ? ! '  back
    ABC global space emoji send
      */
     func keyboardMappingStyle_4() -> [[KBKeyBtn]] {
          
         let keys = [
             "1  2  3  4  5  6  7  8  9  0",
             "_  \\  |  ~  <  >  €  £  ¥  •",
             ".  ,  ?  !  '"
         ]
         let inputKeyBtns = inputKeyss_Lines(inputKeys: keys, separatedBy: "  ")
         
         let line_1 = inputKeyBtns[0]
         let line_2 = inputKeyBtns[1]
         var line_3 = inputKeyBtns[2]
        line_3.insert(KBKeyBtnManager.default.key_jinghaojiahaodenghao(), at: 0)
        line_3.append(KBKeyBtnManager.default.key_backClear())
         
         
         let line_4 = [KBKeyBtnManager.default.key_ABC(),
         KBKeyBtnManager.default.key_Globe(),
         KBKeyBtnManager.default.key_Space(),
         KBKeyBtnManager.default.key_emoji(),
         KBKeyBtnManager.default.key_send()]
         
         return [line_1, line_2, line_3, line_4]
     }
    
    //  字符 键盘 键位 格式
     /*
      [ ] { } # % ^ * + =
      _ \ | ~ < > € £ ¥ •
      123  . , ? ! '  back
    ABC global space emoji send
      */
     func keyboardMappingStyle_5() -> [[KBKeyBtn]] {
          
         let keys = [
             "[  ]  {  }  #  %  ^  *  +  =",
             "-  /  :  ;  (  )  $  &  @  \"",
             ".  ,  ?  !  '"
         ]
         let inputKeyBtns = inputKeyss_Lines(inputKeys: keys, separatedBy: "  ")
         
         let line_1 = inputKeyBtns[0]
         let line_2 = inputKeyBtns[1]
         var line_3 = inputKeyBtns[2]
        line_3.insert(KBKeyBtnManager.default.key_special123(), at: 0)
        line_3.append(KBKeyBtnManager.default.key_backClear())
         
         let line_4 = [KBKeyBtnManager.default.key_ABC(),
         KBKeyBtnManager.default.key_Globe(),
         KBKeyBtnManager.default.key_Space(),
         KBKeyBtnManager.default.key_emoji(),
         KBKeyBtnManager.default.key_send()]
         
         return [line_1, line_2, line_3, line_4]
     }
    
    
    
     
    
}




extension KBKeyBtnManager {
 
    // 普通input key
    func key_input(contentString: String) -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .TextInput, showText: contentString, inputText: contentString, Image: nil, backgroundColor: KBKeyBtn.normalBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: 1)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_textInputBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // shift key
    func key_shift() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_shift, showText: nil, inputText: nil, Image: UIImage.init(named: "ShiftOff"), backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_shiftBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    // SHIFT key
    func key_SHIFT() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_SHIFT, showText: nil, inputText: nil, Image: UIImage.init(named: "ShiftOn"), backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_SHIFTBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // Shift key
    func key_Shift() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_Shift, showText: nil, inputText: nil, Image: UIImage.init(named: "ShiftOnce"), backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_ShiftBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    
    
    // Back clear
    func key_backClear() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_BackClear, showText: nil, inputText: nil, Image: UIImage.init(named: "Backspace"), backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_backClearBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    
    
    func key_special123() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_special123, showText: "123", inputText: nil, Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_special123Block?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // #+=
    func key_jinghaojiahaodenghao() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_jinghaojiahaodenghao, showText: "#+=", inputText: nil, Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_jinghaojiahaodenghaoBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // 123
    func key_123() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_123, showText: "123", inputText: nil, Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_123Block?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // ABC
    func key_ABC() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_ABC, showText: "ABC", inputText: nil, Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_ABCBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // Globe
    func key_Globe() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_Gloab, showText: nil, inputText: nil, Image: UIImage.init(named: "Globe"), backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_GlobeBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // action_Space
    func key_Space() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_Space, showText: "space", inputText: " ", Image: nil, backgroundColor: KBKeyBtn.normalBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .spaceWidth) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_SpaceBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // action_Emoji
    func key_emoji() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_Emoji, showText: "😄", inputText: nil, Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .hardWidth(multiplier: shiftBtnWidthMulti)) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_EmojiBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
    // action_Send
    func key_send() -> KBKeyBtn {
        let btnType = KBKeyBtnType.init(type: .action_Emoji, showText: "Send", inputText: "\n", Image: nil, backgroundColor: KBKeyBtn.shiftBackgroundColor, textColor: KBKeyBtn.textColor, rectType: .sendWidth) {[weak self] (actionType, inputString) in
            // TODO: 按钮点击操作
            guard let `self` = self else {return}
            self.action_sendBlock?(actionType, inputString)
        }
        let keyBtn = KBKeyBtn.init(currentBtnType: btnType)
        return keyBtn
    }
    
}


 


/*
 {
     "title" : "『F』『o』『n』『t』",
     "needPurchase" : false,
     "lowercase" : [
         "『q』--『w』--『e』--『r』--『t』--『y』--『u』--『i』--『o』--『p』",
         "『a』--『s』--『d』--『f』--『g』--『h』--『j』--『k』--『l』",
         "『z』--『x』--『c』--『v』--『b』--『n』--『m』"
     ],
     "uppercase" : [
         "『Q』--『W』--『E』--『R』--『T』--『Y』--『U』--『I』--『O』--『P』",
         "『A』--『S』--『D』--『F』--『G』--『H』--『J』--『K』--『L』",
         "『Z』--『X』--『C』--『V』--『B』--『N』--『M』"
     ]
 },
 */




