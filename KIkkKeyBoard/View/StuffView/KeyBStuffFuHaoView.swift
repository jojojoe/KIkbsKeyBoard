//
//  KeyBStuffFuHaoView.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit

class KeyBStuffFuHaoView: UIView {

    var didClickAction: ((KBStuffDataFuHaoItem)->Void)?
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

extension KeyBStuffFuHaoView {
    func setupView() {
        var collection: UICollectionView!
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
        collection?.register(KeyBStuffFuHaoViewCell.self, forCellWithReuseIdentifier: "KeyBStuffFuHaoViewCell")
        
        
        
    }
}


extension KeyBStuffFuHaoView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBStuffFuHaoViewCell", for: indexPath) as? KeyBStuffFuHaoViewCell ?? KeyBStuffFuHaoViewCell()
        
        let item = KeyBStuffDataMana.default.fuHaoDatasList[indexPath.item]
        
        cell.tagContentLabel.text = item.content
        
//        if item.needPurchase, !KeyBUnlockManager.sharedInstance().hasUnlockContent(withContentItemId: item.title)  {
//            cell.vipImgV.isHidden = false
//        } else {
            cell.vipImgV.isHidden = true
//        }
      
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KeyBStuffDataMana.default.fuHaoDatasList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KeyBStuffFuHaoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = KeyBStuffDataMana.default.fuHaoDatasList[indexPath.item]
        
        let width: CGFloat = (UIScreen.main.bounds.width - (30 * 2) - 1)
        let height: CGFloat = 36
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
}

extension KeyBStuffFuHaoView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let fontItem = KeyBStuffDataMana.default.fuHaoDatasList[indexPath.item]
        collectionView.reloadData()
        didClickAction?(fontItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


class KeyBStuffFuHaoViewCell: UICollectionViewCell {
    
    let tagContentLabel = UILabel()
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
         
        //
        tagContentLabel.textColor = UIColor.black
        tagContentLabel.font = UIFont(name: "Verdana-Regular", size: 14)
        tagContentLabel.textAlignment = .left
        contentView.addSubview(tagContentLabel)
        tagContentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalTo(20)
            $0.right.equalTo(-40)
        }
        tagContentLabel.adjustsFontSizeToFitWidth = true
        
        //
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(hexString: "#5715FF")?.withAlphaComponent(0.1).cgColor
        borderView.layer.cornerRadius = 18
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview()
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

