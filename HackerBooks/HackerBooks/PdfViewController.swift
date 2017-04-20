import UIKit

class PdfViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var pdf: UIImageView!            // UIWebView!
    
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
        
        /// pdf.delegate = self     // indicamos quien es su delegado    ?????????????????
    }

    
    
    // MARK: Sync Model -> View
    func syncViewWithModel(){
        
        let pdfImage = UIImage(data: model.image._data)
        
        pdf.image = pdfImage
        title = model.titulo
        
        // let request = URLRequest(url: model.urlPdf)
        // pdf.loadRequest(request)
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
        print("carga de pdf terminada")
        
    }
}




