//
//  KIkbsSettingVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

import UIKit
//
//struct KIkbsSettingItem {
//    var iconImgName = ""
//    var titleName = ""
//}
//
//class KIkbsSettingVC: UIViewController {
//
//    var collection: UICollectionView!
//    var list: [KIkbsSettingItem] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        loadData()
//    }
//    
//    func loadData() {
//        
//        let terms = KIkbsSettingItem(iconImgName: "", titleName: "Terms Of Use")
//        let rateUs = KIkbsSettingItem(iconImgName: "", titleName: "Rate Us")
//        let privacy = KIkbsSettingItem(iconImgName: "", titleName: "Privacy Policy")
//        let feedback = KIkbsSettingItem(iconImgName: "", titleName: "Feedback")
//        let restore = KIkbsSettingItem(iconImgName: "", titleName: "Restore")
//        let keyboardAccest = KIkbsSettingItem(iconImgName: "", titleName: "设置键盘完全访问")
//        
//        
//        list = [terms, rateUs, privacy, feedback, restore, keyboardAccest]
//        collection.reloadData()
//        
//    }
//    
//    func setupView() {
//        let topBanner = UIView()
//        topBanner
//            .backgroundColor(.black)
//            .adhere(toSuperview: view)
//        topBanner.snp.makeConstraints {
//            $0.top.left.right.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
//        }
//        //
//        let topTitleLabel = UILabel()
//        topTitleLabel
//            .fontName(15, Font_AvenirNext_Medium)
//            .color(UIColor.white)
//            .text("Account Setting")
//            .textAlignment(.center)
//            .adhere(toSuperview: view)
//        topTitleLabel
//            .snp.makeConstraints {
//                $0.bottom.equalTo(topBanner.snp.bottom)
//                $0.height.equalTo(44)
//                $0.centerX.equalToSuperview()
//                $0.width.greaterThanOrEqualTo(1)
//            }
//        
//        //UIColor(hexString: "#F4F4F4")
//        let contentBgView = UIView()
//        contentBgView
//            .backgroundColor(UIColor.white)
//            .adhere(toSuperview: view)
//        contentBgView.snp.makeConstraints {
//            $0.left.right.bottom.equalToSuperview()
//            $0.top.equalTo(topBanner.snp.bottom)
//        }
//        
//        //
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
//        collection.showsVerticalScrollIndicator = false
//        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .clear
//        collection.delegate = self
//        collection.dataSource = self
//        contentBgView.addSubview(collection)
//        collection.snp.makeConstraints {
//            $0.top.bottom.right.left.equalToSuperview()
//        }
//        collection.register(cellWithClass: KISettingCell.self)
//        
//        
//    }
//    
//    
//}
//
//extension KIkbsSettingVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withClass: KISettingCell.self, for: indexPath)
//        let item = list[indexPath.item]
//        cell.nameLabel.text(item.titleName)
//        cell.contentImgV.image(item.iconImgName)
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
//extension KIkbsSettingVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.size.width, height: 56)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
//extension KIkbsSettingVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
////class KISettingCell: UICollectionViewCell {
////    let contentImgV = UIImageView()
////    let nameLabel = UILabel()
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        setupView()
////    }
////    
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////    
////    func setupView() {
//////        contentImgV.contentMode = .scaleAspectFill
//////        contentImgV.clipsToBounds = true
//////        contentImgV.backgroundColor(UIColor.darkGray)
//////        contentView.addSubview(contentImgV)
//////        contentImgV.snp.makeConstraints {
//////            $0.centerY.equalToSuperview()
//////            $0.left.equalTo(24)
//////            $0.width.height.equalTo(25)
//////        }
////        
////        //
////        nameLabel
////            .fontName(15, "AvenirNext-Medium")
////            .color(UIColor.black)
////            .adhere(toSuperview: contentView)
////        nameLabel.snp.makeConstraints {
////            $0.centerY.equalToSuperview().offset(5)
////            $0.left.equalTo(44)
////            $0.width.height.greaterThanOrEqualTo(1)
////        }
////        
////        //
//////        contentImgV.contentMode = .scaleAspectFill
//////        contentImgV.clipsToBounds = true
//////        contentImgV.backgroundColor(UIColor.darkGray)
//////        contentView.addSubview(contentImgV)
//////        contentImgV.snp.makeConstraints {
//////            $0.centerY.equalToSuperview()
//////            $0.left.equalTo(24)
//////            $0.width.height.equalTo(25)
//////        }
////        
////        //
////        let bottomLine = UIView()
////        bottomLine
////            .backgroundColor(UIColor.darkGray.withAlphaComponent(0.25))
////            .adhere(toSuperview: contentView)
////        bottomLine.snp.makeConstraints {
////            $0.left.equalTo(40)
////            $0.right.equalToSuperview().offset(-40)
////            $0.bottom.equalToSuperview()
////            $0.height.equalTo(1)
////        }
////        
////    }
////}
//
//
//
//
//
//
