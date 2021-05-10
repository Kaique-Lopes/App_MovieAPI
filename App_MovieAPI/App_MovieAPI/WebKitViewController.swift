//
//  WebKitViewController.swift
//  App_MovieAPI
//
//  Created by Kaique Lopes on 10/05/21.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    @IBOutlet weak var webKit: WKWebView!
    var photo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = URL(string:"\(REST.baseUrlImage)\(photo ?? "")")!
        let request = URLRequest(url: link)
        webKit.load(request)
    }
}
