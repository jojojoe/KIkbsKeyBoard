//
//  KIkbsTextTransformVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/18.
//

import UIKit
import JXPagingView
import JXSegmentedView

class KIkbsTextTransformVC: UIViewController, UITextViewDelegate {

    var headerInSectionHeight: Int = 50
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = ["- 1 -", "- 2 -", "- 3 -"]
    let bottomCanvasView = UIView()
    
    var toolView = UIView()
    var hideButton = UIButton()
    let textInputView = UITextView()
    let resultTextView = DPTextView()
    
    var currentTransformItem: TextTranformItem? = KIkbsTextTransformManager.default.textTranformFontList.first
    
    
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
    

}

extension KIkbsTextTransformVC {
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
            .text("Text Transform")
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
        //
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
        textInputView.text = ""
        textInputView.delegate = self
        textInputView.inputAccessoryView = toolView
        textInputView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 40)
        textInputView
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: contentBgView)
        textInputView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(30)
            $0.top.equalTo(contentBgView).offset(10)
            $0.height.equalTo(100)
        }
        
        //

        resultTextView.font = UIFont(name: Font_AvenirNext_Medium, size: 16)
        resultTextView.textColor = UIColor.darkText
        resultTextView.isEditable = false
        resultTextView.text = ""
        resultTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 40)
        resultTextView
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: contentBgView)
        resultTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(30)
            $0.top.equalTo(textInputView.snp.bottom).offset(20)
            $0.height.equalTo(100)
        }
        
        //
        bottomCanvasView
            .backgroundColor(UIColor.darkGray)
            .adhere(toSuperview: contentBgView)
        bottomCanvasView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(resultTextView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
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

extension KIkbsTextTransformVC {
    func updateResultTextViewContent() {
        if let item = currentTransformItem {
            let resultString = KIkbsTextTransformManager.default.processReplaceText(contentStr: textInputView.text, transformItem: item)
            resultTextView.text = resultString
        }
    }
}

extension KIkbsTextTransformVC {
    @objc func hideButtonClick(button: UIButton) {
        textInputView.resignFirstResponder()
        //
//        updateResultTextViewContent()
        
        
    }
}

extension KIkbsTextTransformVC {
    func textViewDidChangeSelection(_ textView: UITextView) {
        updateResultTextViewContent()
    }
}

extension JXPagingListContainerView: JXSegmentedViewListContainer {}






extension KIkbsTextTransformVC: JXPagingViewDelegate {

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
            let contentView = KIkbsTextTypeTransformView()
            contentView.itemClickBlock = {
                [weak self] item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.currentTransformItem = item
                    self.updateResultTextViewContent()
                }
            }
            return contentView
        } else if index == 1 {
            let contentView = KIkbsTextCenterTransformView()
            contentView.itemClickBlock = {
                [weak self] item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.currentTransformItem = item
                    self.updateResultTextViewContent()
                }
            }
            return contentView
        } else if index == 2 {
            let contentView = KIkbsTextLeftRightTransformView()
            contentView.itemClickBlock = {
                [weak self] item in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    self.currentTransformItem = item
                    self.updateResultTextViewContent()
                }
            }
            return contentView
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
extension KIkbsTextTransformVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
    
    
}



/*
 func processReplaceText(contentStr: String, targetType: ALBymTextFontStyle) -> String {
     var resultStr = ""
     
     contentStr.charactersArray.forEach {[weak self] item in
         
         guard let `self` = self else {return}
         if targetType == .regular {
             if self.bold_low.charactersArray.contains(item) {
                 if let index = self.bold_low.charactersArray.firstIndex(of: item) {
                     let char = self.regular_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.bold_up.charactersArray.contains(item) {
                 if let index = self.bold_up.charactersArray.firstIndex(of: item) {
                     let char = self.regular_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.italic_low.charactersArray.contains(item) {
                 if let index = self.italic_low.charactersArray.firstIndex(of: item) {
                     let char = self.regular_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.italic_up.charactersArray.contains(item) {
                 if let index = self.italic_up.charactersArray.firstIndex(of: item) {
                     let char = self.regular_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else {
                 resultStr.append(item)
             }
         } else if targetType == .bold {
             if self.regular_low.charactersArray.contains(item) {
                 if let index = self.regular_low.charactersArray.firstIndex(of: item) {
                     let char = self.bold_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.regular_up.charactersArray.contains(item) {
                 if let index = self.regular_up.charactersArray.firstIndex(of: item) {
                     let char = self.bold_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.italic_low.charactersArray.contains(item) {
                 if let index = self.italic_low.charactersArray.firstIndex(of: item) {
                     let char = self.bold_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.italic_up.charactersArray.contains(item) {
                 if let index = self.italic_up.charactersArray.firstIndex(of: item) {
                     let char = self.bold_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else {
                 resultStr.append(item)
             }
         } else if targetType == .italic {
             if self.regular_low.charactersArray.contains(item) {
                 if let index = self.regular_low.charactersArray.firstIndex(of: item) {
                     let char = self.italic_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.regular_up.charactersArray.contains(item) {
                 if let index = self.regular_up.charactersArray.firstIndex(of: item) {
                     let char = self.italic_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.bold_low.charactersArray.contains(item) {
                 if let index = self.bold_low.charactersArray.firstIndex(of: item) {
                     let char = self.italic_low.charactersArray[index]
                     resultStr.append(char)
                 }
             } else if self.bold_up.charactersArray.contains(item) {
                 if let index = self.bold_up.charactersArray.firstIndex(of: item) {
                     let char = self.italic_up.charactersArray[index]
                     resultStr.append(char)
                 }
             } else {
                 resultStr.append(item)
             }
         }
         
     }
     debugPrint("resultStr = \(resultStr)")
     return resultStr
 }
 */



/*
 let regular_low = "abcdefghijklmnopqrstuvwxyz"
 let regular_up = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 let bold_low = "𝗮𝗯𝗰𝗱𝗲𝗳𝗴𝗵𝗶𝗷𝗸𝗹𝗺𝗻𝗼𝗽𝗾𝗿𝘀𝘁𝘂𝘃𝘄𝘅𝘆𝘇"
 let bold_up = "𝗔𝗕𝗖𝗗𝗘𝗙𝗚𝗛𝗜𝗝𝗞𝗟𝗠𝗡𝗢𝗣𝗤𝗥𝗦𝗧𝗨𝗩𝗪𝗫𝗬𝗭"
 let italic_low = "𝒶𝒷𝒸𝒹𝑒𝒻𝑔𝒽𝒾𝒿𝓀𝓁𝓂𝓃𝑜𝓅𝓆𝓇𝓈𝓉𝓊𝓋𝓌𝓍𝓎𝓏"
 let italic_up = "𝒜𝐵𝒞𝒟𝐸𝐹𝒢𝐻𝐼𝒥𝒦𝐿𝑀𝒩𝒪𝒫𝒬𝑅𝒮𝒯𝒰𝒱𝒲𝒳𝒴𝒵"
 */

