//
//  KIkbsKeboardFavoriteDB.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/28.
//

import UIKit
import SQLite


var AppGroup = "group.com.keyinsfont.superone"

struct KeyboardFavoriteItem {
    var keyOnly: String // 唯一标识符
    var groupNameKeyOnly: String
    var contentStr: String // 内容
    
}

struct KeyboardFavoriteGroup {
    var keyOnly: String // 唯一标识符
    var groupName: String // group name
    
}

class KIkbsKeboardFavoriteDB: NSObject {
    static let `default` = KIkbsKeboardFavoriteDB()
    var db: Connection?
    func prepareDB() {
        do {
            db = try Connection(dbPath())
            createTables()
        } catch {
            debugPrint("prepare database error: \(error)")
        }
    }
    
    fileprivate func dbPath() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let documentPath = documentPaths.first ?? ""
        
        let groupURLPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroup)?.absoluteString ?? documentPath
        
        
        let dbPath = "\(groupURLPath)/KeyFavorite.sqlite"
        debugPrint("dbPath: \(dbPath)")
        return dbPath
    }
    
    fileprivate func createTables() {
        createGroupListTable()
        createKeyFavoriteListTable()
    }
}

extension KIkbsKeboardFavoriteDB {
    func createGroupListTable() {
        let table = Table("GroupNameList")
        
        let keyOnly = Expression<String>("keyOnly")
        let groupName = Expression<String>("groupName")
        
        do {
            try db?.run(table.create { t in
                t.column(keyOnly, primaryKey: true)
                t.column(groupName)
                
            })
        } catch {
            debugPrint("dberror: create table failed. - \("TagList")")
        }
    }
    
    func createKeyFavoriteListTable() {
        let table = Table("KeyFavoriteList")
        let keyOnly = Expression<String>("keyOnly")
        let groupNameKeyOnly = Expression<String>("groupNameKeyOnly")
        let contentStr = Expression<String>("contentStr")
        
        do {
            try db?.run(table.create { t in
                t.column(keyOnly, primaryKey: true)
                t.column(groupNameKeyOnly)
                t.column(contentStr)
                
            })
        } catch {
            debugPrint("dberror: create table failed. - \("TagList")")
        }
    }
}

extension KIkbsKeboardFavoriteDB {
    func addFavoriteGroup(groupName: String, completionBlock: (()->Void)?) {
        do {
            
            let keyOnly = String(describing: Date().timeIntervalSince1970)
            let insetSql = try db?.prepare("INSERT OR REPLACE INTO GroupNameList (keyOnly, groupName) VALUES (?,?)")
            try insetSql?.run([keyOnly, groupName])
        } catch {
            debugPrint("error = \(error)")
        }
        completionBlock?()
    }
    
    func deleteFavoriteGroup(groupNameKeyOnly: String, completionBlock: (()->Void)?) {
        let table = Table("GroupNameList")
        let db_keyOnly = Expression<String>("keyOnly")
        let deleteItem = table.filter(db_keyOnly == groupNameKeyOnly)
        do {
            try db?.run(deleteItem.delete())
        } catch {
            debugPrint("dberror: delete table failed :\(db_keyOnly)")
        }
        completionBlock?()
    }
    
    func selectKeyFavoriteGroupNameList(completionBlock: (([KeyboardFavoriteGroup])->Void)?) {
        var groupList: [KeyboardFavoriteGroup] = []
        do {
            if let results = try db?.prepare("select * from GroupNameList ORDER BY keyOnly ASC;") {
                // DESC
                for row in results {
                    let keyOnly_m = row[0] as? String ?? ""
                    let groupName_m = row[1] as? String ?? ""
                    
                    let item = KeyboardFavoriteGroup(keyOnly: keyOnly_m, groupName: groupName_m)
                    groupList.append(item)
                }
            }
            completionBlock?(groupList)
        } catch {
            debugPrint("dberror: load favorites failed")
        }
    }
    
    func addKeyFavoriteContent(favoriteKeyOnly: String, groupNameKeyOnly: String, favoriteContentStr: String, completionBlock: (()->Void)?) {
        do {
            
//            let keyOnly = Date().timeIntervalSince1970.string
            let insetSql = try db?.prepare("INSERT OR REPLACE INTO KeyFavoriteList (keyOnly, groupNameKeyOnly, contentStr) VALUES (?,?,?)")
            try insetSql?.run([favoriteKeyOnly, groupNameKeyOnly, favoriteContentStr])
            
        } catch {
            debugPrint("error = \(error)")
        }
        completionBlock?()
    }
    
    func deleteKeyFavoriteContent(favoriteKeyOnly: String, completionBlock: (()->Void)?) {
        let table = Table("KeyFavoriteList")
        let db_keyOnly = Expression<String>("keyOnly")
        let deleteItem = table.filter(db_keyOnly == favoriteKeyOnly)
        do {
            try db?.run(deleteItem.delete())
        } catch {
            debugPrint("dberror: delete table failed :\(db_keyOnly)")
        }
        completionBlock?()
    }
    
    func selectFavoriteContentList(groupNameKeyOnly: String, completionBlock: (([KeyboardFavoriteItem])->Void)?) {
        var favoriteList: [KeyboardFavoriteItem] = []
        do {
            if let results = try db?.prepare("select * from KeyFavoriteList WHERE groupNameKeyOnly = '\(groupNameKeyOnly)' ORDER BY keyOnly DESC;") {
                // DESC
                
                for row in results {
                    let keyOnly_m = row[0] as? String ?? ""
                    let groupNameKeyOnly_m = row[1] as? String ?? ""
                    let contentStr_m = row[2] as? String ?? ""
                    
                    let item = KeyboardFavoriteItem(keyOnly: keyOnly_m, groupNameKeyOnly: groupNameKeyOnly_m, contentStr: contentStr_m)
                    favoriteList.append(item)
                }
            }
            completionBlock?(favoriteList)
        } catch {
            debugPrint("dberror: load favorites failed")
        }
    }
    
    
    
}
