//
//  KEkeyNeTextCardVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/9.
//

import UIKit
import JXPagingView
import JXSegmentedView
import Photos
import DeviceKit

class KEkeyNeTextCardVC: UIViewController {

    
    var headerInSectionHeight: Int = 34
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = ["Background", "  Text  ", "Watermark"]
    
    // 颜色主题、对齐方式、随机文案、图片尺寸比例、保存按钮
    let bottomCanvasView = UIView()
    let contentScrollView = UIScrollView()
    let canvasBgView = UIView()
    let cardCanvasView = KIkbsCardCanvasTextView()
    
    let cardInputBar = KIkbsCardTextInputBar()
    let cardThemeBar = KIkbsCardThemeColorBar()
    let cardWatermarkBar = KIkbsCardWatermarkBar()
    let cardTextInputView = KIkbsCardTextInputView()
    
    var canvasSizeType: TextCardCanvasSize = .size1_1
    
    var waterOverlayer = KIkbsCardWatermarkOverlayer()
    let hideButton = UIButton()
//    var watermarkTextFeild = UITextField()
    let textinputView = UITextView()
    var watermarkTextFeildToolView: UIView!
    let topBar = UIView()
    
    let textinputBgView = UIView()
    let textinputContentView = UIView()
    let textinputDeleteFavoBtn = UIButton(type: .custom)
    let textinputSaveFavoBtn = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewSetup()
        setupCollection()
        setupCardTextInputView()
        setupDefaultStatus()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        if contentScrollView.contentSize.width == 0 {
            updateContentCanvasLayout(sizeType: .size1_1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func contentViewSetup() {
        view.backgroundColor(.black)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "D0BBFE")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        let titNameLabel = UILabel()
        titNameLabel.adhere(toSuperview: topBar)
            .text("Text Card")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        titNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let downloadBtn = UIButton(type: .custom)
        downloadBtn
            .adhere(toSuperview: topBar)
        downloadBtn.setImage(UIImage(named: "ic_download"), for: .normal)
        downloadBtn.snp.makeConstraints {
            $0.centerY.equalTo(titNameLabel.snp.centerY)
            $0.right.equalTo(-12)
            $0.width.height.equalTo(44)
        }
        downloadBtn.addTarget(self, action: #selector(downloadBtnClick(sender:)), for: .touchUpInside)
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(180)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
        
        //
        contentScrollView
            .backgroundColor(UIColor(hexString: "F2F2F7")!)
            .adhere(toSuperview: view)
        contentScrollView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.bottom.equalTo(bottomCanvasView.snp.top).offset(-4)
        }
        contentScrollView.layer.cornerRadius = 10
        contentScrollView.clipsToBounds = true
        //
        canvasBgView.layer.masksToBounds = true
        canvasBgView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: contentScrollView)
        
        //
        cardCanvasView
            .adhere(toSuperview: canvasBgView)
        cardCanvasView.snp.makeConstraints {
//            $0.left.right.top.bottom.equalTo(canvasBgView)
            $0.left.equalToSuperview().offset(2)
            $0.top.equalToSuperview().offset(2)
            $0.center.equalToSuperview()
        }
        cardCanvasView.cornerRadius(10)
        
        //
        waterOverlayer
            .adhere(toSuperview: canvasBgView)
        waterOverlayer.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(canvasBgView)
        }
        
        waterOverlayer.isUserInteractionEnabled = false
        waterOverlayer.isHidden = true
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
        
        pagingView.mainTableView.backgroundColor = .clear
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = .clear
    }

    func setupCardTextInputView() {
        cardTextInputView.alpha = 0
        view.addSubview(cardTextInputView)
        cardTextInputView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func setupDefaultStatus() {
        
        let textDefault = "Hello! Today is saturday, Enjoy your life"
        cardInputBar.updateCanvasSize(sizeType: .size1_1)
        cardInputBar.udpateTextContent(contentStr: textDefault)
        cardInputBar.updateTextAligment(aligment: .center)
        self.cardCanvasView.updateCanvasTextStr(text: textDefault)
        self.cardCanvasView.updateTextAlignment(alignment: .center)
        if let themeColor = KIkbsDataManager.default.textCardThemeColorList.first {
            self.cardCanvasView.updateCanvasThemeColor(themeColorItem: themeColor)
        }
    }
    
    func updateContentCanvasLayout(sizeType: TextCardCanvasSize) {
        
        canvasSizeType = sizeType
        var topPadding: CGFloat = 20
        let canvasWidth: CGFloat = UIScreen.width - topPadding * 2
        var canvasHeight: CGFloat = 300
        if sizeType == .size1_1 {
            canvasHeight = canvasWidth
        } else if sizeType == .size4_3 {
            canvasHeight = canvasWidth * (3/4)
        } else if sizeType == .size3_4 {
            canvasHeight = canvasWidth * (4/3)
        }
        
        let scrollContentHeight: CGFloat = canvasHeight + topPadding * 2
        contentScrollView.contentSize = CGSize(width: canvasWidth, height: scrollContentHeight)
        
        if contentScrollView.bounds.height > canvasHeight {
            topPadding = (contentScrollView.bounds.height - canvasHeight) / 2
        }
        canvasBgView
            .snp.remakeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(topPadding)
                $0.width.equalTo(canvasWidth)
                $0.height.equalTo(canvasHeight)
            }
    }
}


extension KEkeyNeTextCardVC {
    @objc func downloadBtnClick(sender: UIButton) {
         
        if let img = canvasBgView.screenshot {
            saveToAlbumPhotoAction(images: [img])
             
        }
    }
    
}

extension KEkeyNeTextCardVC {
    func saveToAlbumPhotoAction(images: [UIImage]) {
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                [weak self] in
                guard let `self` = self else {return}
                for img in images {
                    PHAssetChangeRequest.creationRequestForAsset(from: img)
                }
            }) { (finish, error) in
                if finish {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        self.showSaveSuccessAlert()
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if error != nil {
                            let auth = PHPhotoLibrary.authorizationStatus()
                            if auth != .authorized {
                                self.showDenideAlert()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func showSaveSuccessAlert() {
        HUD.success("Photo saved successful.")
    }
    
    func showDenideAlert() {
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                DispatchQueue.main.async {
                    let url = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(url, options: [:])
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
    }
    
}

extension KEkeyNeTextCardVC {
    func showcardInputBar() {
        // show coin alert
        UIView.animate(withDuration: 0.35) {
            self.cardTextInputView.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
            self.cardTextInputView.textInputTextView.becomeFirstResponder()
        }
        cardTextInputView.okBtnClickBlock = {
            [weak self] text in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                
                self.cardCanvasView.updateCanvasTextStr(text: text)
                self.cardInputBar.udpateTextContent(contentStr: text)
            }

            UIView.animate(withDuration: 0.25) {
                self.cardTextInputView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
        
        cardTextInputView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.cardTextInputView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
    }
}

extension KEkeyNeTextCardVC {
    func updateContentCanvasSize(sizeType: TextCardCanvasSize) {
        updateContentCanvasLayout(sizeType: sizeType)
    }
    
}

extension KEkeyNeTextCardVC {
    func updateWatermark(textStr: String?) {
        // update watermark preview content
        waterOverlayer.udpateWaterText(waterText: textStr)
    }
    func updateWatermakrContentType(typeIndex: Int) {
        if typeIndex == 0 {
            waterOverlayer.isHidden = true
        } else {
            waterOverlayer.isHidden = false
            waterOverlayer.udpateWaterType(waterType: typeIndex)
        }
    }
    
    func closeKeyboradAction(text: String?) {
        self.watermarkTextFeild.endEditing(true)
//        self.watermarkTextFeild.resignFirstResponder()
        self.cardWatermarkBar.updateEnterTextStr(textStr: text)
    }
    
    @objc func watermarkTextFeildHiddenBtnClick(sender: UIButton) {
        self.closeKeyboradAction(text: self.watermarkTextFeild.text)
    }
    
    func resetupTextFeild() {
        //
//        watermarkTextFeildToolView = UIView(frame: CGRect(x: 0, y: -100, width: UIScreen.width, height: 44))
//        watermarkTextFeildToolView.backgroundColor = .white
//        view.addSubview(watermarkTextFeildToolView)
//        //
//        hideButton
//            .addTarget(self, action: #selector(watermarkTextFeildHiddenBtnClick(sender:)), for: .touchUpInside)
//        hideButton.setImage(UIImage(named: "ic_keyboard_close"), for: .normal)
////        hideButton.setTitle("Okey", for: .normal)
//        hideButton.setTitleColor(UIColor.init(hexString: "#000000"), for: .normal)
//
//        watermarkTextFeildToolView.addSubview(hideButton)
//        hideButton.snp.makeConstraints {
//            $0.height.equalTo(40)
//            $0.width.greaterThanOrEqualTo(1)
//            $0.right.equalTo(-20)
//            $0.centerY.equalToSuperview()
//        }
//
//        //
//        watermarkTextFeildToolView.addSubview(watermarkTextFeild)
//        watermarkTextFeild.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.left.equalTo(30)
//            $0.height.equalTo(38)
//            $0.right.equalTo(-80)
//        }
//        watermarkTextFeild.inputAccessoryView =  watermarkTextFeildToolView
//        watermarkTextFeild.delegate = self
    }
    
    func setupTextInputContentView() {
        
        textinputBgView.isHidden = true
        textinputBgView.backgroundColor(UIColor.black.withAlphaComponent(0.5))
        textinputBgView
            .adhere(toSuperview: self.view)
        textinputBgView.snp.makeConstraints {
            $0.left.top.bottom.right.equalToSuperview()
        }
        //
        let textinputBgCloseBtn = UIButton(type: .custom)
        textinputBgCloseBtn
            .adhere(toSuperview: textinputBgView)
        textinputBgCloseBtn.addTarget(self, action: #selector(textinputBgCloseBtnClick(sender:)), for: .touchUpInside)
        textinputBgCloseBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        //
        textinputContentView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: textinputBgView)
        var textContentTop: CGFloat = 100
        
        if Device.current.diagonal == 4.7 {
            textContentTop = 30
        }
        textinputContentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textContentTop)
            $0.width.equalTo(270)
            $0.height.equalTo(330)
        }
        //
        let contentColorV = UIView()
        textinputContentView.addSubview(contentColorV)
        contentColorV.backgroundColor(UIColor(hexString: "F2F2F7")!)
        contentColorV.layer.cornerRadius = 10
        contentColorV.clipsToBounds(true)
        contentColorV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalTo(2)
            $0.left.equalTo(2)
        }
        //
        let textinputContentCloseBtn = UIButton()
        textinputContentCloseBtn.setImage(UIImage(named: "ic_pop_close"), for: .normal)
        textinputContentView.addSubview(textinputContentCloseBtn)
        textinputContentCloseBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.height.equalTo(36)
        }
        textinputContentCloseBtn.addTarget(self, action: #selector(textinputBgCloseBtnClick(sender:)), for: .touchUpInside)
        
        // tool view
        view.addSubview(watermarkTextFeildToolView)
        watermarkTextFeildToolView.backgroundColor = UIColor(hexString: "#FFFFFF")
        watermarkTextFeildToolView.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width, height: 40)
        
        // tool keyborder hiden view
        hideButton.setImage(UIImage(named: "ic_keyboard_close"), for: .normal)
//        hideButton.setTitle("Done", for: .normal)
        hideButton.setTitleColor(UIColor.systemBlue, for: .normal)
        hideButton.backgroundColor = UIColor.clear
        hideButton.addTarget(self, action: #selector(watermarkTextFeildHiddenBtnClick(sender:)), for: .touchUpInside)
        watermarkTextFeildToolView.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        //
        
        //
        textinputView.returnKeyType = .default
        textinputView.inputAccessoryView = watermarkTextFeildToolView
        textinputView.delegate = self
        textinputView.textColor = UIColor.darkGray
        textinputView.font = UIFont(name: "AvenirNext-Medium", size: 14)
        textinputView.placeholder = "Input content..."
        textinputView.adhere(toSuperview: textinputContentView)
        textinputView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(textinputContentCloseBtn.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-80)
        }
        textinputView.layer.borderColor = UIColor.black.cgColor
        textinputView.layer.borderWidth = 1.5
        //
 
        //
        textinputSaveFavoBtn.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        textinputSaveFavoBtn
            .title("OK")
            .titleColor(UIColor.black)
            .backgroundColor(UIColor(hexString: "FBDF40")!)
            .adhere(toSuperview: textinputContentView)
        textinputSaveFavoBtn.layer.borderWidth = 1.5
        textinputSaveFavoBtn.layer.shadowColor = UIColor.black.cgColor
        textinputSaveFavoBtn.layer.shadowRadius = 0
        textinputSaveFavoBtn.layer.shadowOffset = CGSize(width: -2, height: 2)
        textinputSaveFavoBtn.layer.shadowOpacity = 1
        textinputSaveFavoBtn.snp.makeConstraints {
            $0.centerY.equalTo(textinputDeleteFavoBtn.snp.centerY)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
            $0.left.equalTo(textinputDeleteFavoBtn.snp.right).offset(16)
        }
        textinputSaveFavoBtn.addTarget(self, action: #selector(textinputSaveFavoBtnClick(sender:)), for: .touchUpInside)
         
    }
    
}

extension KEkeyNeTextCardVC {
    @objc func textinputBgCloseBtnClick(sender: UIButton) {
        textinputBgView.isHidden = true
        hideButtonClick(sender: hideButton)
    }
}

extension KEkeyNeTextCardVC: JXPagingViewDelegate {

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
            
            cardInputBar.textinputBtnClickBlock = {
                [weak self] in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.showcardInputBar()
                }
            }
            cardInputBar.textRandomBtnClickBlock = {
                [weak self] in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    //TODO: random text
                    let randomText = KIkbsDataManager.default.randomQuoteStr()
                    self.cardCanvasView.updateCanvasTextStr(text: randomText)
                }
            }
            cardInputBar.alightmentBtnClickBlock = {
                [weak self] alignment in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.cardCanvasView.updateTextAlignment(alignment: alignment)
                }
            }
            cardInputBar.canvasSizeBtnClickBlock = {
                [weak self] canvasSize in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.updateContentCanvasSize(sizeType: canvasSize)
                }
            }
            return cardInputBar
        } else if index == 1 {
            
            cardThemeBar.selectCardThemeColorBlock = {
                [weak self] item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.cardCanvasView.updateCanvasThemeColor(themeColorItem: item)
                }
            }
            
            cardThemeBar.selectCardThemeOverlayerBlock = {
                [weak self] item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.cardCanvasView.updateCanvasOverlayerImg(overlayerItem: item)
                }
            }
            
            return cardThemeBar
        } else if index == 2 {
            
            cardWatermarkBar.enterWaterMarkClickBlock = {
                [weak self] in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.resetupTextFeild()
                    self.watermarkTextFeild.becomeFirstResponder()
                }
            }
            cardWatermarkBar.selectWaterMarkClickBlock = {
                [weak self] index, item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.updateWatermakrContentType(typeIndex: index)
                }
            }
            return cardWatermarkBar
        }
         
        return KIkbsMorseCodeTransformView()
    }
    
    
}
//, JXSegmentedViewDataSource
extension KEkeyNeTextCardVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}

extension KEkeyNeTextCardVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        debugPrint("textFieldDidEndEditing")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateWatermark(textStr: textField.text)
        
        debugPrint("did Changeing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        updateWatermark(textStr: textField.text)
        
        if string == "" {
            
        } else {
//            TaskDelay.default.taskDelay(afterTime: 0.8) {[weak self] in
//                guard let `self` = self else {return}
//            }
        }
        debugPrint("shouldChangeCharactersIn")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboradAction(text: textField.text)
         
        
        return true
    }
    
    
}



