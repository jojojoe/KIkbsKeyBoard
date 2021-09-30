//
//  KeyBCoinLockView.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit

class KeyBCoinLockView: UIView {

    var okBtnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
        self.clipsToBounds = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}

extension KeyBCoinLockView {
    
    func setupView() {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        contentLabel.textColor = .white
        contentLabel.text = "It will cost \(KBCoinManager.default.costCount) coins to unlock"
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(snp.centerY)
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(30)
        }
        // ×
        let iconImgV = UIImageView(image: UIImage(named: "unlock_coin"))
        addSubview(iconImgV)
        iconImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentLabel.snp.top).offset(-10)
            $0.width.equalTo(148/2)
            $0.height.equalTo(106/2)
        }
        //
        let okBtn = UIButton(type: .custom)
        okBtn.setBackgroundImage(UIImage(named: "button_ok"), for: .normal)
        okBtn.setTitle("OK", for: .normal)
        okBtn.setTitleColor(.white, for: .normal)
        okBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        addSubview(okBtn)
        okBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.width.equalTo(216/2)
            $0.height.equalTo(80/2)
             
        }
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
    }
    
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
    
}


