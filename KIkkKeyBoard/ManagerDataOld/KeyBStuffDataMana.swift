//
//  KeyBStuffDataMana.swift
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

import UIKit


struct KBStuffDataFuHaoItem: Codable {
    var title: String = ""
    var needPurchase: Bool = false
    var content: String = ""
}


class KeyBStuffDataMana: NSObject {
    static let `default` = KeyBStuffDataMana()
    let fuHaoDatasList: [KBStuffDataFuHaoItem] = loadJson([KBStuffDataFuHaoItem].self, name: "KeyBFuHao") ?? []
    let tagDatasList: [KBStuffDataFuHaoItem] = loadJson([KBStuffDataFuHaoItem].self, name: "KeyBTag") ?? []
     
}


extension KeyBStuffDataMana {
    static func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch let error as NSError {
                    print(error)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }

    static func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                do {
                    return try PropertyListDecoder().decode(T.self, from: data)
                } catch let error as NSError {
                    print(error)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }

}
