//
//  KEkeyNeInfoPagePreviewVC.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2022/12/10.
//

import UIKit

class KEkeyNeInfoPagePreviewVC: UIViewController {
    let topBar = UIView()
    let bottomCanvasView = UIView()
    let toplabel = UILabel()
    let contentTextV = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.clipsToBounds = true
        
        contentViewSetup()
        
    }
    func contentViewSetup() {
        view.backgroundColor(UIColor(hexString: "FFFAF3")!)
            .clipsToBounds(true)
        //
        topBar.adhere(toSuperview: view)
            .cornerRadius(10)
            .backgroundColor(UIColor(hexString: "D0BBFE")!)
        topBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.height.equalTo(50)
        }
        //
        
        toplabel.adhere(toSuperview: topBar)
            .text("Text Card")
            .color(.black)
            .fontName(16, "Futura-CondensedExtraBold")
        toplabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(10)
        }
        //
        let backBtn = UIButton()
        topBar.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.width.height.equalTo(44)
        }
        backBtn.setImage(UIImage(named: "ic_pop_close"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        //
        bottomCanvasView
            .backgroundColor(UIColor.black)
            .adhere(toSuperview: view)
        bottomCanvasView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(180)
            $0.bottom.equalToSuperview()
        }
        bottomCanvasView.layer.cornerRadius = 10
        bottomCanvasView.clipsToBounds = true
        //
        contentTextV.backgroundColor = .white
        contentTextV.layer.cornerRadius = 10
        contentTextV.clipsToBounds = true
        bottomCanvasView.addSubview(contentTextV)
        contentTextV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.top.equalToSuperview().offset(2)
        }
        contentTextV.font = UIFont(name: "AvenirNext-Medium", size: 16)
        contentTextV.textAlignment = .left
        contentTextV.textColor = .black
        contentTextV.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
         
    }
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let privacyInfoStr: String =
"""
Privacy Policy for MYVID
At MYVID, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by MYVID and how we use it.

If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.

Log Files
MYVID follows a standard procedure of using log files. These files log visitors when they use app. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the app, tracking users' movement on the app, and gathering demographic information.

Our Advertising Partners
Some of advertisers in our app may use cookies and web beacons. Our advertising partners are listed below. Each of our advertising partners has their own Privacy Policy for their policies on user data. For easier access, we hyperlinked to their Privacy Policies below.

Google

https://policies.google.com/technologies/ads

Privacy Policies
You may consult this list to find the Privacy Policy for each of the advertising partners of MYVID.

Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Beacons that are used in their respective advertisements and links that appear on MYVID. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on this app or other apps or websites.

Note that MYVID has no access to or control over these cookies that are used by third-party advertisers.

Third Party Privacy Policies
MYVID's Privacy Policy does not apply to other advertisers or websites. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.

Children's Information
Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.

MYVID does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our App, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.

Online Privacy Policy Only
This Privacy Policy applies only to our online activities and is valid for visitors to our App with regards to the information that they shared and/or collect in MYVID. This policy is not applicable to any information collected offline or via channels other than this app. Our Privacy Policy was created with the help of the App Privacy Policy Generator from App-Privacy-Policy.com

Consent
By using our app, you hereby consent to our Privacy Policy and agree to its Terms and Conditions.

Generated using App Privacy Policy Generator
"""
    
    let termsofInfoStr: String =
"""
Terms and Conditions
Welcome to MYVID!

These terms and conditions outline the rules and regulations for the use of MYVID.

By using this app we assume you accept these terms and conditions. Do not continue to use MYVID if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the App Terms and Conditions Generator from App-Privacy-Policy.com

License
Unless otherwise stated, MYVID and/or its licensors own the intellectual property rights for all material on MYVID. All intellectual property rights are reserved. You may access this from MYVID for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

Republish material from MYVID
Sell, rent or sub-license material from MYVID
Reproduce, duplicate or copy material from MYVID
Redistribute content from MYVID
This Agreement shall begin on the date hereof.

Parts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the website. MYVID does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of MYVID, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, MYVID shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.

MYVID reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

You are entitled to post the Comments on our App and have all necessary licenses and consents to do so;
The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy
The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant MYVID a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.

Hyperlinking to our App
The following organizations may link to our App without prior written approval:

Government agencies;
Search engines;
News organizations;
Online directory distributors may link to our App in the same manner as they hyperlink to the Websites of other listed businesses; and
System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.
These organizations may link to our home page, to publications or to other App information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

commonly-known consumer and/or business information sources;
dot.com community sites;
associations or other groups representing charities;
online directory distributors;
internet portals;
accounting, law and consulting firms; and
educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of MYVID; and (d) the link is in the context of general resource information.

These organizations may link to our App so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our App, you must inform us by sending an e-mail to MYVID. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our App, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our App as follows:

By use of our corporate name; or
By use of the uniform resource locator being linked to; or
By use of any other description of our App being linked to that makes sense within the context and format of content on the linking party’s site.
No use of MYVID's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our App.

Content Liability
We shall not be hold responsible for any content that appears on your App. You agree to protect and defend us against all claims that is rising on our App. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Your Privacy
Please read Privacy Policy.

Reservation of Rights
We reserve the right to request that you remove all links or any particular link to our App. You approve to immediately remove all links to our App upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our App, you agree to be bound to and follow these linking terms and conditions.

Removal of links from our App
If you find any link on our App that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.

Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our App and the use of this website. Nothing in this disclaimer will:

limit or exclude our or your liability for death or personal injury;
limit or exclude our or your liability for fraud or fraudulent misrepresentation;
limit any of our or your liabilities in any way that is not permitted under applicable law; or
exclude any of our or your liabilities that may not be excluded under applicable law.
The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.

As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.

Generated using App Privacy Policy Generator
"""
}
