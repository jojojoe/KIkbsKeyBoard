//
//  KIkbsSpecialTextLibVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/24.
//

import UIKit
import JXPagingView
import JXSegmentedView


/*
 Shape  分栏  1图案动物植物的 2房地产销售固定搭配格式的 3天气样式的下雪下雨刮风
 */
class KIkbsSpecialTextLibVC: UIViewController, UITextViewDelegate {

    var headerInSectionHeight: Int = 50
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = ["- symbol -", "- quote -", "- emojiStr -", "- shape -"]
    let bottomCanvasView = UIView()
    let textInputView = DPTextView()
    var toolView = UIView()
    var hideButton = UIButton()
    var copyTextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollection()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func setupView() {
        
        let topBanner = UIView()
        topBanner
            .backgroundColor(.darkGray)
            .adhere(toSuperview: view)
        topBanner.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        //
        let topTitleLabel = UILabel()
        topTitleLabel
            .fontName(15, Font_AvenirNext_Medium)
            .color(UIColor.white)
            .text("Special Text")
            .textAlignment(.center)
            .adhere(toSuperview: view)
        topTitleLabel
            .snp.makeConstraints {
                $0.bottom.equalTo(topBanner.snp.bottom)
                $0.height.equalTo(44)
                $0.centerX.equalToSuperview()
                $0.width.greaterThanOrEqualTo(1)
            }
        
        //
        let contentBgView = UIView()
        contentBgView
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: view)
        contentBgView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(topBanner.snp.bottom)
        }
        
        // tool view
        view.addSubview(toolView)
        toolView.backgroundColor = UIColor(hexString: "#AFAFAF")
        toolView.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width, height: 40)
        
        // tool keyborder hiden view
        hideButton.setImage(UIImage(named: ""), for: .normal)
        hideButton.setTitle("Done", for: .normal)
        hideButton.setTitleColor(UIColor.systemBlue, for: .normal)
        hideButton.backgroundColor = UIColor.init(hexString: "#1D1D1D")
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
            .adhere(toSuperview: contentBgView)
        textInputView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(30)
            $0.top.equalTo(contentBgView).offset(10)
            $0.height.equalTo(160)
        }
        //
        copyTextButton
            .image(UIImage(named: "Copy"))
            .backgroundColor(UIColor.orange)
            .adhere(toSuperview: contentBgView)
        copyTextButton.snp.makeConstraints {
            $0.bottom.right.equalTo(textInputView)
            $0.width.height.equalTo(44)
        }
        copyTextButton.addTarget(self, action: #selector(copyTextButtonClick(button:)), for: .touchUpInside)
         
        //
        bottomCanvasView
            .backgroundColor(UIColor.darkGray)
            .adhere(toSuperview: contentBgView)
        bottomCanvasView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(textInputView.snp.bottom).offset(10)
        }
    }
     
    func setupCollection() {
        dataSource.titles = titles
        
        dataSource.titleNormalColor = UIColor.white.withAlphaComponent(0.4)
        dataSource.titleSelectedColor = UIColor.white.withAlphaComponent(0.8)
        dataSource.titleNormalFont = UIFont(name: Font_AvenirNext_Medium, size: 14) ?? UIFont.systemFont(ofSize: 14)
        dataSource.titleSelectedFont = UIFont(name: Font_AvenirNext_Medium, size: 14)
        dataSource.itemWidthSelectedZoomScale = 0
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = false

        segmentedView.backgroundColor = UIColor.clear
        segmentedView.delegate = self
        segmentedView.dataSource = dataSource
        
        bottomCanvasView.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
        
        pagingView.mainTableView.backgroundColor = .clear
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = .clear
    }
    

}

extension KIkbsSpecialTextLibVC {
    @objc func hideButtonClick(button: UIButton) {
        self.textInputView.resignFirstResponder()
    }
    
    @objc func copyTextButtonClick(button: UIButton) {
        self.textInputView.resignFirstResponder()
    }
    
    func editTextInputView(contentStr: String, isPro: Bool) {
        
        if !isPro || KIkbsPurchaseManager.default.inSubscription {
            self.textInputView.text = "\(textInputView.text ?? "") \(contentStr)"
        } else {
            
            self.present(KIkbsStoreVC(), animated: true, completion: nil)
        }
        
    }
}

extension KIkbsSpecialTextLibVC: JXPagingViewDelegate {

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
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .quote)
            contentView.clickSpecialStrBlock = {
                [weak self] specialStr, isProBundle in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.editTextInputView(contentStr: specialStr, isPro: isProBundle)
                }
            }
            return contentView
        } else if index == 2 {
            let contentView = KIkbsSpecialStrPreviewView(frame: .zero, specialStrType: .emojiStr)
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
extension KIkbsSpecialTextLibVC: JXSegmentedViewDelegate {
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

