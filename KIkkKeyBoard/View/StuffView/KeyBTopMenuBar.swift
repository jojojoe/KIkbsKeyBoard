//
//  KeyBTopMenuBar.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit


class KeyBTopMenuBar: UIView {

    
    var fontBtn: UIButton = UIButton.init(type: .custom)
    var tagBtn: UIButton = UIButton.init(type: .custom)
    var fuhaoBtn: UIButton = UIButton.init(type: .custom)
    
    var fontBtnClickBlock: (()->Void)?
    var tagBtnClickBlock: (()->Void)?
    var fuhaoBtnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: "#5715FF")

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}

extension KeyBTopMenuBar {
    func setupView() {
         
        // btns
        
        fontBtn.addTarget(self, action: #selector(fontBtnClick(btn:)), for: .touchUpInside)
        tagBtn.addTarget(self, action: #selector(tagBtnClick(btn:)), for: .touchUpInside)
        fuhaoBtn.addTarget(self, action: #selector(fuhaoBtnClick(btn:)), for: .touchUpInside)
        addSubview(fontBtn)
        addSubview(tagBtn)
        addSubview(fuhaoBtn)
        fontBtn.snp.makeConstraints {
            $0.left.equalTo(30)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(50)
        }
        tagBtn.snp.makeConstraints {
            $0.left.equalTo(fontBtn.snp.right).offset(10)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(50)
        }
        fuhaoBtn.snp.makeConstraints {
            $0.left.equalTo(tagBtn.snp.right).offset(10)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(50)
        }
        
        
        fontBtn.setImage(UIImage.init(named: "ic_t_unselect"), for: .normal)
        fontBtn.setImage(UIImage.init(named: "ic_t_select"), for: .selected)
        fontBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        fontBtn.setBackgroundImage(UIImage(named: "keyboard_select_button"), for: .selected)
        
        tagBtn.setImage(UIImage.init(named: "ic_tag_unselect"), for: .normal)
        tagBtn.setImage(UIImage.init(named: "ic_tag_select"), for: .selected)
        tagBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        tagBtn.setBackgroundImage(UIImage(named: "keyboard_select_button"), for: .selected)
        
        fuhaoBtn.setImage(UIImage.init(named: "ic_star_unselect"), for: .normal)
        fuhaoBtn.setImage(UIImage.init(named: "ic_star_select"), for: .selected)
        fuhaoBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        fuhaoBtn.setBackgroundImage(UIImage(named: "keyboard_select_button"), for: .selected)
    }
    
    @objc func fontBtnClick(btn: UIButton) {
        fontBtn.isSelected = false
        tagBtn.isSelected = false
        fuhaoBtn.isSelected = false
        btn.isSelected = true
        fontBtnClickBlock?()
    }
    
    @objc func tagBtnClick(btn: UIButton) {
        fontBtn.isSelected = false
        tagBtn.isSelected = false
        fuhaoBtn.isSelected = false
        btn.isSelected = true
        tagBtnClickBlock?()
    }
  
    @objc func fuhaoBtnClick(btn: UIButton) {
        fontBtn.isSelected = false
        tagBtn.isSelected = false
        fuhaoBtn.isSelected = false
        btn.isSelected = true
        fuhaoBtnClickBlock?()
    }
    
}

extension UIColor {

    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}



