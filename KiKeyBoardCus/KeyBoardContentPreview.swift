//
//  KeyBoardContentPreview.swift
//  KiKeyBoardCus
//
//  Created by JOJO on 2023/1/11.
//

import UIKit

class KeyBoardContentPreview: UIView {

    var collection: UICollectionView!
    var currentStr: String?
    var favoriteStrList: [String] = []
    
    var itemSelectBlock: ((String)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupV()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        
        let titleDict = KIkbsKeboardFavoriteDB.default.keyboardFetchFavroriteTitles()
        if let firstD = titleDict.first, let keyonly = firstD["keyOnly"] {
            updateFavoriteContentList(keyOnly: keyonly)
        }
      
        
    }
    
    func updateFavoriteContentList(keyOnly: String) {
        
        let diList = KIkbsKeboardFavoriteDB.default.keyboardFetchFavroriteContents()
        self.favoriteStrList = diList.compactMap { dict in
            let groupk = dict["groupKey"]
            
            if groupk == keyOnly, let favovalue = dict["favoValue"] {
                return favovalue
            } else {
                return "*-+-+-+-+-+*"
            }
        }
        self.favoriteStrList.removeAll { sr in
            return sr == "*-+-+-+-+-+*"
        }
        self.collection.reloadData()
         
    }
    
    func setupV() {
        backgroundColor = .black
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
            $0.center.equalToSuperview()
            $0.left.top.equalToSuperview().offset(1)
        }
        
        collection.register(KeyBoardBottomCell.self, forCellWithReuseIdentifier: "KeyBoardBottomCell")
        
        collection.backgroundColor = UIColor(hexString: "#F1F0F4")
        collection.layer.cornerRadius = 2
    }

}

extension KeyBoardContentPreview: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyBoardBottomCell", for: indexPath) as? KeyBoardBottomCell {
            let item = favoriteStrList[indexPath.item]
            cell.titLable.text = item
            if currentStr == item {
                
            } else {
                
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteStrList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KeyBoardContentPreview: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 30, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension KeyBoardContentPreview: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = favoriteStrList[indexPath.item]
        currentStr = item
        collectionView.reloadData()
        itemSelectBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}




class KeyBoardBottomCell: UICollectionViewCell {
    let titLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowOpacity = 1
        
        //
        contentView.addSubview(titLable)
        titLable.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(10)
            $0.center.equalToSuperview()
        }
        titLable.textAlignment = .left
        titLable.adjustsFontSizeToFitWidth = true
        titLable.font = UIFont(name: "AvenirNext-Medium", size: 16)
        titLable.numberOfLines = 0
        
    }
}
