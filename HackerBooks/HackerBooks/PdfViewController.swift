import UIKit

class PdfViewController: UIViewController {

    // MARK: - Properties
    // @IBOutlet weak var pdf: UIImageView!            // UIWebView!
    
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
        
    }

    
    
    /////    PENIENTE: NOTIFICACIÓN PARA LLAMAR A syncViewWithModel cdo cargue web  /////
    
    
    // MARK: Sync Model -> View
    func syncViewWithModel(){
        
        pdf.load(model.pdf.data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"https://www.google.com")!)
    }

}


/// Quitamos spinner, en su lugar cargamos defaultImage mientras carga
// MARK: - UIWebViewDelegate
//extension PdfViewController: UIWebViewDelegate {
//    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//
//        spinner.isHidden = false
//        spinner.startAnimating()
//    }
//    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//
//        spinner.isHidden = true
//        spinner.stopAnimating()
//        print("carga de pdf terminada")
//        
//    }
//}




