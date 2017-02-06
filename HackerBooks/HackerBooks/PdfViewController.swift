//
//  PdfViewController.swift
//  HackerBooks
//
//  Created by KRONOX on 5/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var pdf: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var model: Book
    
    // MARK: - Inizialization
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        syncViewWithModel()
        
        pdf.delegate = self     // indicamos quien es el delegado
    }


    
    
    // MARK: Sync Model -> View
    func syncViewWithModel(){
        
        // let request = URLRequest(url: model.urlPdf)
        let kronox = URL(fileURLWithPath: "https://en.wikipedia.org/wiki/Yoda")
        let request = URLRequest(url: kronox)
        pdf.loadRequest(request)
    }

}

// MARK: - UIWebViewDelegate
extension PdfViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {

        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        spinner.isHidden = true
        spinner.stopAnimating()
        
    }
}
