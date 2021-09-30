//
//  KeyBTopFontSelectBar.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit

class KeyBTopFontSelectBar: UIView {

    var didClickAction: ((KBKeyBtnFontTypeItem, IndexPath)->Void)?
    var collection: UICollectionView!
    var backBtnClickBlock: (()->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.clipsToBounds = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}


extension KeyBTopFontSelectBar {
    func setupView() {
        self.backgroundColor = UIColor(hexString: "#5715FF")
        
        let fontTypeBtn = UIButton(type: .custom)
        addSubview(fontTypeBtn)
        fontTypeBtn.setImage(UIImage(named: "ic_t_unselect"), for: .normal)
        fontTypeBtn.setBackgroundImage(UIImage(), for: .normal)
        fontTypeBtn.addTarget(self, action: #selector(fontTypeBtnClick(sender:)), for: .touchUpInside)
        fontTypeBtn.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
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
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(fontTypeBtn.snp.right).offset(16)
        }

        collection?.register(KeyBTopFontBarCell.self, forCellWithReuseIdentifier: "KeyBTopFontBarCell")
        
    }
    
    @objc func fontTypeBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    
}


extension KeyBTopFontSelectBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBTopFontBarCell", for: indexPath) as? KeyBTopFontBarCell ?? KeyBTopFontBarCell()
//        let nameLabel = UILabel()
//        let borderView = UIView()
//        let vipImgV = UIImageView()
        let fontItem = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        
        cell.nameLabel.text = fontItem.title
//        if fontItem.needPurchase, !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: fontItem.title)  {
//            cell.vipImgV.isHidden = false
//        } else {
            cell.vipImgV.isHidden = true
//        }
        if KBKeyBtnManager.default.currentFontItem?.title == fontItem.title {
            cell.borderView.isHidden = false
        } else {
            cell.borderView.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KBKeyBtnManager.default.fontDatasList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KeyBTopFontSelectBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        
        let width: CGFloat = 90
        let height: CGFloat = 36
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension KeyBTopFontSelectBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fontItem = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        KBKeyBtnManager.default.currentFontItem = fontItem
        collectionView.reloadData()
        didClickAction?(fontItem, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

class KeyBTopFontBarCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    let borderView = UIView()
    let vipImgV = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(22)
            $0.left.equalTo(10)
        }
        //
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.white.cgColor
        borderView.layer.cornerRadius = 18
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(36)
        }
        //
        vipImgV.image = UIImage(named: "home_ic_coin")
        vipImgV.contentMode = .scaleAspectFill
        vipImgV.clipsToBounds = true
        contentView.addSubview(vipImgV)
        vipImgV.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.equalTo(24)
            $0.height.equalTo(19)
        }
        
        
    }
}
