//
//  KEkeyNeTransformVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/5.
//

import UIKit
import JXPagingView
import JXSegmentedView
import ZKProgressHUD


class KEkeyNeTransformVC: UIViewController, UITextViewDelegate {

    var headerInSectionHeight: Int = 50
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = ["  Font  ", "  zalgo  ", ":.*.:*:.*.:"]
    let bottomCanvasView = UIView()
    
    let topBar = UIView()
    var toolView = UIView()
    var hideButton = UIButton()
    let textInputView = UITextView()
    let resultTextView = DPTextView()
    let copyProImgV = UIImageView()
    let favoriteProImgV = UIImageView()
    
    let contentViewTransView = KIkbsTextTypeTransformView()
    let contentViewCenterView = KIkbsTextCenterTransformView()
    let contentViewLeftRight = KIkbsTextLeftRightTransformView()
    
    var currentTransformItem: TextTranformItem? = KIkbsTextTransformManager.default.textTranformFontList.first
    var currentZalgoItem: TextTranformItem? = nil
    var currentLeftRightStrItem: TextTranformItem? = nil
    
    var isCurrentTransFontPro = false
    var isCurrentTransZalgoPro = false
    var isCurrentTransLeftRightPro = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubscribeNotic()
        contentViewSetup()
        setupContent()
        setupCollection()
    }
    func addSubscribeNotic() {
        //
        NotificationCenter.default.addObserver(self, selector: #selector(updateSubscribeSuccessStatus(noti: )), name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success), object: nil)
    }
    
    @objc func updateSubscribeSuccessStatus(noti: Notification) {
        updateCurrentProStatus()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func contentViewSetup() {
        view.backgroundColor(.black)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "FCAFCF")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        let titNameLabel = UILabel()
        titNameLabel.adhere(toSuperview: topBar)
            .text("Text Transform")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        titNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
    }

}

extension KEkeyNeTransformVC {
    func setupContent() {
        // tool view
        view.addSubview(toolView)
        toolView.backgroundColor = UIColor(hexString: "#FFFFFF")
        toolView.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width, height: 40)
        // tool keyborder hiden view
        hideButton.setImage(UIImage(named: "ic_keyboard_close"), for: .normal)
        hideButton.setTitleColor(UIColor.systemBlue, for: .normal)
        hideButton.backgroundColor = UIColor.clear
        hideButton.addTarget(self, action: #selector(hideButtonClick(button:)), for: .touchUpInside)
        toolView.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        //
        textInputView.font = UIFont(name: Font_AvenirNext_Medium, size: 16)
        textInputView.textColor = UIColor.darkText
        textInputView.text = ""
        textInputView.placeholder = "Font"
        textInputView.delegate = self
        textInputView.inputAccessoryView = toolView
        textInputView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textInputView
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: view)
        textInputView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(2)
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.height.equalTo(100)
        }
        textInputView.layer.cornerRadius = 10
        textInputView.clipsToBounds = true
        //

        resultTextView.font = UIFont(name: Font_AvenirNext_Medium, size: 16)
        resultTextView.textColor = UIColor.darkText
        resultTextView.isEditable = false
        resultTextView.text = ""
        resultTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        resultTextView
            .backgroundColor(UIColor(hexString: "#F2F2F7")!)
            .adhere(toSuperview: view)
        resultTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(2)
            $0.top.equalTo(textInputView.snp.bottom).offset(2)
            $0.height.equalTo(120)
        }
        resultTextView.layer.cornerRadius = 10
        resultTextView.clipsToBounds = true
        
        updateResultTextViewContent()
        
        //
        let copyBtn = UIButton()
        copyBtn
            .adhere(toSuperview: view)
            .setImage(UIImage(named: "ic_b_cop"), for: .normal)
        copyBtn.snp.makeConstraints {
            $0.bottom.equalTo(resultTextView.snp.bottom).offset(-6)
            $0.right.equalTo(resultTextView.snp.right).offset(-15)
            $0.width.equalTo(42)
            $0.height.equalTo(42)
        }
        copyBtn.addTarget(self, action: #selector(contentCopyBtnClick(sender: )), for: .touchUpInside)
        //
        
        copyProImgV.image("ic_pro")
        copyProImgV.adhere(toSuperview: view)
        copyProImgV.snp.makeConstraints {
            $0.top.equalTo(copyBtn.snp.top).offset(-8)
            $0.right.equalTo(copyBtn.snp.right).offset(8)
            $0.width.height.equalTo(17)
        }
        copyProImgV.isHidden = true
        //
        let favoriteBtn = UIButton()
        favoriteBtn
            .adhere(toSuperview: view)
            .setImage(UIImage(named: "ic_b_favorite"), for: .normal)
        favoriteBtn.snp.makeConstraints {
            $0.bottom.equalTo(copyBtn.snp.bottom)
            $0.right.equalTo(copyBtn.snp.left).offset(-6)
            $0.width.equalTo(42)
            $0.height.equalTo(42)
        }
        favoriteBtn.addTarget(self, action: #selector(contentFavoriteBtnClick(sender: )), for: .touchUpInside)
        
        //
        favoriteProImgV.image("ic_pro")
        favoriteProImgV.adhere(toSuperview: view)
        favoriteProImgV.snp.makeConstraints {
            $0.top.equalTo(favoriteBtn.snp.top).offset(-8)
            $0.right.equalTo(favoriteBtn.snp.right).offset(8)
            $0.width.height.equalTo(17)
        }
        favoriteProImgV.isHidden = true
        
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(resultTextView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
    }
    
    func setupCollection() {
        dataSource.titles = titles
        
        dataSource.titleNormalColor = UIColor.white
        dataSource.titleSelectedColor = UIColor(hexString: "FFEF5A")!
        dataSource.titleNormalFont = UIFont(name: "Futura-CondensedExtraBold", size: 14) ?? UIFont.systemFont(ofSize: 14)
        dataSource.titleSelectedFont = UIFont(name: "Futura-CondensedExtraBold", size: 14)
        dataSource.itemWidthSelectedZoomScale = 0
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = false
        segmentedView.backgroundColor = UIColor(hexString: "7EA0D4")
        segmentedView.delegate = self
        segmentedView.dataSource = dataSource
        bottomCanvasView.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
        pagingView.mainTableView.backgroundColor = UIColor(hexString: "F2F2F7")
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = UIColor(hexString: "F2F2F7")!
    }
}

extension KEkeyNeTransformVC {
    func updateResultTextViewContent() {
        
        var currenTransItem = TextTranformItem()
        
        if let fontTransItem = currentTransformItem {
            currenTransItem.previewStr = fontTransItem.previewStr
            currenTransItem.contentStr_low = fontTransItem.contentStr_low
            currenTransItem.contentStr_up = fontTransItem.contentStr_up
        }
        if let zalgoTransItem = currentZalgoItem {
            currenTransItem.zalgoList = zalgoTransItem.zalgoList
        }
        if let leftrightTransItem = currentLeftRightStrItem {
            currenTransItem.leftAddStr = leftrightTransItem.leftAddStr
            currenTransItem.rightAddStr = leftrightTransItem.rightAddStr
        }
        
        var originStr: String = textInputView.text
        if textInputView.text == "" {
            originStr = "Font"
        }
        
        let resultString = KIkbsTextTransformManager.default.processReplaceText(contentStr: originStr, transformItem: currenTransItem)
        resultTextView.text = resultString
        
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        updateResultTextViewContent()
    }
    
    func updateCurrentProStatus() {
        if KIkbsPurchaseManager.default.inSubscription {
            copyProImgV.isHidden = true
            favoriteProImgV.isHidden = true
        } else {
            if isCurrentTransFontPro || isCurrentTransZalgoPro || isCurrentTransLeftRightPro {
                copyProImgV.isHidden = false
                favoriteProImgV.isHidden = false
            } else {
                copyProImgV.isHidden = true
                favoriteProImgV.isHidden = true
            }
        }

    }
}

extension KEkeyNeTransformVC {
    
    @objc func contentCopyBtnClick(sender: UIButton) {
        if copyProImgV.isHidden == true || KIkbsPurchaseManager.default.inSubscription {
            //
            let resultStr = resultTextView.text.replacingOccurrences(of: " ", with: "")
            if resultStr.count == 0 {
                ZKProgressHUD.showMessage("Please enter valid text.")
                return
            }
            UIPasteboard.general.string = resultTextView.text
            ZKProgressHUD.showSuccess("Copy successfully!")
        } else {
            self.present(KIkbsStoreVC(), animated: true)
        }
        
    }
    
    @objc func contentFavoriteBtnClick(sender: UIButton) {
        if resultTextView.text.count >= 1 {
            let newInputText: String = resultTextView.text
            let keyOnly = Date().timeIntervalSince1970.string
            let groupOnlyKey = "00001"
            // 添加新的
            KIkbsKeboardFavoriteDB.default.addKeyFavoriteContent(favoriteKeyOnly: keyOnly, groupNameKeyOnly: groupOnlyKey, favoriteContentStr: newInputText) {
                DispatchQueue.main.async {
                    ZKProgressHUD.showSuccess("Save to favorites successfully!")
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: noti_favoriteFetch),
                        object: nil,
                        userInfo: nil
                    )
                }
            }
        } else {
            ZKProgressHUD.showMessage("Please enter valid text first")
        }
    }
    
    @objc func hideButtonClick(button: UIButton) {
        textInputView.resignFirstResponder()
    }
    
}

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

extension KEkeyNeTransformVC: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 0
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return UIView()
    }

    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return headerInSectionHeight
    }

    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }

    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        if index == 0 {
            contentViewTransView.itemClickBlock = {
                [weak self] fitem, ispro in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.isCurrentTransFontPro = ispro
                    self.currentTransformItem = fitem
                    self.updateResultTextViewContent()
                    self.updateCurrentProStatus()
//                    self.contentViewCenterView.currentIndexPath = nil
//                    self.contentViewCenterView.collection.reloadData()
//                    self.contentViewLeftRight.currentIndexPath = nil
//                    self.contentViewLeftRight.collection.reloadData()
                }
            }
            return contentViewTransView
        } else if index == 1 {
            contentViewCenterView.itemClickBlock = {
                [weak self] zitem, ispro in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.isCurrentTransZalgoPro = ispro
                    if self.currentZalgoItem?.zalgoList.first == zitem.zalgoList.first && self.currentZalgoItem?.zalgoList.last == zitem.zalgoList.last {
                        self.currentZalgoItem = nil
                        self.contentViewCenterView.currentIndexPath = nil
                        self.contentViewCenterView.collection.reloadData()
                    } else {
                        self.currentZalgoItem = zitem
                    }
                    self.updateResultTextViewContent()
                    self.updateCurrentProStatus()
                    
//                    self.contentViewTransView.currentIndexPath = nil
//                    self.contentViewTransView.collection.reloadData()
//                    self.contentViewLeftRight.currentIndexPath = nil
//                    self.contentViewLeftRight.collection.reloadData()
                }
            }
            return contentViewCenterView
        } else if index == 2 {
            contentViewLeftRight.itemClickBlock = {
                [weak self] ritem, ispro in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.isCurrentTransLeftRightPro = ispro
                    if self.currentLeftRightStrItem?.leftAddStr == ritem.leftAddStr && self.currentLeftRightStrItem?.rightAddStr == ritem.rightAddStr {
                        self.currentLeftRightStrItem = nil
                        self.contentViewLeftRight.currentIndexPath = nil
                        self.contentViewLeftRight.collection.reloadData()
                    } else {
                        self.currentLeftRightStrItem = ritem
                        
                    }
                    self.updateResultTextViewContent()
                    self.updateCurrentProStatus()
                    
                    
//                    self.contentViewTransView.currentIndexPath = nil
//                    self.contentViewTransView.collection.reloadData()
//                    self.contentViewCenterView.currentIndexPath = nil
//                    self.contentViewCenterView.collection.reloadData()
                }
            }
            return contentViewLeftRight
        }
//        else if index == 3 {
//            let contentView = KIkbsMorseCodeTransformView()
//            contentView.wordToMorseVBtnClickBlock = {
//                [weak self] in
//                guard let `self` = self else {return}
//                DispatchQueue.main.async {
//
//                }
//            }
//            contentView.morseToWordVBtnClickBlock = {
//                [weak self] in
//                guard let `self` = self else {return}
//                DispatchQueue.main.async {
//
//                }
//            }
//            return contentView
//        }
        return KIkbsMorseCodeTransformView()
    }
    
}
//, JXSegmentedViewDataSource
extension KEkeyNeTransformVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}
