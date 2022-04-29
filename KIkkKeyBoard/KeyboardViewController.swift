//
//  KeyboardViewController.swift
//  KIkkKeyBoard
//
//  Created by JOJO on 2021/7/2.
//

import UIKit
import ISEmojiView

// 开发教程： https://www.jianshu.com/p/434e6f4b429b
class KeyboardViewController: UIInputViewController {

    var topBarHeight: CGFloat = 45
    var topBarContentView: UIView = UIView()
    var bottomBarContentView: UIView = UIView()
    var customKeyboardView: KeyboardView = KeyboardView.init(frame: .zero)
    
    var topMenuBar: KIkTopMenuBar?
    var stuffFontView: KIkFontSelectV?
    var stuffFavoriteView: KIkFavoriteSelectV?
    var emojiView: EmojiView?
    
    var isShiftUp: Bool = false
    var isDoubleClickShiftWaiting = false
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500)
        
        KIkbsKeboardFavoriteDB.default.prepareDB()
        setupView()
        setupKeyActionBlock()
        // Perform custom UI setup here
         
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
         
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupDefaultKeyboard()
        setupTopMenuView()
        setupStuffFontView()
        setupStuffFavoriteView()
        setupEmojiView()
        showUICustomKeyboardStuffStatus()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

extension KeyboardViewController {
    
    
    
}

extension KeyboardViewController {
    func setupDefaultKeyboard() {
        topBarContentView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: topBarHeight)
        bottomBarContentView.frame = CGRect.init(x: 0, y: topBarHeight, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight)
        customKeyboardView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight)
        bottomBarContentView.addSubview(customKeyboardView)
       
        if let fontItem = KBKeyBtnManager.default.currentFontItem {
            
            KBKeyBtnManager.default.currentFontItem = fontItem
            self.showUICustomKeyboardStuffStatus()
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
            
        }
    }
}

extension KeyboardViewController {
    
    func defaultHiddenAllView() {
        customKeyboardView.isHidden = true
        stuffFontView?.isHidden = true
        stuffFavoriteView?.isHidden = true
        emojiView?.isHidden = true
    }
    
    func showUIFontStuffStatus() {
        defaultHiddenAllView()
        stuffFontView?.isHidden = false
    }
    
    func showUIFavoriteStuffStatus() {
        defaultHiddenAllView()
        stuffFavoriteView?.isHidden = false
    }
    
    func showUICustomKeyboardStuffStatus() {
        defaultHiddenAllView()
        customKeyboardView.isHidden = false
    }
    
    func showUIEmojiStatus() {
        customKeyboardView.isHidden = false
        emojiView?.isHidden = false
    }
    
    
}

//TODO: 顶部Bar
extension KeyboardViewController {
    func setupTopMenuView() {
        topMenuBar = KIkTopMenuBar.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: topBarHeight))
        guard let topMenuBar = topMenuBar else { return }
        topBarContentView.addSubview(topMenuBar)
        topMenuBar.fontBtnClickBlock = {
            [weak self] isShow in
            guard let `self` = self else {return}
            if isShow {
                self.showUIFontStuffStatus()
            } else {
                self.showUICustomKeyboardStuffStatus()
            }
            
        }

        topMenuBar.favoriteBtnClickBlock = {
            [weak self] isShow, favoriteTitleItem in
            guard let `self` = self else {return}
            if isShow {
                if let favoriteTitleItem_m = favoriteTitleItem {
                    self.stuffFavoriteView?.updateContent(titleKeyOnly: favoriteTitleItem_m.keyOnly)
                    self.showUIFavoriteStuffStatus()
                }
            } else {
                self.showUICustomKeyboardStuffStatus()
            }
        }
    }
}

extension KeyboardViewController {
    
}

//TODO: 字体选择页面、特殊符号选择页面、tag选择页面
extension KeyboardViewController {
    func setupStuffFontView() {
        stuffFontView = KIkFontSelectV.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let stuffFontView = stuffFontView else { return }
        bottomBarContentView.addSubview(stuffFontView)
        stuffFontView.didClickAction = {[weak self] (fontItem, indexPath) in
            guard let `self` = self else {return}
            
            KBKeyBtnManager.default.currentFontItem = fontItem
            self.showUICustomKeyboardStuffStatus()
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
            self.topMenuBar?.updateFontSelectStatus(isSele: false)
        }
    }
    
    func setupStuffFavoriteView() {
        stuffFavoriteView = KIkFavoriteSelectV.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let stuffFavoriteView = stuffFavoriteView else { return }
        bottomBarContentView.addSubview(stuffFavoriteView)
        stuffFavoriteView.didClickAddNewAction = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.openHomeApp(type: "")
            }
            
        }
        stuffFavoriteView.didClickAction = {
            [weak self] favoriteStr in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.textDocumentProxy.insertText(favoriteStr)
            }
        }
        
    }
    
    func fuHaoTagClickOpenKeyboard(contentText: String, status: String) {
        self.textDocumentProxy.insertText(contentText)
    }
    
    func setupEmojiView() {
        let keyboardSettings = KeyboardSettings(bottomType: .categories)
        keyboardSettings.countOfRecentsEmojis = 10
        keyboardSettings.updateRecentEmojiImmediately = true
        keyboardSettings.needToShowAbcButton = true
        emojiView = EmojiView(keyboardSettings: keyboardSettings)
        emojiView!.translatesAutoresizingMaskIntoConstraints = false
        emojiView!.frame = CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight)
        emojiView!.delegate = self
        emojiView!.isHidden = true
        bottomBarContentView.addSubview(emojiView!)
        emojiView!.snp.makeConstraints {[weak self] (make) in
            guard let `self` = self else { return }
            make.center.equalToSuperview()
            make.width.equalTo(self.bottomBarContentView.frame.size.width)
            make.height.equalTo(self.bottomBarContentView.frame.size.height)
        }
    }
    
}

// custom keyboard
extension KeyboardViewController {
    func setupView() {
        //
        topBarContentView = UIView()
        topBarContentView.backgroundColor = .white
        view.addSubview(topBarContentView)
        bottomBarContentView = UIView()
        bottomBarContentView.backgroundColor = .white
        view.addSubview(bottomBarContentView)
    }
    
    func setupKeyActionBlock() {
        KBKeyBtnManager.default.action_textInputBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: 键入文字
            self.textDocumentProxy.insertText(inputText)
            if self.isShiftUp {
                self.isShiftUp = false
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
            }
            
        }
        
        KBKeyBtnManager.default.action_SHIFTBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: SHIFT按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
        }
        
        KBKeyBtnManager.default.action_ShiftBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: Shift按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
            //
            if !self.isDoubleClickShiftWaiting {
                debugPrint("if !self.isDoubleClickShiftWaiting {")
                self.isDoubleClickShiftWaiting = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
                    guard let `self` = self else {return}
                    debugPrint("DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)")
                    self.isDoubleClickShiftWaiting = false
                }
            } else {
                debugPrint("isDoubleClickShiftWaiting = true")
                self.isDoubleClickShiftWaiting = false
                self.isShiftUp = false
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_2())
                debugPrint("KBKeyBtnManager.default.keyboardMappingStyle_2())")
            }
        }
        
        KBKeyBtnManager.default.action_shiftBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: shift按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_3())
            //
            debugPrint("KBKeyBtnManager.default.action_shiftBlock ")
            self.isShiftUp = true
            if !self.isDoubleClickShiftWaiting {
                debugPrint("if !self.isDoubleClickShiftWaiting {")
                self.isDoubleClickShiftWaiting = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
                    guard let `self` = self else {return}
                    debugPrint("DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)")
                    self.isDoubleClickShiftWaiting = false
                }
            } else {
                debugPrint("isDoubleClickShiftWaiting = true")
                self.isDoubleClickShiftWaiting = false
                self.isShiftUp = false
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_2())
                debugPrint("KBKeyBtnManager.default.keyboardMappingStyle_2())")
            }
            
        }
        
        KBKeyBtnManager.default.action_backClearBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: backClear按钮 Action
            self.textDocumentProxy.deleteBackward()
        }
        
        KBKeyBtnManager.default.action_special123Block = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: special123按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_4())
        }
        
        KBKeyBtnManager.default.action_jinghaojiahaodenghaoBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: jinghaojiahaodenghao按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_5())
        }
        
        KBKeyBtnManager.default.action_123Block = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: 123按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_4())
        }
        
        KBKeyBtnManager.default.action_ABCBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: ABC按钮 Action
            self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
        }
        
        KBKeyBtnManager.default.action_GlobeBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: Globe按钮 Action
            self.advanceToNextInputMode()
        }
        
        KBKeyBtnManager.default.action_SpaceBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: Space按钮 Action
            self.textDocumentProxy.insertText(" ")
        }
        
        KBKeyBtnManager.default.action_EmojiBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            
             //TODO: Emoji按钮 Action
             self.showUIEmojiStatus()
             
        }
        
        KBKeyBtnManager.default.action_sendBlock = {[weak self] (keyBtnType: KBKeyBtnActionType, inputText: String) in
            guard let `self` = self else {return}
            //TODO: send按钮 Action
            self.textDocumentProxy.insertText("\n")
        }
    }
    
    /// 打开主APP
    /// - Parameter type: 打開類型
    func openHomeApp(type: String) {
        
        let scheme = "KIKeykbsKeyBoard://\("Favorite")"
        let url: URL = URL(string: scheme)!
        let context = NSExtensionContext()
        context.open(url, completionHandler: nil)
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        while (responder != nil) {
            if responder!.responds(to: selectorOpenURL) {
                responder!.perform(selectorOpenURL, with: url)
                debugPrint("responder!.perform(selectorOpenURL, with: url)")
                break
            }
            responder = responder?.next
        }
       
        debugPrint("self.extensionContext?.completeRequest")
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        
    }
    
}

extension KeyboardViewController: EmojiViewDelegate {
    // MARK: - EmojiViewDelegate
    
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
        textDocumentProxy.insertText(emoji)
    }
    
    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
        showUICustomKeyboardStuffStatus()
    }
    
    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
        textDocumentProxy.deleteBackward()
    }
    
    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
        showUICustomKeyboardStuffStatus()
    }
}


 




