//
//  KIkTopMenuBar.swift
//  KIkkKeyBoard
//
//  Created by JOJO on 2022/3/24.
//

import UIKit


class KIkTopMenuBar: UIView {

    
    var fontBtn = UIButton()
    var favoriteBtn = UIButton()
    var collection: UICollectionView!
    var fontBtnClickBlock: ((Bool)->Void)?
    var favoriteBtnClickBlock: ((Bool, KeyboardFavoriteGroup?)->Void)?
    
    var titles: [KeyboardFavoriteGroup] = []
    var currentSelectFavorite: KeyboardFavoriteGroup?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: "#D1D4D9")

        setupView()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}

extension KIkTopMenuBar {
    func loadData() {
        KIDataManager.default.loadHostFavoriteTitleList {
            [weak self] titleNameItem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.titles = titleNameItem
                self.collection.reloadData()
            }
        }
    }
    
    
    func setupView() {
        
        // btns
        
        
        fontBtn.setImage(UIImage.init(named: "ic_t_unselect"), for: .normal)
        fontBtn.setImage(UIImage.init(named: "ic_t_select"), for: .selected)
        fontBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
        fontBtn.setBackgroundImage(UIImage(named: "keyboard_select_button"), for: .selected)
        fontBtn.backgroundColor = UIColor.orange
        
        fontBtn.addTarget(self, action: #selector(fontBtnClick(btn:)), for: .touchUpInside)
        addSubview(fontBtn)
        fontBtn.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(40)
        }
        
        //
        let line = UIView()
        line.backgroundColor = UIColor.darkGray
        addSubview(line)
        line.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalTo(fontBtn.snp.top)
            $0.width.equalTo(1)
            $0.left.equalTo(fontBtn.snp.right).offset(4)
        }
        
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.equalTo(line.snp.right).offset(4)
            $0.top.bottom.right.equalToSuperview()
        }
        collection.register(KIkFavoriteCell.self, forCellWithReuseIdentifier: "KIkFavoriteCell")
//        collection.register(cellWithClass: KIkFavoriteCell.self)
        
    }
    
    func updateFontSelectStatus(isSele: Bool) {
        fontBtn.isSelected = isSele
        fontBtnClickBlock?(fontBtn.isSelected)
    }
    
    @objc func fontBtnClick(btn: UIButton) {
        updateFontSelectStatus(isSele: !fontBtn.isSelected)
        
        currentSelectFavorite = nil
        collection.reloadData()
    }
    
//    @objc func favoriteBtnClick(btn: UIButton) {
//        fontBtn.isSelected = false
//        favoriteBtn.isSelected = !favoriteBtn.isSelected
//        favoriteBtnClickBlock?(favoriteBtn.isSelected)
//    }
  
}

extension KIkTopMenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KIkFavoriteCell", for: indexPath) as? KIkFavoriteCell ?? KIkFavoriteCell()
        let nameItem = titles[indexPath.item]
        let name = nameItem.groupName
        cell.nameLabel.text = name
        if currentSelectFavorite?.groupName == name {
            cell.contentView.backgroundColor = UIColor.yellow
        } else {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkTopMenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nameItem = titles[indexPath.item]
        let name = nameItem.groupName
        let attr = NSAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont(name: "Avenir-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)])
        let cellWidth: CGFloat = attr.boundingRect(with: CGSize(width: CGFloat.infinity, height: 30), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine], context: nil).size.width + 20
        let cellHeight: CGFloat = collectionView.bounds.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension KIkTopMenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateFontSelectStatus(isSele: false)
        let nameItem = titles[indexPath.item]
        let name = nameItem.groupName
        var isShowFaveorite = false
        if name != currentSelectFavorite?.groupName {
            isShowFaveorite = true
            currentSelectFavorite = nameItem
        } else {
            currentSelectFavorite = nil
        }
        favoriteBtnClickBlock?(isShowFaveorite, currentSelectFavorite)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}



class KIkFavoriteCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        nameLabel.font = UIFont(name: "Avenir-Medium", size: 14)
        nameLabel.textColor = UIColor.darkGray
        nameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
    }
}

