//
//  BookViewController.swift
//  HackerBooks
//
//  Created by KRONOX on 4/2/17.
//  Copyright © 2017 kronox. All rights reserved.
//

import UIKit
import Foundation


class BookViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var photoView: UIImageView!
    let model : Book
    
    // MARK: - Inizialization
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
    }

    
    // MARK: - Sync Model -> View
    func syncViewWithModel(){
        photoView.image = model.image
        title = model.titulo
    }
    
    
    // MARK: - Actions
    
    @IBAction func readPDF(_ sender: Any) {
        
        // Creamos pdf
        let pVC = PdfViewController(model: model)
        
        // Hacemos push
        navigationController?.pushViewController(pVC, animated: true)
    }
    
    
    @IBAction func favorites(_ sender: Any) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
