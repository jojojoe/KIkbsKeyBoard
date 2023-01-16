//
//  KIkbsCardWatermarkBar.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/1.
//

import UIKit
import JXPagingView

class KIkbsCardWatermarkBar: UIView {
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var backBtnClickBlock: (()->Void)?
    let textEnterBtn = UIButton(type: .custom)
    let horBtn = UIButton(type: .custom)
    let verBtn = UIButton(type: .custom)
    
    var collection: UICollectionView!
    var list: [String] = []
    var currentWaterItemIndex: Int?
    
    var enterWaterMarkClickBlock: (()->Void)?
    
    var selectWaterMarkClickBlock: ((Int, String, Bool)->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubscribeNotic()
        loadData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubscribeNotic() {
        //
        NotificationCenter.default.addObserver(self, selector: #selector(updateSubscribeSuccessStatus(noti: )), name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success), object: nil)
    }
    
    @objc func updateSubscribeSuccessStatus(noti: Notification) {
        collection.reloadData()
    }
    
    func loadData() {
        list = ["ic_clear", "watermark1", "watermark2", "watermark3", "watermark4", "watermark5", "watermark6"]
    }
    
    @objc func backBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    @objc func enterWaterMarkClick(sender: UIButton) {
        enterWaterMarkClickBlock?()
    }
    
    
    func setupView() {
        backgroundColor(UIColor(hexString: "F2F2F7")!)
        //
        
        textEnterBtn.addTarget(self, action: #selector(enterWaterMarkClick(sender:)), for: .touchUpInside)
        textEnterBtn.titleColor(UIColor.darkText)
        textEnterBtn.backgroundColor = .white
        textEnterBtn.title("Please enter your text…")
        textEnterBtn.titleLabel?.font = UIFont(name: "Futura-CondensedMedium", size: 14)
        textEnterBtn.layer.borderWidth = 1.5
        textEnterBtn.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        textEnterBtn.layer.shadowColor = UIColor.black.cgColor
        textEnterBtn.layer.shadowOffset = CGSize(width: -2, height: 2)
        textEnterBtn.layer.shadowRadius = 0
        textEnterBtn.layer.shadowOpacity = 1
        textEnterBtn.contentHorizontalAlignment = .left
        textEnterBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        
        
        addSubview(textEnterBtn)
        textEnterBtn.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.bottom.equalTo(snp.centerY).offset(-6)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.equalTo(textEnterBtn.snp.bottom).offset(6)
            $0.height.equalTo(55)
            $0.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: KIkbsLayouWatermarkBarCell.self)
        
    }
    
    func updateEnterTextStr(textStr: String?) {
        if let text = textStr, text != "" {
            textEnterBtn.setTitle(text, for: .normal)
        } else {
            textEnterBtn.setTitle("Enter Text Here...", for: .normal)
        }
    }
    
}

extension KIkbsCardWatermarkBar: JXPagingViewListViewDelegate {
    
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return UIScrollView()
    }
}

extension KIkbsCardWatermarkBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: KIkbsLayouWatermarkBarCell.self, for: indexPath)
        let item = list[indexPath.item]
        cell.contentImgV.image = UIImage(named: item)
        if indexPath.item == 0 {
            cell.selectImgV.isHidden = true
        } else {
            cell.selectImgV.isHidden = false
            cell.selectImgV.layer.borderWidth = 2
            if currentWaterItemIndex == indexPath.item {
                cell.selectImgV.layer.borderColor = UIColor(hexString: "FBDF40")!.cgColor
            } else {
                cell.selectImgV.layer.borderColor = UIColor(hexString: "000000")!.cgColor
            }
        }
        if KIkbsPurchaseManager.default.inSubscription {
            cell.vipImgV.isHidden = true
        } else {
            if indexPath.item >= 2 {
                cell.vipImgV.isHidden = false
            } else {
                cell.vipImgV.isHidden = true
            }
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkbsCardWatermarkBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left: CGFloat = (collectionView.bounds.size.width - CGFloat(list.count * 48) - CGFloat(list.count - 1) * 4 - 1) / 2
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}

extension KIkbsCardWatermarkBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = list[indexPath.item]
        currentWaterItemIndex = indexPath.item
        collectionView.reloadData()
        var isPro = false
        if indexPath.item >= 2 {
            isPro = true
        }
        selectWaterMarkClickBlock?(indexPath.item, item, isPro)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

class KIkbsLayouWatermarkBarCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    let selectImgV = UIImageView()
    let vipImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        //
        selectImgV.isHidden = true
        selectImgV.contentMode = .scaleAspectFill
        selectImgV.clipsToBounds = true
        contentView.addSubview(selectImgV)
        selectImgV.backgroundColor = .black
        selectImgV.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.center.equalToSuperview()
        }
        selectImgV.layer.borderColor = UIColor.black.cgColor
        //
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.backgroundColor = .black
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(2)
            $0.center.equalToSuperview()
        }
        
        //
        vipImgV.image = UIImage(named: "ic_pro")
        vipImgV.contentMode = .scaleAspectFill
        vipImgV.clipsToBounds = true
        contentView.addSubview(vipImgV)
        vipImgV.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().offset(-2)
            $0.width.equalTo(17)
            $0.height.equalTo(17)
            
        }
    }
}


