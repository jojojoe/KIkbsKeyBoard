//
//  KIkbsSpecialStrPreviewView.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/25.
//

import UIKit
import JXPagingView

class KIkbsSpecialStrPreviewView: UIView {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    let rightTableView = UITableView(frame: .zero, style: .plain)
    var leftBundleView: KIkbsSpecialStrLeftIndexView!
    
    var specialStrType: SpecialStrType
    var specialBundleList: [SpecialStrBundle] = []
    var cellSize: CGSize = .zero
    var perLineCount: CGFloat = 1
    var leftCollectionWidth: CGFloat = 1
    var rightCollectionWidth: CGFloat = 1
    var clickSpecialStrBlock: ((String, Bool)->Void)?
    
    
    init(frame: CGRect, specialStrType: SpecialStrType) {
        self.specialStrType = specialStrType
        super.init(frame: frame)
        
        loadData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension KIkbsSpecialStrPreviewView {
    func loadData() {
        
        leftCollectionWidth = 80
        rightCollectionWidth = (UIScreen.width - leftCollectionWidth)
        
        
        switch specialStrType {
        case .symbol:
            specialBundleList = KIkbsDataManager.default.specialSymbolList
            perLineCount = 5
            let cellWidth = (rightCollectionWidth - 1) / perLineCount
            let cellHeight = cellWidth
            cellSize = CGSize(width: cellWidth, height: cellHeight)
        case .quote:
            specialBundleList = KIkbsDataManager.default.specialQuoteList
            perLineCount = 1
            let cellWidth = (rightCollectionWidth - 1) / perLineCount
            let cellHeight: CGFloat = 80
            cellSize = CGSize(width: cellWidth, height: cellHeight)
        case .emojiStr:
            specialBundleList = KIkbsDataManager.default.specialEmojiStrList
            perLineCount = 3
            let cellWidth = (rightCollectionWidth - 1) / perLineCount
            let cellHeight: CGFloat = 44
            cellSize = CGSize(width: cellWidth, height: cellHeight)
        case .shape:
            specialBundleList = KIkbsDataManager.default.specialShapeList
            perLineCount = 2
            let cellWidth = (rightCollectionWidth - 1) / perLineCount
            let cellHeight: CGFloat = cellWidth * (6/6)
            cellSize = CGSize(width: cellWidth, height: cellHeight)
         
        }
    }
    
    func setupView() {
        
        leftBundleView = KIkbsSpecialStrLeftIndexView(frame: .zero, specialBundleList: specialBundleList)
        addSubview(leftBundleView)
        leftBundleView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(leftCollectionWidth)
        }
        leftBundleView.selectItemBlock = {
            [weak self] indexPath in
            guard let `self` = self else {return}
            let i = IndexPath(item: 0, section: indexPath.row)
            
            self.rightTableView.selectRow(at: i, animated: true, scrollPosition: .top)
            self.rightTableView.deselectRow(at: i, animated: true)
        }
        //
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.indicatorStyle = .black
        rightTableView.backgroundColor = .clear
        addSubview(rightTableView)
        rightTableView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(leftCollectionWidth)
        }
        rightTableView.register(cellWithClass: KIkbsSpecialRightTabCell.self)
        rightTableView.register(headerFooterViewClassWith: KIkbsSpecialRightTabHeader.self)
         
        
    }
     
}

extension KIkbsSpecialStrPreviewView: JXPagingViewListViewDelegate {
    
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.rightTableView
    }
}




extension KIkbsSpecialStrPreviewView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: KIkbsSpecialRightTabCell.self, for: indexPath)
        let bundle = specialBundleList[indexPath.section]
        var isMutileLine = false
        
        switch specialStrType {
        case .quote:
            isMutileLine = true
        case .shape:
            isMutileLine = true
            
        default:
            isMutileLine = false
            
        }
        
        cell.updateContentSpecialBundle(bundle: bundle, cellSize: cellSize, multibLineCount: isMutileLine)
        cell.clickSpecialContentBlock = {
            [weak self] specialStr, isPro in
            guard let `self` = self else {return}
            self.clickSpecialStrBlock?(specialStr, isPro)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bundle = specialBundleList[indexPath.section]
        var lineCount = Int(bundle.specialStrList.count) / Int(perLineCount)
        let yushu = bundle.specialStrList.count % Int(perLineCount)
        if yushu != 0 {
            lineCount = lineCount + 1
        }
        let height: CGFloat = CGFloat(lineCount) * cellSize.height
        return height
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bundle = specialBundleList[section]
        
        let header = tableView.dequeueReusableHeaderFooterView(withClass: KIkbsSpecialRightTabHeader.self)
        header.nameLabel.text = bundle.titleName
        header.proImgV.isHidden = !bundle.isPro
        return header
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == rightTableView {
            
            let y = scrollView.contentOffset.y
            if let currentIndexP = rightTableView.indexPathForRow(at: CGPoint(x: 30, y: y)) {
                
                let index = IndexPath(item: currentIndexP.section, section: 0)
                
                leftBundleView.udpateCollectionIndexPath(indexPath: index)
            }
        }
    }
    
}


extension KIkbsSpecialStrPreviewView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return specialBundleList.count
    }
    
    
    
}

class KIkbsSpecialRightTabCell: UITableViewCell {
    
    var collection: UICollectionView!
    var specialBundle: SpecialStrBundle?
    var specialCellSize: CGSize = CGSize.zero
    var multibLine: Bool = false
    var clickSpecialContentBlock: ((String, Bool)->Void)?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentSpecialBundle(bundle: SpecialStrBundle, cellSize: CGSize, multibLineCount: Bool) {
        specialBundle = bundle
        specialCellSize = cellSize
        multibLine = multibLineCount
        collection.reloadData()
    }
    
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.layer.cornerRadius = 6
        collection
            .backgroundColor(UIColor.lightGray)
            .adhere(toSuperview: contentView)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: KIkbsSpecialRightColleCell.self)
        
    }
    
}

extension KIkbsSpecialRightTabCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: KIkbsSpecialRightColleCell.self, for: indexPath)
        if let specialBundle_m = specialBundle {
            let string = specialBundle_m.specialStrList[indexPath.item]
            
            if multibLine {
                cell.nameLabel.numberOfLines = 0
                cell.nameLabel.fontName(12, Font_AvenirNext_Medium)
            } else {
                cell.nameLabel.numberOfLines = 1
            }
            cell.nameLabel.text = string
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialBundle?.specialStrList.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KIkbsSpecialRightTabCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return specialCellSize
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

extension KIkbsSpecialRightTabCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let specialBundle_m = specialBundle {
            let string = specialBundle_m.specialStrList[indexPath.item]
            clickSpecialContentBlock?(string, specialBundle_m.isPro)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

class KIkbsSpecialRightColleCell: UICollectionViewCell {
    let nameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        nameLabel
            .color(UIColor.lightGray)
            .textAlignment(.center)
            .adjustsFontSizeToFitWidth()
            .fontName(15, Font_AvenirNext_Medium)
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        
        
    }
    
    
}







class KIkbsSpecialRightTabHeader: UITableViewHeaderFooterView {
    let nameLabel = UILabel()
    let proImgV = UIImageView()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        alpha = 0.4
        backgroundColor(UIColor.black.withAlphaComponent(0.2))
        //
        nameLabel
            .fontName(15, Font_Avenir_Heavy)
            .adjustsFontSizeToFitWidth()
            .color(UIColor.white)
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(24)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        //
        proImgV
            .image("")
            .contentMode(.scaleAspectFit)
            .backgroundColor(UIColor.orange)
            .adhere(toSuperview: contentView)
        proImgV.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.left.equalTo(nameLabel.snp.right).offset(12)
            $0.width.height.equalTo(24)
        }
        
        
    }
    
    
    
}
 


 
