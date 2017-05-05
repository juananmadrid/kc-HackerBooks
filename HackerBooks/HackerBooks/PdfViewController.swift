import UIKit

class PdfViewController: UIViewController {

    // MARK: - Properties
    // @IBOutlet weak var pdf: UIImageView!            // UIWebView!
    
    @IBOutlet weak var pdf: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var model: Book?
    let nc = NotificationCenter.default

    
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
        
        startNotify(book: model!)
        
        syncViewWithModel(book: model!)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        stopObserve()
    }
    
    
    // MARK: Sync Model -> View
    func syncViewWithModel(book: Book){
        
        pdf.load(book.pdf.data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"https://www.google.com")!)
    }

}



extension PdfViewController {
    
    func startNotify(book: Book){
        nc.addObserver(forName: PDFDidDownload, object: book, queue: nil) { (n: Notification) in
            self.syncViewWithModel(book: book)
        }
    }
    
    func stopObserve(){
        
        var bookObserver : NSObjectProtocol?
        
        if let observer = bookObserver{
            nc.removeObserver(observer)
            bookObserver = nil
            model = nil
        }
    }
    
}

