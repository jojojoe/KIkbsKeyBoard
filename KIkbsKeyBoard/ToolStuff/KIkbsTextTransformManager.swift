//
//  KIkbsTextTransformManager.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/9/16.
//

import Foundation

struct TextTranformItem: Codable {
    var previewStr = ""
    var contentStr_low = ""
    var contentStr_up = ""
    var leftAddStr = ""
    var rightAddStr = ""
    var zalgoList: [String] = []
//    var itemType: String?
}

class KIkbsTextTransformManager: NSObject {
    
    var textTranformFontList: [TextTranformItem] {
        return KIkbsDataManager.default.loadJson([TextTranformItem].self, name: "textTransform_Font") ?? []
    }
    var textTranformLeftRightAddList: [TextTranformItem] {
        return KIkbsDataManager.default.loadJson([TextTranformItem].self, name: "textTransform_LeftAdd") ?? []
    }
    var textTranformZalgoList: [TextTranformItem] {
        return KIkbsDataManager.default.loadJson([TextTranformItem].self, name: "textTransform_Zalgo") ?? []
    }
    
 
    
    static let `default` = KIkbsTextTransformManager()
    
    func processReplaceText(contentStr: String, transformItem: TextTranformItem) -> String {
        var resultStr = ""
        
        contentStr.charactersArray.forEach {[weak self] item in
            guard let `self` = self else {return}
            let lowChars = transformItem.contentStr_low.charactersArray
            let upChars = transformItem.contentStr_up.charactersArray
            
            let lowsList = "abcdefghijklmnopqrstuvwxyz".charactersArray
            let upsList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".charactersArray

            if lowsList.contains(item) {
                if let index = lowsList.firstIndex(of: item) {
                    let char = lowChars[index]
                    resultStr.append(char)
                }
            } else if upsList.contains(item) {
                if let index = upsList.firstIndex(of: item) {
                    let char = upChars[index]
                    resultStr.append(char)
                }
            } else {
                resultStr.append(item)
            }
        }
        
        
        // left right add
        var newTotalStr = ""
        
        let substr = resultStr.split(separator: "\n")
        for strs in substr {
            if strs.count >= 1 {
                //
                var reStr = String(strs)
                // zalgo
                if transformItem.zalgoList.count >= 1 {
                    let zalgoList = transformItem.zalgoList.compactMap {
                        return ManagerTool.number(withHexString: $0)
                    }
                    reStr = ZalgoStringMaker.zalgoCustom(contentStr: reStr, combiningInt: zalgoList)
                }
                //
                let strlist = transformItem.leftAddStr + reStr + transformItem.rightAddStr + "\n"
                newTotalStr = newTotalStr + strlist
            } else {
                newTotalStr = newTotalStr + "\n"
            }
            
        }
        resultStr = newTotalStr
        
        debugPrint("resultStr = \(resultStr)")
        return resultStr
    }
}





