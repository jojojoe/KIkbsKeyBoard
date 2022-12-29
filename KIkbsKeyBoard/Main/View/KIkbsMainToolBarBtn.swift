//
//  KIkbsMainToolBar.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/17.
//

//import UIKit
//
//enum KIkbsToolItemType {
//    case transform
//    case special
//    case keyborad
//    case textCard
//    case setting
//}
//
//struct KIkbsToolItem {
//    var iconStr: String
//    var titleStr: String
//    var type: KIkbsToolItemType
//}
//
//class KIkbsMainToolBar: UIView {
//    
//    var list: [KIkbsToolItem] = []
//    
//    var collection: UICollectionView!
//    var toolBarClickBlock: ((KIkbsToolItem)->Void)?
//    
//    var currentItem: KIkbsToolItem?
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        loadData()
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func updateSelectedStatus(item: KIkbsToolItem) {
//        currentItem = item
//        collection.reloadData()
//    }
//    
//    func loadData() {
//        let btn1 = KIkbsToolItem(iconStr: "ic_transform", titleStr: "Transform", type: .transform)
//        let btn2 = KIkbsToolItem(iconStr: "ic_spaceil", titleStr: "Special", type: .special)
//        let btn3 = KIkbsToolItem(iconStr: "ic_collection", titleStr: "Keybord", type: .keyborad)
//        let btn4 = KIkbsToolItem(iconStr: "ic_textcard", titleStr: "TextCard", type: .textCard)
//        let btn5 = KIkbsToolItem(iconStr: "ic_setting", titleStr: "Setting", type: .setting)
//        
//        list = [btn1, btn2, btn3, btn4, btn5]
//    }
//    
//    func setupView() {
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
//        collection.showsVerticalScrollIndicator = false
//        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .clear
//        collection.delegate = self
//        collection.dataSource = self
//        addSubview(collection)
//        collection.snp.makeConstraints {
//            $0.top.bottom.right.left.equalToSuperview()
//        }
//        collection.register(cellWithClass: KIkbsToolBarCell.self)
//    }
//    
//}
//
//
//
//extension KIkbsMainToolBar: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withClass: KIkbsToolBarCell.self, for: indexPath)
//        let item = list[indexPath.item]
//        cell.iconImgV.image = UIImage(named: item.iconStr)
//        cell.titleLab.text = item.titleStr
//        cell.iconImgV.setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1))
//        if item.titleStr == currentItem?.titleStr {
//            cell.titleLab
//                .color(UIColor.orange)
//            cell.iconImgV.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
//        } else {
//            cell.titleLab
//                .color(UIColor.white)
//            cell.iconImgV.transform = CGAffineTransform.identity
//        }
//        return cell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//}
//
//extension KIkbsMainToolBar: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = (UIScreen.width / CGFloat(list.count))
//        let height: CGFloat = 50
//        return CGSize(width: width, height: height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//}
//
//extension KIkbsMainToolBar: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = list[indexPath.item]
//        updateSelectedStatus(item: item)
//        toolBarClickBlock?(item)
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        
//    }
//}
//
//
//
//
//
//
//
//class KIkbsToolBarCell: UICollectionViewCell {
//    
//    let iconImgV = UIImageView()
//    let titleLab = UILabel()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupView() {
//
//        iconImgV
//            .backgroundColor(UIColor.clear)
//            .contentMode(.scaleAspectFit)
//            .adhere(toSuperview: contentView)
//        iconImgV.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalToSuperview().offset(0)
//            $0.width.height.equalTo(20)
//        }
//        //
//        
//        titleLab
//            .textAlignment(.center)
//            .color(UIColor.white)
//            .adjustsFontSizeToFitWidth()
//            .fontName(13, Font_AvenirNext_Medium)
//            .adhere(toSuperview: contentView)
//        titleLab.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(iconImgV.snp.bottom).offset(0)
//            $0.height.greaterThanOrEqualTo(1)
//            $0.left.equalTo(2)
//        }
//        
//    }
//}
//
//
//
//
//
