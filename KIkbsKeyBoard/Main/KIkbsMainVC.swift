//
//  KIkbsMainVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//
//
//import UIKit
//import SnapKit
//
//
//class KIkbsMainVC: UIViewController {
//    let contentBgView = UIView()
//    let bottomBar = UIView()
//    let textTransformVC = KIkbsTextTransformVC()
//    let specialTextLibVC = KIkbsSpecialTextLibVC()
//    let keyboardFavoriteVC = KIkbsKeyboardFavoriteVC()
//    let textCardPicVC = KIkbsTextCardPicVC()
//    let settingVC = KIkbsSettingVC()
//    let toolBar = KIkbsMainToolBar()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupContentView()
//        setupBottonBar()   
//    }
//    
//
//     
//
//}
//
//extension KIkbsMainVC {
//    func setupView() {
//        view.clipsToBounds = true
//        view
//            .backgroundColor(UIColor.white)
//        //
//        contentBgView
//            .backgroundColor(UIColor.white)
//            .adhere(toSuperview: view)
//        contentBgView.snp.makeConstraints {
//            $0.left.top.right.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
//        }
//        //
//        
//        bottomBar
//            .backgroundColor(UIColor.black)
//            .adhere(toSuperview: view)
//        bottomBar.snp.makeConstraints {
//            $0.left.right.bottom.equalToSuperview()
//            $0.top.equalTo(contentBgView.snp.bottom)
//        }
//        //
//        
//    }
//    
//    func setupContentView() {
//        //
//        self.addChild(textTransformVC)
//        self.contentBgView.addSubview(textTransformVC.view)
//        textTransformVC.view.snp.makeConstraints {
//            $0.top.left.right.bottom.equalToSuperview()
//        }
//        //
//        self.addChild(specialTextLibVC)
//        self.contentBgView.addSubview(specialTextLibVC.view)
//        specialTextLibVC.view.snp.makeConstraints {
//            $0.top.left.right.bottom.equalToSuperview()
//        }
//        
//        //
//        self.addChild(keyboardFavoriteVC)
//        self.contentBgView.addSubview(keyboardFavoriteVC.view)
//        keyboardFavoriteVC.view.snp.makeConstraints {
//            $0.top.left.right.bottom.equalToSuperview()
//        }
//        
//        //
//        self.addChild(textCardPicVC)
//        self.contentBgView.addSubview(textCardPicVC.view)
//        textCardPicVC.view.snp.makeConstraints {
//            $0.top.left.right.bottom.equalToSuperview()
//        }
//        
//        //
//        self.addChild(settingVC)
//        self.contentBgView.addSubview(settingVC.view)
//        settingVC.view.snp.makeConstraints {
//            $0.top.left.right.bottom.equalToSuperview()
//        }
//    }
//    
//    func setupBottonBar() {
//        
//        toolBar
//            .adhere(toSuperview: bottomBar)
//        toolBar.snp.makeConstraints {
//            $0.left.right.bottom.top.equalToSuperview()
//        }
//        toolBar.toolBarClickBlock = {
//            [weak self] item in
//            guard let `self` = self else {return}
//            DispatchQueue.main.async {
//                self.showToolContentView(item: item)
//            }
//        }
//        
//        if let item = toolBar.list.first {
//            toolBar.updateSelectedStatus(item: item)
//            showToolContentView(item: item)
//        }
//        //
//        
//        
//    }
//    
//    
//}
//
//extension KIkbsMainVC {
////
//    func showToolContentView(item: KIkbsToolItem) {
//        self.textTransformVC.view.isHidden = true
//        self.specialTextLibVC.view.isHidden = true
//        self.keyboardFavoriteVC.view.isHidden = true
//        self.textCardPicVC.view.isHidden = true
//        self.settingVC.view.isHidden = true
//        if item.type == .transform {
//            self.textTransformVC.view.isHidden = false
//        }  else if item.type == .special {
//            self.specialTextLibVC.view.isHidden = false
//        } else if item.type == .keyborad {
//            self.keyboardFavoriteVC.view.isHidden = false
//        } else if item.type == .textCard {
//            self.textCardPicVC.view.isHidden = false
//        } else if item.type == .setting {
//            self.settingVC.view.isHidden = false
//        }
//    }
//    
//    
//}
//
//
// 
//
//
//
