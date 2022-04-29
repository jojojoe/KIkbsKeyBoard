//
//  KIkbsDataManager.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/26.
//

import UIKit


enum SpecialStrType {
    case symbol
    case quote
    case emojiStr
    case shape
}

struct SpecialStrBundle: Codable {
    var titleName: String
    var specialStrList: [String]
    var isPro: Bool = false
    
}

struct TextCardThemeColor: Codable {
    var bgColor: String
    var normalTextColor: String
    var hilightTextColors: [String]
    
    
}

struct TextCardThemeFontItem {
    var contentStr_low = ""
    var contentStr_up = ""
}

struct TextCardThemeOverlayerItem: Codable {
    var thumb = ""
    var big = ""
}




class KIkbsDataManager: NSObject {
    static let `default` = KIkbsDataManager()
    var specialSymbolList : [SpecialStrBundle] {
        return KIkbsDataManager.default.loadJson([SpecialStrBundle].self, name: "specialSymbolList") ?? []
    }
    
    var specialQuoteList: [SpecialStrBundle] {
        return KIkbsDataManager.default.loadJson([SpecialStrBundle].self, name: "specialQuoteList") ?? []
    }
    
    var specialEmojiStrList: [SpecialStrBundle] {
        return KIkbsDataManager.default.loadJson([SpecialStrBundle].self, name: "specialEmojiStrList") ?? []
    }
    
    var specialShapeList: [SpecialStrBundle] = []
    
    var textCardThemeColorList: [TextCardThemeColor] {
        
        return KIkbsDataManager.default.loadJson([TextCardThemeColor].self, name: "textCardThemeColor") ?? []
    }
    
    var textCardThemeOverlayerList: [TextCardThemeOverlayerItem] {
        return KIkbsDataManager.default.loadJson([TextCardThemeOverlayerItem].self, name: "textCardOverlayerImg") ?? []
    }
    
    var textCardThemeNormalFontList: [String] = []
    var textCardThemeHilightFontList: [String] = []
    
    
    
    override init() {
        super.init()
        loadData()
    }
    
    func loadData() {
        
        let shape1Bundle = SpecialStrBundle.init(titleName: "Cute", specialStrList: komojiArray, isPro: true)
        let shape2Bundle = SpecialStrBundle.init(titleName: "Cartoon", specialStrList: komoji2Array, isPro: true)
        specialShapeList = [shape1Bundle, shape2Bundle]
        textCardThemeNormalFontList = [Font_Avenir_Heavy, Font_AvenirNext_Medium]
        textCardThemeHilightFontList = ["KohinoorGujarati-Bold", "Menlo-Regular", "MyanmarSangamMN-Bold", "NotoSansMyanmar-Regular", "NotoSansOriya-Bold"]
        
        
    }
    
    func randomQuoteStr() -> String {
        let quoteList: [String] = ["Hello1 world! you are very beautiful. king of the world Hello1 world! you are very beautiful. king of the world Hello1 world! you are very beautiful. king of the world Hello1 world! you are very beautiful. king of the world Hello1 world! you are very beautiful. king of the world", "Hello2 world! you are ", "Hello3 world! you are very beautiful. king of the world", "Hello4 world! you are very beautiful. king of the world"]
        let str = quoteList.randomElement() ?? ""
        return str
    }
    
    let komojiArray = [
            """
            ｡*☆∴｡　     ｡∴☆*｡
            ｡★*ﾟﾟ*★∵★*ﾟﾟ*★｡
            ☆ﾟ　　  ﾟ☆ﾟ　　   ﾟ☆
            ★*                         *★
            ﾟﾟﾟﾟﾟﾟﾟﾟ☆｡ ♥ LOVE. ♥ ｡☆ﾟ
            *★｡               ｡★*
            ∵☆｡ 　　 ｡☆∵
            ﾟﾟﾟﾟﾟﾟﾟﾟ*★｡ ｡★*ﾟ
            　ﾟ *☆
            """,
            """
            ｡:💖・｡･ﾟ🌸*.ﾟ｡
            ･💠.💜ﾟ.🌼🍏｡:*･.💛
            .ﾟ❤.｡;｡🍓.:*🍇.ﾟ｡🍊｡
            :*｡_💠👝｡_💮*･_ﾟ👛
            ＼ξ　＼　 ζ／
            ∧🎀∧＼ ξ
            （*･ω･ )／
            c/　 つ∀o
            しー-Ｊ おめでとう～🎉
            """,
                    """
                    ☆ *　. 　☆
                    　　        .  ∧＿∧　∩　* ☆
                    * ☆ ( ・∀・)/ .
                    　. ⊂　　  ノ* ☆
                    ☆ * (つ ノ .☆
                    (ノ
                    """,
                    """
                    ▄▄▄▄██〓█●
                    ▂▃▄▅█████▅▄
                    ████████████████
                    ◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤
                    　　ヽ(´･ω･)ﾉ
                    """,
            """
               🌷🌸🌷🌸
               🌸🌷🌸🌷🌸
             Λ🌷🌸🌷🌸🌷
            ( ˘ ᵕ ˘🌷🌸🌷
             ヽ  つ＼\\   ／
                UU   / 🎀 \\
            """,
    ]
    
    let komoji2Array = [
        
        """
        / )))　　　   _
        ／ イ  　　　(((
        (　ﾉ　　　　 ￣Ｙ＼
         |　(＼  ∧＿∧  ｜　)
        ヽ　ヽ`(´･ω･)_／ノ/
        　＼ |　⌒Ｙ⌒　/ /
        　  \\    　  ﾉ／
        　　＼ ﾄー仝ーｲ /
        　　 ｜  ミ土彡 ｜
        　　  )　　　 ｜
        """,
        
        
        """
        ╭﹌☆﹌﹌﹌☆﹌╮
        ∣　　　　　　　∣
        ∣　●　　　●  ∣
        ∣　　　▽　　　∣
        ╰—————--——--╯
          ∣　﹏　﹏　∣
            ╰∪———∪╯
        """,
        """
          ∩ ∩
        （´･ω･）
           ＿|　⊃／(＿＿_
          ／ └-(＿＿＿_／
          ￣￣￣￣￣￣￣
        """,
        """
            ∧ ＿ ∧
        　　(　･∀･)
        　　(　つ┳⊃
         　ε(_)へ⌒ヽﾌ
        　 (　　(　･ω･)
         ≡≡≡　◎―◎ ⊃ ⊃
        """,
        """
        　　　　　　  ∧＿∧
        　　∧＿∧ 　（´<_`︵）
        　（´_ゝ`） 　/　　　ｉ
        　／　　＼　/　　　｜|
        　／　　/￣￣￣￣￣/｜
        ＿(ニっ/　　　　　/　｜＿＿＿＿
        　　＼/＿＿＿＿＿/　(u　 ⊃
        """,
        
        """
              ／￣￣＼
        　　 ／ 　〇・   ＞
        　 ／　 　ε　   │
         ／　　 　〇・  ＞
        (つ＿と＼＿＿／
         ∪　∪
        """,
        """
        ◢████◣
        █＞_＜ █
        ╰——┰——╯
        　┕█┙
        """,
        """
          Λ _ Λ
         (　 ·ω·)
         ( つ 　≡つ
         / __ 　)
         Ｕ ／ Ｕ
        """,
        """
        |―-∩
        |　　ヽ
        |　●　|
        |▼) _ノ
        |￣　)
        (￣ 　／
        T￣|
        """,
        """
           へ　　　　　／|
        　/＼7　　　 ∠＿/
         /　│　　 ／　／
        │　Z ＿,＜　／　　 /`ヽ
        │　　　　　ヽ　　 /　　〉
         Y　　　　　`　 /　　/
        ｲ●　､　●　　⊂⊃〈　　/
        ()　 へ　　　　|　＼〈
        　>ｰ ､_　 ィ　 │ ／／
         / へ　　 /　ﾉ＜| ＼＼
         ヽ_ﾉ　　(_／　 │／／
        　7　　　　　　　|／
        　＞―r￣￣`ｰ―＿／
        """,
        """
                  ∧ ＿ ∧
          ∧ ＿ ∧  (・ω・｡)
        （´・ω ・)  (nnノ)
         （つ　つΓΞΞΞΞΞΞΞΙ
          しーＪ
        """,
        """
          ∩＿＿＿_∩
        |ノ　　　　 ヽ
        |　  ●　　 ● |
        彡　*( _,●_)*ミ
        |   │´・ω・ |│
        | ＿ ￣￣￣    _|
        | ∪　　　　 ∪
        ＼__　　 　 _/
        　　∪￣∪
        """,
        """
        ┏┛┻━━━━━━┛┻┓
        ┃｜｜｜｜｜｜｜┃
        ┃　　　━　　　┃
        ┃　┳┛ 　┗┳ 　┃
        ┃┃
        ┃　　　┻　　　┃
        ┃┃
        ┗━┓　　　┏━┛
        　　┃　   　┃
        　　┃　   　┃
        　　┃　   　┃
        　　┃　　　┗━━━┓
        　　┃         ┣┓
        　　┃         ┃
        　　┗┓┓┏━┳┓┏┛
        　　　┃┫┫　┃┫┫
        　　　┗┻┛　┗┻┛
        """,
        """
              ∧_∧::
        　　 (´･ω･`)::
        　 /⌒　　⌒)::
        　/ へ_＿/ /::
         (＿＼＼ﾐ)/::
        　 ｜ `-イ::
        　 /ｙ　 )::
        　/／　／::
         ／　／::
        (　く:::
        |＼ ヽ:::
        
        """,
        """
              ＿＿＿
        　　 ／　　　▲
        ／￣　 ヽ　■■
        ●　　　　　■■
        ヽ＿＿＿　　■■
        　　　　）＝｜
        　　　／　｜｜
        　∩∩＿＿とﾉ
        　しし———┘
        """,
        """
         Δ~~~~Δ
        ξ •ェ• ξ
         ξ　~　ξ
         ξ　　 ξ
         ξ　　　“~～~～〇
         ξ　　　　　　 ξ
         ξ　ξ　ξ~～~ξ　ξ
         ξ_ξξ_ξ　ξ_ξξ_ξ
        """,
        """
        ｡　,∧ ＿ ∧　ﾟ。
        ・（ﾟ´Д｀ﾟ ）。
          （つ　　 ⊃
            　ヾ(⌒ﾉ
        　　  　` J
        """,
        
    ]
}
extension KIkbsDataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
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
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}
