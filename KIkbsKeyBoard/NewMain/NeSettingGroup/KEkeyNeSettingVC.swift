//
//  KEkeyNeSettingVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/10.
//

import UIKit
import MessageUI
import ZKProgressHUD
import SnapKit

struct KIkbsSettingItem {
    var iconImgName = ""
    var titleName = ""
}

class KEkeyNeSettingVC: UIViewController {
    var list: [KIkbsSettingItem] = []
    let topBar = UIView()
    var collection: UICollectionView!
    let bottomCanvasView = UIView()
    var fatherVC: KEkeyMainVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubscribeNotic()
        loadData()
        contentViewSetup()
        setupCollection()
        
    }
    
    
    func addSubscribeNotic() {
        //
        NotificationCenter.default.addObserver(self, selector: #selector(updateSubscribeSuccessStatus(noti: )), name: NSNotification.Name(rawValue: PurchaseStatusNotificationKeys.success), object: nil)
    }
    
    @objc func updateSubscribeSuccessStatus(noti: Notification) {
        updateSubscribeStatus()
    }
    
    func loadData() {
        
        let terms = KIkbsSettingItem(iconImgName: "terms", titleName: "Terms Of Use")
        let privacy = KIkbsSettingItem(iconImgName: "privacy", titleName: "Privacy Policy")
        let feedback = KIkbsSettingItem(iconImgName: "feed", titleName: "Feedback")
        let keyboardAccest = KIkbsSettingItem(iconImgName: "keyborad", titleName: "Keyborad Setting")
        let subscribe = KIkbsSettingItem(iconImgName: "subscribe", titleName: "Subscribe Now")
        if KIkbsPurchaseManager.default.inSubscription {
            list = [terms, privacy, feedback, keyboardAccest]
        } else {
            list = [terms, privacy, feedback, keyboardAccest, subscribe]
        }
    }
    
    func updateSubscribeStatus() {
        loadData()
        collection.reloadData()
    }
    
    func contentViewSetup() {
        view.backgroundColor(.black)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "BFCFE9")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        let titNameLabel = UILabel()
        titNameLabel.adhere(toSuperview: topBar)
            .text("Setting")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        titNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        
        //
        bottomCanvasView
            .backgroundColor(UIColor(hexString: "F2F2F7")!)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topBar.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
        
    }
    
    func setupCollection() {
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        bottomCanvasView.addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: KISettingCell.self)
        
    }
    
}

extension KEkeyNeSettingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: KISettingCell.self, for: indexPath)
        let item = list[indexPath.item]
        cell.nameLabel.text(item.titleName)
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor(hexString: "#000000")?.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: -2, height: 2)
        cell.layer.shadowRadius = 0
        cell.layer.shadowOpacity = 1
        
        if item.iconImgName == "subscribe" {
            cell.backgroundColor = UIColor(hexString: "F0D380")
        } else {
            cell.backgroundColor = UIColor(hexString: "7EA0D4")
        }
         return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KEkeyNeSettingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 20 * 2, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 22, bottom: 0, right: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}

extension KEkeyNeSettingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = list[indexPath.item]
        if item.iconImgName == "terms" {
            let vc = KEkeyNeInfoPagePreviewVC()
            vc.toplabel.text = "Terms of Use"
            vc.contentTextV.text = termsofInfoStr
            self.fatherVC?.present(vc)
        } else if item.iconImgName == "privacy" {
            let vc = KEkeyNeInfoPagePreviewVC()
            vc.toplabel.text = "Privacy Policy"
            vc.contentTextV.text = privacyInfoStr
            self.fatherVC?.present(vc)
        } else if item.iconImgName == "feed" {
            showFeedback()
        } else if item.iconImgName == "keyborad" {
            let urlString = "App-Prefs:root=General&path=Keyboard"
            if let url = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url: url)
                }
            }
        } else if item.iconImgName == "subscribe" {
            let vc = KIkbsStoreVC()
            self.present(vc)
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class KISettingCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    let nameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
 
        //
        nameLabel
            .fontName(15, "Futura-Medium")
            .color(UIColor.black)
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(0)
            $0.left.equalTo(24)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentImgV.image(UIImage(named: "ic_settingarrow"))
        contentImgV.backgroundColor(UIColor.darkGray)
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-24)
            $0.width.height.equalTo(34)
        }
    }
}


extension KEkeyNeSettingVC: MFMailComposeViewControllerDelegate {
    func showFeedback() {
        if MFMailComposeViewController.canSendMail() {
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            let infoDic = Bundle.main.infoDictionary
            let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
            let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? ""
            let controller = MFMailComposeViewController()
            controller.mailComposeDelegate = self
            controller.setSubject("\(appName) Feedback")
            controller.setToRecipients([FeedbackEmail])
            controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
            self.present(controller, animated: true, completion: nil)
        } else {
            ZKProgressHUD.showError("The device doesn't support email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}



