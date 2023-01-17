//
//  ConfigTool.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/17.
//

import Foundation
import Defaults
import NoticeObserveKit

let Font_AvenirNext_Medium = "AvenirNext-Medium"
let Font_Avenir_Heavy = "Avenir-Heavy"

public enum IAPType: String {
    case year = "com.temporary.year"
    case month = "com.temporary.month"
    case week = "com.temporary.week"
    case life = "com.temporary.left"
}


var FeedbackEmail: String = ""
var AppBundleID: String = "com.xxx"
var IAPsharedSecret: String? = nil


extension Defaults.Keys {
    static let localIAPReceiptInfo = Key<Data?>("Purchase.localIAPReceiptInfo")
    static let localIAPProducts = Key<[KIkbsPurchaseManager.IAPProduct]?>("Purchase.LocalIAPProducts")
    static let localIAPCacheTime = Key<TimeInterval?>("Purchase.localIAPCacheTime")
    
}

extension Notice.Names {
    static let receiptInfoDidChange =
        Notice.Name<Any?>(name: "ReceiptInfoDidChange")
    
//    Notice.Center.default
//        .post(name: Notice.Names.receiptInfoDidChange, with: nil)
    
}

let privacyInfoStr: String =
"""
Privacy Policy for Art Text

At Art Text, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Art Text and how we use it.

If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.

Log Files

Art Text follows a standard procedure of using log files. These files log visitors when they use app. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the app, tracking users' movement on the app, and gathering demographic information.

Our Advertising Partners

Some of advertisers in our app may use cookies and web beacons. Our advertising partners are listed below. Each of our advertising partners has their own Privacy Policy for their policies on user data. For easier access, we hyperlinked to their Privacy Policies below.

Privacy Policies

You may consult this list to find the Privacy Policy for each of the advertising partners of Rainbow Lights.

Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Beacons that are used in their respective advertisements and links that appear on Rainbow Lights. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on this app or other apps or websites.

Note that Rainbow Lights has no access to or control over these cookies that are used by third-party advertisers.

Third Party Privacy Policies

Rainbow Lights's Privacy Policy does not apply to other advertisers or websites. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.

Children's Information

Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.

Rainbow Lights does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our App, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.

Online Privacy Policy Only

This Privacy Policy applies only to our online activities and is valid for visitors to our App with regards to the information that they shared and/or collect in Rainbow Lights. This policy is not applicable to any information collected offline or via channels other than this app.

Consent

By using our app, you hereby consent to our Privacy Policy and agree to its Terms and Conditions.
"""

let termsofInfoStr: String =
"""
Terms of Use
Art Text (hereinafter referred to as "we") provide users (hereinafter referred to as "you") with<i>Text conversion</i>Serve. This Agreement is legally binding on both you and us.


1. Enter text, which can be converted into multiple fonts, Thousands of emojis and special symbols can be used at will, You can bookmark frequently used copy to favorites and then use it quickly and quickly in your keyboard, You can also make text cards and save them to an Photos

2. Scope and Limitation of Liability

The results you get by using this service are for reference only, and the actual situation is subject to the official website.

3. Privacy Protection

We attach great importance to the protection of your privacy, and your personal privacy information will be protected and regulated in accordance with the "Privacy Policy", please refer to the "Privacy Policy" for details.

4. Other terms

4.1 The headings of all clauses in this agreement are for reading convenience only, have no actual meaning in themselves, and cannot be used as the basis for the interpretation of the meaning of this agreement.

4.2 For any reason, the terms of this Agreement are partially invalid or unenforceable, the remaining terms shall remain valid and binding on both parties.

"""

let subscribeInfoStr: String =
"""
Art Text VIP Subscriptions

You can subscribe to Art Text VIP to get all the fonts, special symbols in the app.


Art Text VIP provides some subscription. The subscription price is:

$19.99/year

$4.99/year

$0.99/year

Payment will be charged to iTunes Account at confirmation of purchase.

Subscriptions will automatically renew unless auto-renew is turned off at least 24 hours before the end of the current subscription period.

Your account will be charged for renewal 24 hours before the end of the current period, and the renewal fee will be determined.

Subscriptions may be managed by the user and auto-renewal may also be turned off in the user&#39;s Account Settings after purchase.

If any portion of the offered free trial period is unused, the unused portion will be forfeited if the user purchases a subscription for that portion, where applicable.

If you do not purchase an auto-renewing subscription, you can still use our app as normal, and any unlocked content will work normally after the subscription expires.
"""
