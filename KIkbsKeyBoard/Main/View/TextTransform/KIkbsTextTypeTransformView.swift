//
//  KIkbsTextTypeTransformView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/18.
//

import UIKit
import JXPagingView



class KIkbsTextTypeTransformView: UIView {
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    var collection: UICollectionView!
    var fontTypeList: [TextTranformItem] = []
    var itemClickBlock: ((TextTranformItem)->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        
        fontTypeList = KIkbsTextTransformManager.default.textTranformFontList
    }
    
    func setupView() {
        backgroundColor(UIColor.white)
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
        collection.register(cellWithClass: KIkbsTextTypeTransformTextCell.self)
    }
    

}

extension KIkbsTextTypeTransformView: JXPagingViewListViewDelegate {
    
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.collection
    }
}

extension KIkbsTextTypeTransformView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: KIkbsTextTypeTransformTextCell.self, for: indexPath)
        
        let item = fontTypeList[indexPath.item]
        cell.textLabel.text = item.previewStr
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontTypeList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkbsTextTypeTransformView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perCount: CGFloat = 3
        let left: CGFloat = 20
        let padding: CGFloat = 15
        let width: CGFloat = (UIScreen.width - left * 2 - padding * (perCount-1) - 1) / perCount
        let height: CGFloat = 44
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left: CGFloat = 20
        return UIEdgeInsets(top: 10, left: left, bottom: 10, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 15
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 15
        return padding
    }
    
}

extension KIkbsTextTypeTransformView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = fontTypeList[indexPath.item]
        itemClickBlock?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

class KIkbsTextTypeTransformTextCell: UICollectionViewCell {
    let textLabel = UILabel()
    let vipImgV = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView
            .backgroundColor(UIColor.white)
        contentView.layer.cornerRadius = 8
        
        //
        textLabel
            .fontName(14, Font_AvenirNext_Medium)
            .color(.darkText)
            .adhere(toSuperview: contentView)
            .textAlignment(.center)
        
        textLabel.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        vipImgV
            .image("")
            .contentMode(.scaleAspectFit)
            .backgroundColor(UIColor.orange)
            .adhere(toSuperview: contentView)
        vipImgV
            .snp.makeConstraints {
                $0.top.right.equalToSuperview()
                $0.width.height.equalTo(20)
            }
        
    }
}
