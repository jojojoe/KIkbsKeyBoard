//
//  KeyboardViewController.swift
//  KiKeyBoardCus
//
//  Created by JOJO on 2023/1/11.
//

import UIKit
import SnapKit

class KeyboardViewController: UIInputViewController {

    
     
    var topBar: KeyBoardTopBar = KeyBoardTopBar()
    var bottomBar: KeyBoardContentPreview = KeyBoardContentPreview()
    let globalBtn = UIButton()
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        self.setupView()
        self.globalBtn.isHidden = !self.needsInputModeSwitchKey
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 241/255.0, green: 240/255.0, blue: 1, alpha: 1)
        
        //
        view.addSubview(topBar)
        topBar.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(44)
        }
        topBar.itemSelectBlock = {
            [weak self] groupItem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                if let keyonly = groupItem["keyOnly"] {
                    self.bottomBar.updateFavoriteContentList(keyOnly: keyonly)
                }
            }
        }
        
        //
        
        view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(268)
        }
        bottomBar.itemSelectBlock = {
            [weak self] conStr in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.inputContentStr(textStr: conStr)
            }
        }
        
        //

        view.addSubview(globalBtn)
        globalBtn.setImage(UIImage(named: "net_work_ic"), for: .normal)
        globalBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
            $0.width.height.equalTo(38)
        }
        globalBtn.addTarget(self, action: #selector(globalBtnClick(sender: )), for: .touchUpInside)
        
        //
    }
    
    func updateSetupView() {
        topBar.snp.remakeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(40)
        }
        bottomBar.snp.remakeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(268)
        }
        topBar.loadData()
        bottomBar.loadData()
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
         
    }

  
    
}


extension KeyboardViewController {
    
    @objc func globalBtnClick(sender: UIButton) {
        self.advanceToNextInputMode()
    }
    
    func inputContentStr(textStr: String) {
        self.textDocumentProxy.insertText(textStr)
        self.textDocumentProxy.insertText("\n")
    }
    
}





class ThumbTextSlider: UISlider {
    var thumbTextLabel: UILabel = UILabel()
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbTextLabel.frame = thumbFrame
        thumbTextLabel.text = "\(Int(value))"
        
        //Double(value).roundTo(places: 1).description
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        
        thumbTextLabel.backgroundColor = .clear
        thumbTextLabel.textColor = .white
        thumbTextLabel.font = UIFont(name: "Avenir-Medium", size: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
}
