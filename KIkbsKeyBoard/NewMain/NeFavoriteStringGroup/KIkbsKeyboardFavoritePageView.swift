//
//  KIkbsKeyboardFavoritePageView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/27.
//

import UIKit
import JXPagingView


class KIkbsKeyboardFavoritePageView: UIView {

    //
    /*
     上方 最右边有一个添加分栏的按钮
     点击以后 增加一个分栏
     下面Page页面 跟上方栏联动
     下面Page页面 有一个添加文字框按钮 浮动在右下角
     下面Page页面 文字框可以左划动 有编辑和删除按钮
     当最后一个 文字框被删除掉以后 会弹出一个框 提示用户是否删除这一分栏
     这一分栏 会出现在键盘上
     */
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    let favoriteTableView = UITableView(frame: .zero, style: .plain)
    
    var favoriteGroupKeyOnly: String
    var list: [KeyboardFavoriteItem] = []
    var selectFavoriteItemBlock: ((KeyboardFavoriteItem)->Void)?
    var addNewKeyboardFavoriteContentBlock: ((String)->Void)?
    let nodataLable = UILabel()
    
    
    init(frame: CGRect, favoriteGroupKeyOnly: String) {
        self.favoriteGroupKeyOnly = favoriteGroupKeyOnly
        super.init(frame: frame)
        
        setupView()
        setupNodataAlertView()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension KIkbsKeyboardFavoritePageView {
    func loadData() {
        // load from db
//        let item1 = KeyboardFavoriteItem(groupName: "group1", keyOnly: "1", contentStr: "Going to bed early. Not going to a party. Not leaving my house. My childhood punishments has become my adult goals.")
//        let item2 = KeyboardFavoriteItem(groupName: "group1", keyOnly: "2", contentStr: "Going to bed early. Not going to a party. Not leaving my house. My childhood punishments has become my adult goals.")
//        let item3 = KeyboardFavoriteItem(groupName: "group1", keyOnly: "3", contentStr: "Going to bed early. Not going to a party. Not leaving my house. My childhood punishments has become my adult goals.")
//        let item4 = KeyboardFavoriteItem(groupName: "group1", keyOnly: "4", contentStr: "Going to bed early. Not going to a party. Not leaving my house. My childhood punishments has become my adult goals.")
//        list = [item1, item2, item3, item4]
        
        
        list = []
        
        KIkbsKeboardFavoriteDB.default.selectFavoriteContentList(groupNameKeyOnly: favoriteGroupKeyOnly) {[weak self] contentList in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.list = contentList
                self.favoriteTableView.reloadData()
                self.checkListCountStatus()
            }
        }
    }
    
    func checkListCountStatus() {
        if self.list.count == 0 {
            favoriteTableView.isHidden = true
            nodataLable.isHidden = false
        } else {
            favoriteTableView.isHidden = false
            nodataLable.isHidden = true
        }
    }
    
    func setupView() {
        favoriteTableView.separatorStyle = .none
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.indicatorStyle = .black
        favoriteTableView.backgroundColor = UIColor(hexString: "F2F2F7")!
        addSubview(favoriteTableView)
        favoriteTableView.snp.makeConstraints {
            $0.left.top.bottom.right.equalToSuperview()
        }
        favoriteTableView.register(cellWithClass: KIkbsKeyboardFavoriteTabCell.self)
        
        //
        let addNewItemBtn = UIButton(type: .custom)
        addNewItemBtn
            .backgroundColor(UIColor.white)
            .adhere(toSuperview: self)
            .setImage(UIImage(named: "ic_notepad_add"), for: .normal)
        addNewItemBtn
            .snp.makeConstraints {
                $0.right.equalTo(-20)
                $0.bottom.equalTo(snp.bottom).offset(-30)
                $0.width.height.equalTo(50)
            }
        addNewItemBtn.addTarget(self, action: #selector(addNewItemBtnClick(sender:)), for: .touchUpInside)
    }
    
    func setupNodataAlertView() {
        
        nodataLable
            .fontName(15, "Futura-CondensedExtraBold")
            .color(UIColor.black)
            .text("No data please click 'add' btn to add favorite content to show keyboard")
            .textAlignment(.center)
            .numberOfLines(0)
            .adhere(toSuperview: self)
        nodataLable.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(80)
            $0.width.equalTo(280)
            $0.height.greaterThanOrEqualTo(50)
        }
        
    }
    
    @objc func addNewItemBtnClick(sender: UIButton) {
        addNewKeyboardFavoriteContentBlock?(favoriteGroupKeyOnly)
    }
    
}

extension KIkbsKeyboardFavoritePageView: JXPagingViewListViewDelegate {
    
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.favoriteTableView
    }
}

extension KIkbsKeyboardFavoritePageView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: KIkbsKeyboardFavoriteTabCell.self, for: indexPath)
        let item = list[indexPath.item]
        cell.contentLabel.text = item.contentStr
        cell.contentCopyBtnBlock = {
            [weak self] contentStrs in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                UIPasteboard.general.string = contentStrs
                HUD.success("Copy successfully!")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.item]
        selectFavoriteItemBlock?(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        let height: CGFloat = 80
        return height
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


extension KIkbsKeyboardFavoritePageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
}


class KIkbsKeyboardFavoriteTabCell: UITableViewCell {
    
    var clickSpecialContentBlock: ((String)->Void)?
    var contentCopyBtnBlock: ((String)->Void)?
    let contentLabel = UILabel()
    let copyItemBtn = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    
    func setupView() {
        backgroundColor(UIColor(hexString: "F2F2F7")!)
        contentView.backgroundColor(UIColor(hexString: "F2F2F7")!)
        //
        let bgColorV = UIView()
        bgColorV.backgroundColor = UIColor.white
        bgColorV.adhere(toSuperview: contentView)
        bgColorV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(5)
        }
        //
        contentLabel
            .color(UIColor.darkText)
            .fontName(14, "Futura-Medium")
            .textAlignment(.left)
            .numberOfLines(0)
            .adhere(toSuperview: contentView)
        contentLabel
            .snp.makeConstraints {
                $0.top.equalTo(bgColorV.snp.top).offset(5)
                $0.left.equalTo(bgColorV.snp.left).offset(24)
                $0.right.equalTo(bgColorV.snp.right).offset(-55)
                $0.bottom.equalTo(bgColorV.snp.bottom).offset(-5)
            }
        
        //
        copyItemBtn
            .adhere(toSuperview: contentView)
            .setImage(UIImage(named: "ic_b_cop"), for: .normal)
        copyItemBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(35)
            $0.height.equalTo(35)
        }
        copyItemBtn.addTarget(self, action: #selector(contentCopyBtnClick(sender: )), for: .touchUpInside)
        
    }
    
    @objc func contentCopyBtnClick(sender: UIButton) {
        contentCopyBtnBlock?(contentLabel.text ?? "")
    }
    
}

