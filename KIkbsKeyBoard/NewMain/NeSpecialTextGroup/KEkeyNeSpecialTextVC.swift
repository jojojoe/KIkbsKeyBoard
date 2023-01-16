//
//  KEkeyNeSpecialTextVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/8.
//

import UIKit
import JXPagingView
import JXSegmentedView
import ZKProgressHUD

class KEkeyNeSpecialTextVC: UIViewController, UITextViewDelegate {
    
    
    var headerInSectionHeight: Int = 50
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = [" Symbol ", "  Emoji  ", " Quote ", "  Shape  "]
    let bottomCanvasView = UIView()
    let textInputView = DPTextView()
    var toolView = UIView()
    var hideButton = UIButton()
//    let copyProImgV = UIImageView()
    let topBar = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewSetup()
        setupCanvasView()
        setupCollection()
        
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
            .backgroundColor(UIColor(hexString: "B0D287")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        let titNameLabel = UILabel()
        titNameLabel.adhere(toSuperview: topBar)
            .text("Special Text")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        titNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        
        
    }
    
    func setupCanvasView() {
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
        textInputView.delegate = self
        textInputView.inputAccessoryView = toolView
        textInputView.text = ""
        textInputView
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: view)
        textInputView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(2)
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.height.equalTo(160)
        }
        textInputView.layer.cornerRadius = 10
        textInputView.clipsToBounds = true
        
        //
        let copyBtn = UIButton()
        copyBtn
            .adhere(toSuperview: view)
            .setImage(UIImage(named: "ic_b_cop"), for: .normal)
        copyBtn.snp.makeConstraints {
            $0.bottom.equalTo(textInputView.snp.bottom).offset(-6)
            $0.right.equalTo(textInputView.snp.right).offset(-15)
            $0.width.equalTo(42)
            $0.height.equalTo(42)
        }
        copyBtn.addTarget(self, action: #selector(copyTextButtonClick(button: )), for: .touchUpInside)
        //
        
//        copyProImgV.image("ic_pro")
//        copyProImgV.adhere(toSuperview: view)
//        copyProImgV.snp.makeConstraints {
//            $0.top.equalTo(copyBtn.snp.top).offset(-8)
//            $0.right.equalTo(copyBtn.snp.right).offset(8)
//            $0.width.height.equalTo(17)
//        }
        
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
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textInputView.snp.bottom).offset(4)
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
        segmentedView.backgroundColor = UIColor(hexString: "7EA0D4")!
        segmentedView.delegate = self
        segmentedView.dataSource = dataSource
        bottomCanvasView.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
        pagingView.mainTableView.backgroundColor = UIColor(hexString: "7EA0D4")!
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = UIColor(hexString: "F2F2F7")!
    }
}

extension KEkeyNeSpecialTextVC {
    @objc func hideButtonClick(button: UIButton) {
        self.textInputView.resignFirstResponder()
    }
    
    @objc func copyTextButtonClick(button: UIButton) {
        self.textInputView.resignFirstResponder()
        
        let resultStr = textInputView.text.replacingOccurrences(of: " ", with: "")
        if resultStr.count == 0 {
            ZKProgressHUD.showMessage("Please enter valid text.")
            return
        }
        
        UIPasteboard.general.string = textInputView.text
        ZKProgressHUD.showSuccess("Copy successfully!")
    }
    
    @objc func contentFavoriteBtnClick(sender: UIButton) {
        self.textInputView.resignFirstResponder()
        if textInputView.text.count >= 1 {
            let newInputText: String = textInputView.text
            let keyOnly = Date().timeIntervalSince1970.string
            let groupOnlyKey = "00001"
            // 添加新的
            KIkbsKeboardFavoriteDB.default.addKeyFavoriteContent(favoriteKeyOnly: keyOnly, groupNameKeyOnly: groupOnlyKey, favoriteContentStr: newInputText) {
                DispatchQueue.main.async {
                    ZKProgressHUD.showSuccess("Already saved to favorites")
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
    
    func editTextInputView(contentStr: String, isPro: Bool) {
        
        if !isPro || KIkbsPurchaseManager.default.inSubscription {
            self.textInputView.text = "\(textInputView.text ?? "") \(contentStr)"
        } else {
            
            self.present(KIkbsStoreVC(), animated: true, completion: nil)
        }
    }
}

extension KEkeyNeSpecialTextVC: JXPagingViewDelegate {
    
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
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .symbol)
            contentView.clickSpecialStrBlock = {
                [weak self] specialStr, isProBundle in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.editTextInputView(contentStr: specialStr, isPro: isProBundle)
                }
            }
            return contentView
        } else if index == 1 {
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .emojiStr)
            contentView.clickSpecialStrBlock = {
                [weak self] specialStr, isProBundle in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.editTextInputView(contentStr: specialStr, isPro: isProBundle)
                }
            }
            return contentView
        } else if index == 2 {
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .quote)
            contentView.clickSpecialStrBlock = {
                [weak self] specialStr, isProBundle in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.editTextInputView(contentStr: specialStr, isPro: isProBundle)
                }
            }
            return contentView
        } else if index == 3 {
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .shape)
            contentView.clickSpecialStrBlock = {
                [weak self] specialStr, isProBundle in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.editTextInputView(contentStr: "\n\(specialStr)", isPro: isProBundle)
                }
            }
            return contentView
        }
        
        return KIkbsTextTypeTransformView()
    }
    
    
}
//, JXSegmentedViewDataSource
extension KEkeyNeSpecialTextVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}



class DPTextView: UITextView {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        debugPrint(action)
        if action == #selector(copy(_:)) || action == #selector(cut(_:)) || action == #selector(selectAll(_:)) || action == #selector(select(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

