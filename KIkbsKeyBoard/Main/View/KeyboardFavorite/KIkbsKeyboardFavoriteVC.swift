//
//  KIkbsKeyboardFavoriteVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/27.
//

import UIKit
import JXPagingView
import JXSegmentedView
import ZWAlertController
import DeviceKit


class KIkbsKeyboardFavoriteVC: UIViewController {

    var headerInSectionHeight: Int = 50
    lazy var pagingView: JXPagingView = JXPagingView(delegate: self)
    lazy var segmentedView: JXSegmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(headerInSectionHeight)))
    var dataSource = JXSegmentedTitleDataSource()
    var titles = [""]
    let bottomCanvasView = UIView()
    let textinputView = UITextView()
    var titleGroupList: [KeyboardFavoriteGroup] = []
    var toolView = UIView()
    var hideButton = UIButton()
    let textinputBgView = UIView()
    let textinputBgCloseBtn = UIButton(type: .custom)
    let textinputContentView = UIView()
    let textinputDeleteFavoBtn = UIButton(type: .custom)
    let textinputSaveFavoBtn = UIButton(type: .custom)
    var currentEditingFavoriteItem: KeyboardFavoriteItem?
    var currentFavoritePageView: KIkbsKeyboardFavoritePageView?
    var currentSelectGroupPageIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
        setupCollection()
        setupTextInputContentView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
    }
}

extension KIkbsKeyboardFavoriteVC {
    func loadData(_ isAddNew: Bool = false) {
        let groupFavorite = KeyboardFavoriteGroup(keyOnly: "00001", groupName: "Favorite")
        
        titleGroupList = [groupFavorite]
        KIkbsKeboardFavoriteDB.default.selectKeyFavoriteGroupNameList {[weak self] groupList in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.titleGroupList.append(contentsOf: groupList)
                self.titles = self.titleGroupList.compactMap({
                    return $0.groupName
                })
                self.dataSource.titles = self.titles
                self.pagingView.reloadData()
                self.segmentedView.reloadData()
                self.dataSource.reloadData(selectedIndex: self.currentSelectGroupPageIndex)
                if isAddNew {
                    self.currentSelectGroupPageIndex = self.titles.count - 1
                } else {
                    
                }
                
                self.segmentedView.selectItemAt(index: self.currentSelectGroupPageIndex)
                self.pagingView.listContainerView.didClickSelectedItem(at: self.currentSelectGroupPageIndex)
                self.pagingView.reloadData()
                self.segmentedView.reloadData()
                self.dataSource.reloadData(selectedIndex: self.currentSelectGroupPageIndex)
            }
        }
        //
        titles = titleGroupList.compactMap({
            return $0.groupName
        })
        
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
            .text("Keyboard Favorite")
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
        bottomCanvasView
            .backgroundColor(UIColor.darkGray)
            .adhere(toSuperview: contentBgView)
        bottomCanvasView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(contentBgView)
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
        segmentedView.contentEdgeInsetLeft = 55
        segmentedView.contentEdgeInsetRight = 55
        bottomCanvasView.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
         
        //
//        pagingView.pinSectionHeaderVerticalOffset = -22
        pagingView.mainTableView.backgroundColor = .clear
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = .clear
        
        //
        let addNewGroupNameBtn = UIButton(type: .custom)
        addNewGroupNameBtn
            .title("Add")
            .image(UIImage(named: ""))
            .backgroundColor(.darkGray)
            .adhere(toSuperview: bottomCanvasView)
        addNewGroupNameBtn
            .snp.makeConstraints {
                $0.right.top.equalTo(bottomCanvasView)
                $0.height.equalTo(headerInSectionHeight)
                $0.width.equalTo(40)
            }
        addNewGroupNameBtn.addTarget(self, action: #selector(addNewGroupNameBtnClick(sender:)), for: .touchUpInside)
    }
    
    func setupTextInputContentView() {
        
        textinputBgView.isHidden = true
        textinputBgView.backgroundColor(UIColor.black.withAlphaComponent(0.7))
        textinputBgView
            .adhere(toSuperview: view)
        textinputBgView.snp.makeConstraints {
            $0.left.top.bottom.right.equalToSuperview()
        }
        //

        textinputBgCloseBtn
            .adhere(toSuperview: textinputBgView)
        textinputBgCloseBtn.addTarget(self, action: #selector(textinputBgCloseBtnClick(sender:)), for: .touchUpInside)
        textinputBgCloseBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //

        textinputContentView
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: textinputBgView)
        textinputContentView.layer.cornerRadius = 16
        var textContentTop: CGFloat = 100
        
        if Device.current.diagonal == 4.7 {
            textContentTop = 30
        }
        textinputContentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textContentTop)
            $0.width.equalTo(300)
            $0.height.equalTo(300)
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
        hideButton.addTarget(self, action: #selector(hideButtonClick(sender:)), for: .touchUpInside)
        toolView.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        
        //
        textinputView.returnKeyType = .default
        textinputView.inputAccessoryView = toolView
        textinputView.delegate = self
        textinputView.textColor = UIColor.darkGray
        textinputView.font = UIFont(name: "AvenirNext-Medium", size: 13)
        textinputView.placeholder = "Input content..."
        textinputView.adhere(toSuperview: textinputContentView)
        textinputView.snp.makeConstraints {
            $0.left.equalTo(24)
            $0.top.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-80)
        }
        //

        textinputDeleteFavoBtn
            .title("Delete")
            .titleColor(UIColor.red)
            .adhere(toSuperview: textinputContentView)
        textinputDeleteFavoBtn.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
        textinputDeleteFavoBtn.addTarget(self, action: #selector(textinputDeleteFavoBtnClick(sender:)), for: .touchUpInside)
        //

        textinputSaveFavoBtn
            .title("Save")
            .titleColor(UIColor.red)
            .adhere(toSuperview: textinputContentView)
        textinputSaveFavoBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        textinputSaveFavoBtn.addTarget(self, action: #selector(textinputSaveFavoBtnClick(sender:)), for: .touchUpInside)
        //
        let textinputSaveFavoBtnTopLine = UIView()
        textinputSaveFavoBtnTopLine.backgroundColor(UIColor.lightGray)
        textinputSaveFavoBtnTopLine.adhere(toSuperview: textinputContentView)
        textinputSaveFavoBtnTopLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(textinputSaveFavoBtn.snp.top)
            $0.height.equalTo(1)
        }
        //
    }
    @objc func addNewGroupNameBtnClick(sender: UIButton) {
        
        let title = "Text Entry Alert"
        let message = "A message should be a short, complete sentence."
        let cancelButtonTitle = "Cancel"
        let otherButtonTitle = "OK"
        
        let alertController = ZWAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.textLimit = 30
        alertController.addTextFieldWithConfigurationHandler { textField in
            
        }
        // Create the actions.
        let cancelAction = ZWAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            debugPrint("The \"Text Entry\" alert's cancel action occured.")
            
        }
        let otherAction = ZWAlertAction(title: otherButtonTitle, style: .default) { action in
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                if let field = alertController.textFields?.first as? UITextField, let fieldText = field.text,  fieldText != "" {
                    self.saveKeyboardGroupName(groupName: fieldText) {
                        [weak self] in
                        guard let `self` = self else {return}
                        DispatchQueue.main.async {
//                            if self.currentSelectGroupPageIndex == self.titles.count - 1 {
//                                self.currentSelectGroupPageIndex = 0
//                            } else {
//
//                            }
                            self.loadData(true)
                        }
                    }
                } else {
                    HUD.message(string: "Sorry 输入名称无效，请重新输入")
                }
            }
        }
        
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if let field = alertController.textFields?.first as? UITextField {
                field.becomeFirstResponder()
                field.addPaddingLeft(10)
            }
        }
    }
    
    
    @objc func textinputBgCloseBtnClick(sender: UIButton) {
        hideButtonClick(sender: hideButton)
    }
    
    @objc func textinputDeleteFavoBtnClick(sender: UIButton) {
        guard let currentFavoritePageView_m = currentFavoritePageView else { return }
        
        if let currentEditingFavoriteItem_m = currentEditingFavoriteItem {
            KIkbsKeboardFavoriteDB.default.deleteKeyFavoriteContent(favoriteKeyOnly: currentEditingFavoriteItem_m.keyOnly) {
                [weak self] in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    currentFavoritePageView_m.loadData()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        if self.currentSelectGroupPageIndex == 0 {
                            return
                        }
                        if currentFavoritePageView_m.list.count == 0 {
                            self.showDeleteGroupAlert(groupNameKeyOnly: currentEditingFavoriteItem_m.groupNameKeyOnly)
                        }
                    }
                }
            }
            hideButtonClick(sender: hideButton)
        }
        
    }
    
    @objc func textinputSaveFavoBtnClick(sender: UIButton) {
        guard let currentFavoritePageView_m = currentFavoritePageView else { return }
        
        let newInputText: String = textinputView.text
       
        if newInputText == "" {
            HUD.message(string: "输入的内容无效 请重新输入")
            return
        }
        
        if let currentEditingFavoriteItem_m = currentEditingFavoriteItem {
            // 更新
            
            KIkbsKeboardFavoriteDB.default.addKeyFavoriteContent(favoriteKeyOnly: currentEditingFavoriteItem_m.keyOnly, groupNameKeyOnly: currentEditingFavoriteItem_m.groupNameKeyOnly, favoriteContentStr: newInputText) {
                DispatchQueue.main.async {
                    currentFavoritePageView_m.loadData()
                }
            }
             
        } else {
            // 添加新的
            let keyOnly = Date().timeIntervalSince1970.string
            let groupOnlyKey = currentFavoritePageView_m.favoriteGroupKeyOnly
            KIkbsKeboardFavoriteDB.default.addKeyFavoriteContent(favoriteKeyOnly: keyOnly, groupNameKeyOnly: groupOnlyKey, favoriteContentStr: newInputText) {
                DispatchQueue.main.async {
                    currentFavoritePageView_m.loadData()
                }
            }
        }
        
        hideButtonClick(sender: hideButton)
        
    }
    
    @objc func hideButtonClick(sender: UIButton) {
        textinputBgView.isHidden = true
        textinputView.resignFirstResponder()
    }
    
}

extension KIkbsKeyboardFavoriteVC {
    func saveKeyboardGroupName(groupName: String, completionBlock: (()->Void)?) {
        KIkbsKeboardFavoriteDB.default.addFavoriteGroup(groupName: groupName) {
            completionBlock?()
        }
    }
    
    func showTextFavoriteContentInputView(oldContent: KeyboardFavoriteItem?, favoritePageView: KIkbsKeyboardFavoritePageView?) {
        
        currentFavoritePageView = favoritePageView
        currentEditingFavoriteItem = oldContent
        if let oldContent_m = oldContent {
            textinputDeleteFavoBtn.isHidden = false
        } else {
            textinputDeleteFavoBtn.isHidden = true
        }
        
        self.textinputBgView.isHidden = false
        self.textinputView.becomeFirstResponder()
        
    }
    
    func showDeleteGroupAlert(groupNameKeyOnly: String) {
        let title = "Do you want to delete this group?"
        let message = ""
        let cancelButtonTitle = "Cancel"
        let otherButtonTitle = "OK"
        
        let alertController = ZWAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.textLimit = 30
        
        // Create the actions.
        let cancelAction = ZWAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            debugPrint("The \"Text Entry\" alert's cancel action occured.")
            
        }
        let otherAction = ZWAlertAction(title: otherButtonTitle, style: .default) { action in
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
                
                KIkbsKeboardFavoriteDB.default.deleteFavoriteGroup(groupNameKeyOnly: groupNameKeyOnly) {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if self.currentSelectGroupPageIndex == self.titles.count - 1 {
                            self.currentSelectGroupPageIndex = 0
                        } else {

                        }
                        
                        self.loadData(false)
                    }
                }
            }
        }
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension KIkbsKeyboardFavoriteVC: JXPagingViewDelegate {

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
        
        let group = titleGroupList[index]
        
        let contentView = KIkbsKeyboardFavoritePageView(frame: .zero, favoriteGroupKeyOnly: group.keyOnly)
        contentView.selectFavoriteItemBlock = {
            [weak self] keyboardFavoriteItem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.textinputView.text = keyboardFavoriteItem.contentStr
                self.showTextFavoriteContentInputView(oldContent: keyboardFavoriteItem, favoritePageView: contentView)
            }
        }
        contentView.addNewKeyboardFavoriteContentBlock = {
            [weak self] groupKeyOnly in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.textinputView.text = ""
                self.showTextFavoriteContentInputView(oldContent: nil, favoritePageView: contentView)
                
            }
        }
        
        return contentView
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        
    }
    
}
//, JXSegmentedViewDataSource
extension KIkbsKeyboardFavoriteVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        debugPrint("did select group = \(index)")
        currentSelectGroupPageIndex = index
        
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        debugPrint("scroll select group = \(index)")
        currentSelectGroupPageIndex = index
    }
}



extension KIkbsKeyboardFavoriteVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
////            textView.resignFirstResponder()
//            if let contentText = textView.text {
//
//            }
//            return false
//        }
        
        return true
    }
    
}




