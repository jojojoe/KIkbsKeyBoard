//
//  KEkeyNeFavoriteStringVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/8.
//

import UIKit
import JXPagingView
import JXSegmentedView
import ZWAlertController
import DeviceKit


class KEkeyNeFavoriteStringVC: UIViewController {

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
    
    let textinputContentView = UIView()
    let textinputDeleteFavoBtn = UIButton(type: .custom)
    let textinputSaveFavoBtn = UIButton(type: .custom)
    var currentEditingFavoriteItem: KeyboardFavoriteItem?
    var currentFavoritePageView: KIkbsKeyboardFavoritePageView?
    var currentSelectGroupPageIndex: Int = 0
    let topBar = UIView()
    var favoritePagesList: [String: KIkbsKeyboardFavoritePageView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        contentViewSetup()
        setupCollection()
        setupTextInputContentView()
        addnoti()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func addnoti() {
//
        NotificationCenter.default.addObserver(self, selector: #selector(notiUpdateFavoritePageList(notification: )), name: NSNotification.Name(rawValue: noti_favoriteFetch), object: nil)
    }
    
    @objc func notiUpdateFavoritePageList(notification: Notification) {
        guard let currentFavoritePageView_m = favoritePagesList["0"] else { return }
        DispatchQueue.main.async {
            currentFavoritePageView_m.loadData()
        }
    }
    
    func contentViewSetup() {
        view.backgroundColor(.black)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "F0D380")!)
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
        
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom).offset(4)
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
        segmentedView.contentEdgeInsetLeft = 55
        segmentedView.contentEdgeInsetRight = 95
        bottomCanvasView.addSubview(pagingView)
        segmentedView.listContainer = pagingView.listContainerView
        
        //
        pagingView.mainTableView.backgroundColor = UIColor(hexString: "#F2F2F7")
        pagingView.mainTableView.alwaysBounceVertical = false
        pagingView.mainTableView.bounces = false
        pagingView.listContainerView.listCellBackgroundColor = .clear
        
        //
        let addNewGroupNameBtn = UIButton(type: .custom)
        addNewGroupNameBtn
            .image(UIImage(named: "ic_add"))
            .adhere(toSuperview: bottomCanvasView)
        addNewGroupNameBtn
            .snp.makeConstraints {
                $0.right.top.equalTo(bottomCanvasView)
                $0.height.equalTo(headerInSectionHeight)
                $0.width.equalTo(80)
            }
        addNewGroupNameBtn.addTarget(self, action: #selector(addNewGroupNameBtnClick(sender:)), for: .touchUpInside)
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
        view.addSubview(toolView)
//        toolView.layer.borderWidth = 1.5
//        toolView.layer.borderColor = UIColor.black.cgColor
        toolView.backgroundColor = UIColor(hexString: "#FFFFFF")
        toolView.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width, height: 40)
        
        // tool keyborder hiden view
        hideButton.setImage(UIImage(named: "ic_keyboard_close"), for: .normal)
//        hideButton.setTitle("Done", for: .normal)
        hideButton.setTitleColor(UIColor.systemBlue, for: .normal)
        hideButton.backgroundColor = UIColor.clear
        hideButton.addTarget(self, action: #selector(hideButtonClick(sender:)), for: .touchUpInside)
        toolView.addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        //
        
        //
        textinputView.returnKeyType = .default
        textinputView.inputAccessoryView = toolView
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

        textinputDeleteFavoBtn
            .image(UIImage(named: "ic_delete"))
            .backgroundColor(UIColor(hexString: "FB3030")!)
            .adhere(toSuperview: textinputContentView)
        textinputDeleteFavoBtn.layer.borderWidth = 1.5
        textinputDeleteFavoBtn.layer.shadowColor = UIColor.black.cgColor
        textinputDeleteFavoBtn.layer.shadowRadius = 0
        textinputDeleteFavoBtn.layer.shadowOffset = CGSize(width: -2, height: 2)
        textinputDeleteFavoBtn.layer.shadowOpacity = 1
        textinputDeleteFavoBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        textinputDeleteFavoBtn.addTarget(self, action: #selector(textinputDeleteFavoBtnClick(sender:)), for: .touchUpInside)
        //
        textinputSaveFavoBtn.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        textinputSaveFavoBtn
            .title("Save")
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

extension KEkeyNeFavoriteStringVC {
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
                
                //
                let favoriteDict: [[String: String]] = self.titleGroupList.compactMap({
                    return ["groupName": $0.groupName, "keyOnly": $0.keyOnly]
                })
                KIkbsKeboardFavoriteDB.default.updateGroupFavoriteTitlesList(titles: favoriteDict)
            }
        }
        //
        titles = titleGroupList.compactMap({
            return $0.groupName
        })
        
    }
}

extension KEkeyNeFavoriteStringVC {
    @objc func addNewGroupNameBtnClick(sender: UIButton) {
        let title = "Enter a group name"
        let message = ""
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
                    HUD.message(string: "Sorry, The name entered is invalid, please re-enter it")
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
        textinputBgView.isHidden = true
        hideButtonClick(sender: hideButton)
    }
    
    @objc func textinputDeleteFavoBtnClick(sender: UIButton) {
        guard let currentFavoritePageView_m = currentFavoritePageView else { return }
        
        if let currentEditingFavoriteItem_m = currentEditingFavoriteItem {
            KIkbsKeboardFavoriteDB.default.deleteKeyFavoriteContent(favoriteItem: currentEditingFavoriteItem_m) {
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
            textinputBgView.isHidden = true
            hideButtonClick(sender: hideButton)
        }
        
    }
    
    @objc func textinputSaveFavoBtnClick(sender: UIButton) {
        guard let currentFavoritePageView_m = currentFavoritePageView else { return }
        
        let newInputText: String = textinputView.text
        if newInputText == "" {
            HUD.message(string: "Sorry, The name entered is invalid, please re-enter it")
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
        
        textinputBgView.isHidden = true
        hideButtonClick(sender: hideButton)
        
    }
    
    @objc func hideButtonClick(sender: UIButton) {
//        textinputBgView.isHidden = true
        textinputView.resignFirstResponder()
    }

}

extension KEkeyNeFavoriteStringVC {
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
            textinputSaveFavoBtn.snp.remakeConstraints {
                $0.centerY.equalTo(textinputDeleteFavoBtn.snp.centerY)
                $0.right.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.left.equalTo(textinputDeleteFavoBtn.snp.right).offset(16)
            }
        } else {
            textinputDeleteFavoBtn.isHidden = true
            textinputSaveFavoBtn.snp.remakeConstraints {
                $0.centerY.equalTo(textinputDeleteFavoBtn.snp.centerY)
                $0.right.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.left.equalToSuperview().offset(16)
            }
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

extension KEkeyNeFavoriteStringVC: JXPagingViewDelegate {

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
        
        
        if let page = favoritePagesList["\(index)"] {
            return page
        } else {
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
            favoritePagesList["\(index)"] = contentView
            return contentView
        }
        
        
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        
    }
    
}
//, JXSegmentedViewDataSource
extension KEkeyNeFavoriteStringVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        debugPrint("did select group = \(index)")
        currentSelectGroupPageIndex = index
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        debugPrint("scroll select group = \(index)")
        currentSelectGroupPageIndex = index
    }
}

extension KEkeyNeFavoriteStringVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}




