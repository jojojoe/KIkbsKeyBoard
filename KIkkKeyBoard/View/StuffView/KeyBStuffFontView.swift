//
//  KeyBStuffFontView.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit

class KeyBStuffFontView: UIView {

    var didClickAction: ((KBKeyBtnFontTypeItem, IndexPath)->Void)?
    var collection: UICollectionView!
    
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

extension KeyBStuffFontView {
    func setupView() {
        self.backgroundColor = UIColor(hexString: "#FFFFFF")
        //
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }

        collection?.register(KeyBStuffFontViewCell.self, forCellWithReuseIdentifier: "KeyBStuffFontViewCell")
        
    }
    
 
    
}


extension KeyBStuffFontView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBStuffFontViewCell", for: indexPath) as? KeyBStuffFontViewCell ?? KeyBStuffFontViewCell()

        let fontItem = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        
        cell.nameLabel.text = fontItem.title
//        if fontItem.needPurchase, !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: fontItem.title)  {
//            cell.vipImgV.isHidden = false
//        } else {
            cell.vipImgV.isHidden = true
//        }
      
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KBKeyBtnManager.default.fontDatasList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KeyBStuffFontView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        
        let width: CGFloat = (UIScreen.main.bounds.width - (30 * 2) - 11) / 2
        let height: CGFloat = 36
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension KeyBStuffFontView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fontItem = KBKeyBtnManager.default.fontDatasList[indexPath.item]
        KBKeyBtnManager.default.currentFontItem = fontItem
        collectionView.reloadData()
        didClickAction?(fontItem, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
 


class KeyBStuffFontViewCell: UICollectionViewCell {
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
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.left.equalTo(20)
            $0.right.equalTo(-40)
        }
        //
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(hexString: "#5715FF")?.withAlphaComponent(0.1).cgColor
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
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(24)
            $0.height.equalTo(19)
        }
        
        
    }
    
    
}
