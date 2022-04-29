//
//  KIkFavoriteSelectV.swift
//  KIkkKeyBoard
//
//  Created by JOJO on 2022/3/24.
//

import UIKit

class KIkFavoriteSelectV: UIView {

    var didClickAction: ((String)->Void)?
    var didClickAddNewAction: (()->Void)?
    var collection: UICollectionView!
    var favoriteList: [String] = []
    
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

    func updateContent(titleKeyOnly: String) {
        KIDataManager.default.loadHostFavoriteContent(titleName: titleKeyOnly) {[weak self] fList in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.favoriteList = fList
                self.collection.reloadData()
                self.collection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: false)
            }
        }
    }
}

extension KIkFavoriteSelectV {
    func setupView() {
        
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

        collection?.register(KIkFavoriteSelectVCell.self, forCellWithReuseIdentifier: "KIkFavoriteSelectVCell")
        
    }
    
 
    
}


extension KIkFavoriteSelectV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KIkFavoriteSelectVCell", for: indexPath) as? KIkFavoriteSelectVCell ?? KIkFavoriteSelectVCell()
        if indexPath.item >= favoriteList.count {
            cell.addNewBgView.isHidden = false
        } else {
            cell.addNewBgView.isHidden = true
            let str = favoriteList[indexPath.item]
            cell.nameLabel.text = str
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkFavoriteSelectV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 56
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension KIkFavoriteSelectV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item >= favoriteList.count {
            didClickAddNewAction?()
        } else {
            let str = favoriteList[indexPath.item]
            didClickAction?(str)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
 


class KIkFavoriteSelectVCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let addNewBgView = UIView()
    
    
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
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        //
        contentView.addSubview(addNewBgView)
        addNewBgView.backgroundColor = UIColor.black
        addNewBgView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        let addImgV = UIImageView()
        addImgV.image = UIImage()
        addImgV.backgroundColor = UIColor.white
        addNewBgView.addSubview(addImgV)
        addImgV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
    }
    
    
}
