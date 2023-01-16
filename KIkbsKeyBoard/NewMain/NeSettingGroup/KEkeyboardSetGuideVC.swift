//
//  KEkeyboardSetGuideVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2023/1/14.
//

import UIKit
import SCPageControl

class KEkeyboardSetGuideVC: UIViewController {
    let topBar = UIView()
    let bottomCanvasView = UIView()
    let toplabel = UILabel()
    
    var collection: UICollectionView!
    let sc = SCPageControlView()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupV()
    }
    

    func setupV() {
        
        view.backgroundColor(UIColor(hexString: "FFFAF3")!)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "D0BBFE")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        
        toplabel.adhere(toSuperview: topBar)
            .text("Keybaord Setting Guide")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        toplabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let backBtn = UIButton()
        topBar.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.width.height.equalTo(44)
        }
        backBtn.setImage(UIImage(named: "ic_pop_close"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
         
        //
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        bottomCanvasView.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.top.equalToSuperview().offset(2)
        }
        collection.register(cellWithClass: GuidePageCell.self)
        collection.backgroundColor = .white
        collection.isPagingEnabled = true
        
        //
        sc.frame = CGRect(x: 0, y: self.view.bounds.size.height-80, width: self.view.bounds.size.width - 4 * 2, height: 50)
        sc.scp_style = .SCNormal
        sc.set_view(3, current: 0, current_color: UIColor(hexString: "#29BF60")!, disable_color: UIColor(hexString: "#CBCBCB")!)
        bottomCanvasView.addSubview(sc)
//        sc.snp.makeConstraints {
//            $0.left.equalToSuperview()
//            $0.right.equalToSuperview()
//            $0.bottom.equalTo(contentBgV.snp.bottom)
//            $0.height.equalTo(50)
//        }
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}


extension KEkeyboardSetGuideVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: GuidePageCell.self, for: indexPath)
        if indexPath.item == 0 {
            cell.contentImgV.image = UIImage(named: "set_step_1")
            cell.infoLabel.text = "Settings-->General-->Keyboards-->Keyboard-eZypaste, turn on \"Allow full access\""
        } else if indexPath.item == 1 {
            cell.contentImgV.image = UIImage(named: "set_step_2")
            cell.infoLabel.text = "Click on the symbol circled below in the keyboard."
        } else if indexPath.item == 2 {
            cell.contentImgV.image = UIImage(named: "set_step_4")
            cell.infoLabel.text = "Switch to \"Keyboard-eZypaste\" to use."
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KEkeyboardSetGuideVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
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

extension KEkeyboardSetGuideVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        sc.scroll_did(scrollView)
    }
}


class GuidePageCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(35)
            $0.top.equalToSuperview().offset(35)
            $0.bottom.equalToSuperview().offset(-155)
        }
        contentImgV.backgroundColor = .clear
        //
        contentView.addSubview(infoLabel)
        infoLabel.font = UIFont(name: "Avenir-Black", size: 16)
        infoLabel.textColor = UIColor.black
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(35)
            $0.top.equalTo(contentImgV.snp.bottom).offset(15)
            $0.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
        
    }
}
