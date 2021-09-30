//
//  KeyboardViewController.swift
//  KIkkKeyBoard
//
//  Created by JOJO on 2021/7/2.
//

import UIKit
import ISEmojiView
//class KeyboardViewController: UIInputViewController {
//
//    @IBOutlet var nextKeyboardButton: UIButton!
//
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        // Add custom view sizing constraints here
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//
//    override func viewWillLayoutSubviews() {
//        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
//        super.viewWillLayoutSubviews()
//    }
//
//    override func textWillChange(_ textInput: UITextInput?) {
//        // The app is about to change the document's contents. Perform any preparation here.
//    }
//
//    override func textDidChange(_ textInput: UITextInput?) {
//        // The app has just changed the document's contents, the document context has been updated.
//
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
//    }
//
//}




class KeyboardViewController: UIInputViewController {

    let KB_Notification_OpenStore: String = "KB_Notification_OpenStore"
    var topBarHeight: CGFloat = 55
    var topBarContentView: UIView = UIView()
    var bottomBarContentView: UIView = UIView()
    var customKeyboardView: KeyboardView = KeyboardView.init(frame: .zero)
    
    var topMenuBar: KeyBTopMenuBar?
//    var topFontSelectBar: KBtopFontSelectView?
    var topFontSelectBar: KeyBTopFontSelectBar?
    
    var stuffFontView: KeyBStuffFontView?
    var stuffFuhaoView: KeyBStuffFuHaoView?
    var stuffTagView: KeyBStuffTagView?
    
    var emojiView: EmojiView?
    var coinUnlockView: KeyBCoinLockView?
    
    var isShiftUp: Bool = false
    var isDoubleClickShiftWaiting = false
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupTopFontSelectBar()

        setupStuffFontView()
        setupStuffFuHaoView()
        setupStuffTagView()

        setupEmojiView()
        setupCoinUnlockView()
        
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
       
        // set default style
//        customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
        
        if let fontItem = KBKeyBtnManager.default.currentFontItem {
//            if fontItem.needPurchase && !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: fontItem.title) {
//
//                self.showUIUnlockViewStatus(isShow: true)
//                //
//                KBKeyBtnManager.default.currentFontItem = fontItem
//                self.showUICustomKeyboardStuffStatus()
//                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
//                self.stuffFontView?.collection?.reloadData()
//                self.topFontSelectBar?.collection.reloadData()
//                //
//                self.coinUnlockView?.okBtnClickBlock = {
//                    [weak self] in
//                    guard let `self` = self else {return}
//
//                    if KBCoinManager.default.currentCoinCount() >= KBCoinManager.default.costCount {
//                        KBCoinManager.default.consumeCoin()
//                        debugPrint("KBCoinManager.default.currentCoinCount() = \(KBCoinManager.default.currentCoinCount())")
//                        KeyBUnlockManager.sharedInstance().unlockContentItem(withItemId: fontItem.title) {
//
//                        }
//
//                        self.showUIUnlockViewStatus(isShow: false)
//
//                    } else {
//                        //TODO:跳转到宿主app
//                        self.openHomeApp(type: "Store")
//                    }
//                }
//            } else {
                KBKeyBtnManager.default.currentFontItem = fontItem
                self.showUICustomKeyboardStuffStatus()
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
                
//            }
        }
        
    }
}

extension KeyboardViewController {
    
    func defaultHiddenAllView() {
        customKeyboardView.isHidden = true
        topMenuBar?.isHidden = true
        topFontSelectBar?.isHidden = true
        
        stuffFontView?.isHidden = true
        stuffFuhaoView?.isHidden = true
        stuffTagView?.isHidden = true
 
        coinUnlockView?.isHidden = true
        emojiView?.isHidden = true
    }
    
    func showUIFontStuffStatus() {
        defaultHiddenAllView()
        topMenuBar?.fontBtn.isSelected = true
        topMenuBar?.isHidden = false
        stuffFontView?.isHidden = false
        
        stuffFontView?.collection?.reloadData()
        self.topFontSelectBar?.collection.reloadData()
    }
    
    func showUIFuHaoStuffStatus() {
        defaultHiddenAllView()
        topMenuBar?.fuhaoBtn.isSelected = true
        topMenuBar?.isHidden = false
        stuffFuhaoView?.isHidden = false
         
    }
    
    func showUITagStuffStatus() {
        defaultHiddenAllView()
        topMenuBar?.tagBtn.isSelected = true
        topMenuBar?.isHidden = false
        stuffTagView?.isHidden = false
        
    }
    
     
    
    func showUICustomKeyboardStuffStatus() {
        defaultHiddenAllView()
        
        topFontSelectBar?.isHidden = false
        customKeyboardView.isHidden = false
        
    }
    
    func showUIEmojiStatus() {
        customKeyboardView.isHidden = false
        emojiView?.isHidden = false
    }
    
    
    
    func showUIUnlockViewStatus(isShow: Bool) {
        if isShow {
            coinUnlockView?.isHidden = false
        } else {
            coinUnlockView?.isHidden = true
        }
        
    }
    
    
}

//TODO: 顶部Bar
extension KeyboardViewController {
    func setupTopMenuView() {
        topMenuBar = KeyBTopMenuBar.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: topBarHeight))
        guard let topMenuBar = topMenuBar else { return }
        topBarContentView.addSubview(topMenuBar)
        topMenuBar.fontBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            self.showUIFontStuffStatus()
        }
        topMenuBar.fuhaoBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            self.showUIFuHaoStuffStatus()
        }
        topMenuBar.tagBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            self.showUITagStuffStatus()
        }
         
        
        
    }
    
    func setupTopFontSelectBar() {
        
        topFontSelectBar = KeyBTopFontSelectBar.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: topBarHeight))
        guard let topFontSelectBar = topFontSelectBar else { return }
        topBarContentView.addSubview(topFontSelectBar)
        topFontSelectBar.backBtnClickBlock = {[weak self] in
            //TODO: topFontSelectBar.backBtnActionBlock
            guard let `self` = self else {return}
            self.showUIFontStuffStatus()
        }
        topFontSelectBar.didClickAction = {
            [weak self] fontItem , indexPath in
            guard let `self` = self else {return}
//            if fontItem.needPurchase && !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: fontItem.title) {
//                self.showUICustomKeyboardStuffStatus()
//                self.showUIUnlockViewStatus(isShow: true)
//                KBKeyBtnManager.default.currentFontItem = fontItem
//
//                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
//
//                self.coinUnlockView?.okBtnClickBlock = {
//                    [weak self] in
//                    guard let `self` = self else {return}
//
//                    if KBCoinManager.default.currentCoinCount() >= KBCoinManager.default.costCount {
//                        KBCoinManager.default.consumeCoin()
//                        debugPrint("KBCoinManager.default.currentCoinCount() = \(KBCoinManager.default.currentCoinCount())")
//                        KeyBUnlockManager.sharedInstance().unlockContentItem(withItemId: fontItem.title) {
//
//                        }
//
//
//                        self.showUIUnlockViewStatus(isShow: false)
//
//                        self.stuffFontView?.collection?.reloadData()
//                        self.topFontSelectBar?.collection.reloadData()
//                    } else {
//                        //TODO:跳转到宿主app
//                        self.openHomeApp(type: "Store")
//                    }
//                }
//            } else {
                KBKeyBtnManager.default.currentFontItem = fontItem
                self.showUICustomKeyboardStuffStatus()
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
                self.stuffFontView?.collection?.reloadData()
                self.topFontSelectBar?.collection.reloadData()
//            }
        }
    }
}

extension KeyboardViewController {
    func stuffViewStringClick(contentItem: KBStuffDataFuHaoItem, barType: String) {
//        if contentItem.needPurchase && !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: contentItem.content) {
//
//            self.showUIUnlockViewStatus(isShow: true)
//            self.coinUnlockView?.okBtnClickBlock = {
//                [weak self] in
//                guard let `self` = self else {return}
//
//                if KBCoinManager.default.currentCoinCount() >= KBCoinManager.default.costCount {
//                    KBCoinManager.default.consumeCoin()
//                    self.fuHaoTagClickOpenKeyboard(contentText: contentItem.content, status: barType)
//
//                    debugPrint("KBCoinManager.default.currentCoinCount() = \(KBCoinManager.default.currentCoinCount())")
//
//                    KeyBUnlockManager.sharedInstance().unlockContentItem(withItemId: contentItem.content) {
//
//                    }
//                    self.showUIUnlockViewStatus(isShow: false)
//
//                    if barType == "Fuhao" {
//
//                        self.stuffFuhaoView?.collection?.reloadData()
//                    } else if barType == "Tag" {
//
//                        self.stuffTagView?.collection?.reloadData()
//                    }
//
//
//                } else {
//                    //TODO:跳转到宿主app
//                    self.openHomeApp(type: "Store")
//                }
//            }
//        } else {
            self.fuHaoTagClickOpenKeyboard(contentText: contentItem.content, status: barType)
            
//        }
    }
}

//TODO: 字体选择页面、特殊符号选择页面、tag选择页面
extension KeyboardViewController {
    func setupStuffFontView() {
        stuffFontView = KeyBStuffFontView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let stuffFontView = stuffFontView else { return }
        bottomBarContentView.addSubview(stuffFontView)
        stuffFontView.didClickAction = {[weak self] (fontItem, indexPath) in
            guard let `self` = self else {return}
            
//            if fontItem.needPurchase && !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: fontItem.title) {
//
//                KBKeyBtnManager.default.currentFontItem = fontItem
//                self.showUICustomKeyboardStuffStatus()
//                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
//                self.stuffFontView?.collection?.reloadData()
//                self.topFontSelectBar?.collection.reloadData()
//                self.showUIUnlockViewStatus(isShow: true)
//
//                self.coinUnlockView?.okBtnClickBlock = {
//                    [weak self] in
//                    guard let `self` = self else {return}
//
//                    if KBCoinManager.default.currentCoinCount() >= KBCoinManager.default.costCount {
//                        KBCoinManager.default.consumeCoin()
//                        debugPrint("KBCoinManager.default.currentCoinCount() = \(KBCoinManager.default.currentCoinCount())")
//                        KeyBUnlockManager.sharedInstance().unlockContentItem(withItemId: fontItem.title) {
//
//                        }
//
//
//                        self.showUIUnlockViewStatus(isShow: false)
//
//
//                    } else {
//                        //TODO:跳转到宿主app
//                        self.openHomeApp(type: "Store")
//                    }
//                }
//            } else {
                KBKeyBtnManager.default.currentFontItem = fontItem
                self.showUICustomKeyboardStuffStatus()
                self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())
                
//            }
        }
    }
    
    func fuHaoTagClickOpenKeyboard(contentText: String, status: String) {
        self.textDocumentProxy.insertText(contentText)
//        showUICustomKeyboardStuffStatus()
//        self.customKeyboardView.setupKeyboardWithStyle(keyBtnListStyle: KBKeyBtnManager.default.keyboardMappingStyle_1())

    }
    
    func setupStuffFuHaoView() {
        stuffFuhaoView = KeyBStuffFuHaoView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let stuffFuhaoView = stuffFuhaoView else { return }
        bottomBarContentView.addSubview(stuffFuhaoView)
        stuffFuhaoView.didClickAction = {[weak self] fontItem in
            guard let `self` = self else {return}
            self.stuffViewStringClick(contentItem: fontItem, barType: "Fuhao")
            
        }
    }
    
    func setupStuffTagView() {
        stuffTagView = KeyBStuffTagView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let stuffTagView = stuffTagView else { return }
        bottomBarContentView.addSubview(stuffTagView)
        stuffTagView.didClickAction = {[weak self] fontItem in
            guard let `self` = self else {return}
            self.stuffViewStringClick(contentItem: fontItem, barType: "Tag")
            
        }
    }
    
//    func setupStuffQuoteView() {
//        stuffQuoteView = KBStuffQuoteView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
//        guard let stuffQuoteView = stuffQuoteView else { return }
//        bottomBarContentView.addSubview(stuffQuoteView)
//        stuffQuoteView.didClickAction = {[weak self] fontItem in
//            guard let `self` = self else {return}
//            self.stuffViewStringClick(contentItem: fontItem, barType: "Quote")
//
//        }
//    }
    
//    func setupStuffEmojiStrView() {
//        stuffEmojiView = KBStuffEmojiView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
//        guard let stuffEmojiView = stuffEmojiView else { return }
//        bottomBarContentView.addSubview(stuffEmojiView)
//        stuffEmojiView.didClickAction = {[weak self] fontItem in
//            guard let `self` = self else {return}
//            self.stuffViewStringClick(contentItem: fontItem, barType: "Emoji")
//
//        }
//
//    }
    
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
    
    func setupCoinUnlockView() {
         
        coinUnlockView = KeyBCoinLockView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - topBarHeight))
        guard let coinUnlockView = coinUnlockView else { return }
        bottomBarContentView.addSubview(coinUnlockView)
         
        
        
    }
    
}

// custom keyboard
extension KeyboardViewController {
    func setupView() {
        //
//        let contentV = UIView()
//        view.addSubview(contentV)
//        contentV.snp.makeConstraints {
//            $0.edges.equalTo(0)
//            $0.height.equalTo(300)
//        }
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
        // 发送通知
        debugPrint("KBNotificationTool.sendNotificationForMessage")
//        KBNotificationTool.sendNotificationForMessage(withIdentifier: KB_Notification_OpenStore, userInfo: nil)
        
        
        let scheme = "KIKeykbsKeyBoard://\("Store")"
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


 




