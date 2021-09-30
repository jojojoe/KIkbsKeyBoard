//
//  KIkbsCardThemeColorBar.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/1.
//

import UIKit
import JXPagingView


class KIkbsCardThemeColorBar: UIView {
     
    var selectCardThemeColorBlock: ((TextCardThemeColor)->Void)?
    var selectCardThemeOverlayerBlock: ((TextCardThemeOverlayerItem)->Void)?
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var collection_color: UICollectionView!
    var collection_overlayer: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor(UIColor.white)
        
        //
        let layout_c = UICollectionViewFlowLayout()
        layout_c.scrollDirection = .horizontal
        collection_color = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout_c)
        collection_color.showsVerticalScrollIndicator = false
        collection_color.showsHorizontalScrollIndicator = false
        collection_color.backgroundColor = .clear
        collection_color.delegate = self
        collection_color.dataSource = self
        addSubview(collection_color)
        collection_color.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.bottom.equalTo(snp.centerY).offset(-6)
            $0.height.equalTo(50)
        }
        collection_color.register(cellWithClass: KIkbsTextCarColorCell.self)
         
        //
        let layout_o = UICollectionViewFlowLayout()
        layout_o.scrollDirection = .horizontal
        collection_overlayer = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout_o)
        collection_overlayer.showsVerticalScrollIndicator = false
        collection_overlayer.showsHorizontalScrollIndicator = false
        collection_overlayer.backgroundColor = .clear
        collection_overlayer.delegate = self
        collection_overlayer.dataSource = self
        addSubview(collection_overlayer)
        collection_overlayer.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(collection_color.snp.bottom).offset(12)
            $0.height.equalTo(50)
        }
        collection_overlayer.register(cellWithClass: KIkbsTextCarOverlayerCell.self)
        
    }
    
 
    
}


extension KIkbsCardThemeColorBar: JXPagingViewListViewDelegate {
    
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


extension KIkbsCardThemeColorBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection_color {
            let cell = collectionView.dequeueReusableCell(withClass: KIkbsTextCarColorCell.self, for: indexPath)
            let item = KIkbsDataManager.default.textCardThemeColorList[indexPath.item]
            cell.contentImgV.layer.cornerRadius = 8
            cell.contentImgV.layer.masksToBounds = true
            cell.contentImgV
                .backgroundColor(UIColor(hexString: item.bgColor) ?? UIColor.white)
            return cell
        } else if collectionView == collection_overlayer {
            let cell = collectionView.dequeueReusableCell(withClass: KIkbsTextCarOverlayerCell.self, for: indexPath)
            let item = KIkbsDataManager.default.textCardThemeOverlayerList[indexPath.item]
            cell.contentImgV.layer.cornerRadius = 8
            cell.contentImgV.layer.masksToBounds = true
            cell.contentImgV.backgroundColor(UIColor.lightGray)
            cell.contentImgV
                .image(item.thumb)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection_color {
            return KIkbsDataManager.default.textCardThemeColorList.count
        } else {
            return KIkbsDataManager.default.textCardThemeOverlayerList.count
        }
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkbsCardThemeColorBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collection_color {
            return CGSize(width: 50, height: 50)
        } else if collectionView == collection_overlayer {
            return CGSize(width: 50, height: 50)
        }
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}

extension KIkbsCardThemeColorBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collection_color {
            let item = KIkbsDataManager.default.textCardThemeColorList[indexPath.item]
            selectCardThemeColorBlock?(item)
        } else if collectionView == collection_overlayer {
            let item = KIkbsDataManager.default.textCardThemeOverlayerList[indexPath.item]
            selectCardThemeOverlayerBlock?(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class KIkbsTextCarColorCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        
    }
}

class KIkbsTextCarOverlayerCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        
    }
}

