//
//  KeyBoardTopBar.swift
//  KiKeyBoardCus
//
//  Created by JOJO on 2023/1/11.
//

import UIKit

class KeyBoardTopBar: UIView {
    //        ["groupName": $0.groupName, "keyOnly": $0.keyOnly]
    
    var collection: UICollectionView!
    var currentIndexP: IndexPath? = IndexPath(item: 0, section: 0)
    var favoriteGroupList: [[String: String]] = []
    var itemSelectBlock: (([String: String])->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadData()
        setupV()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {

        self.favoriteGroupList = KIkbsKeboardFavoriteDB.default.keyboardFetchFavroriteTitles()
        
        debugPrint("self.favoriteGroupList = \(self.favoriteGroupList)")
        
    }
    
    func setupV() {
        backgroundColor = .black
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
            $0.center.equalToSuperview()
            $0.left.top.equalToSuperview().offset(1)
        }
        
        collection.register(KeyBoardTopCell.self, forCellWithReuseIdentifier: "KeyBoardTopCell")
        
        collection.backgroundColor = UIColor(hexString: "#E4E4E4")
        collection.layer.cornerRadius = 2
    }

}

extension KeyBoardTopBar: UICollectionViewDataSource {
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBoardTopCell", for: indexPath) as? KeyBoardTopCell {
            let groupDict = favoriteGroupList[indexPath.item]
            cell.titLable.text = groupDict["groupName"]
            if currentIndexP?.item == indexPath.item {
                cell.backgroundColor = UIColor(hexString: "#7EA0D4")
                cell.titLable.textColor = .white
            } else {
                cell.backgroundColor = UIColor(hexString: "#FFFFFF")
                cell.titLable.textColor = .black
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGroupList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KeyBoardTopBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension KeyBoardTopBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemGroup = favoriteGroupList[indexPath.item]
        currentIndexP = indexPath
        collectionView.reloadData()
        itemSelectBlock?(itemGroup)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}





class KeyBoardTopCell: UICollectionViewCell {
    let titLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layer.cornerRadius = 4
        
        //
        contentView.addSubview(titLable)
        titLable.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        titLable.textAlignment = .center
        titLable.adjustsFontSizeToFitWidth = true
        titLable.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
    }
}
