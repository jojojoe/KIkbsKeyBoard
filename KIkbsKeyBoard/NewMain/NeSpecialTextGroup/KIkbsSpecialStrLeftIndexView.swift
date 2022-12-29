//
//  KIkbsSpecialStrLeftIndexView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/26.
//

import UIKit

class KIkbsSpecialStrLeftIndexView: UIView {

    var collection: UICollectionView!
    var specialBundleList: [SpecialStrBundle] = []
    var currentSpecialBundle: SpecialStrBundle?
    var selectItemBlock: ((IndexPath)->Void)?
    
    func udpateCollectionIndexPath(indexPath: IndexPath) {
        currentSpecialBundle = specialBundleList[indexPath.item]
        collection.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        collection.reloadData()
    }
    
    init(frame: CGRect, specialBundleList: [SpecialStrBundle]) {
        self.specialBundleList = specialBundleList
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
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
        collection.register(cellWithClass: KIkbsSpecialLeftColleCell.self)
    }

}

extension KIkbsSpecialStrLeftIndexView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: KIkbsSpecialLeftColleCell.self, for: indexPath)
        let bundle = specialBundleList[indexPath.item]
        cell.nameLabel
            .text(bundle.titleName)
        
        if currentSpecialBundle?.titleName == bundle.titleName {
            cell.updateSelectStatus(isSele: true)
        } else {
            cell.updateSelectStatus(isSele: false)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialBundleList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkbsSpecialStrLeftIndexView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension KIkbsSpecialStrLeftIndexView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bundle = specialBundleList[indexPath.item]
        currentSpecialBundle = bundle
        collectionView.reloadData()
        selectItemBlock?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


class KIkbsSpecialLeftColleCell: UICollectionViewCell {
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        nameLabel
            .color(UIColor.white)
            .textAlignment(.center)
            .adjustsFontSizeToFitWidth()
            .fontName(15, "Futura-Bold")
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
    
    func updateSelectStatus(isSele: Bool) {
        if isSele {
            nameLabel
                .color(UIColor(hexString: "FFEF5A")!)
        } else {
            nameLabel
                .color(UIColor.white)
        }
    }
}


