import UIKit

class BooksTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellID = "BookCell"
    static let cellHeight : CGFloat = 70.0
    
    fileprivate
    var book : Book?
    let nc = NotificationCenter.default

    // MARK: - IBOutlets
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var authorsBook: UILabel!
    @IBOutlet weak var tagsBook: UILabel!

    
    // Sincronizamos celda con modelo
    // Usamos Delegado y Notificación para reflejar como se hace. Con uno bastaría
    func syncAndObserve(book: Book) {
        
        self.book = book

        book.delegate = self            // Versión Delegado

        suscribeNotify(book: book)      // Versión Notificación
        
        syncWithBook(book: book)
        
    }

    fileprivate
    func syncWithBook(book: Book){
        
        imageBook.image  = UIImage(data: (book.image.data))
        titleBook.text   = book.titulo
        authorsBook.text = book.autores
        tagsBook.text    = book.tagList()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

// Mark: - Observing Notification

extension BooksTableViewCell {
    
    func suscribeNotify(book: Book){
        nc.addObserver(forName: CoverImageDidDownload, object: book, queue: nil) { (n: Notification) in
            self.syncWithBook(book: book)
        }
    }
    
    func stopObserve(){
        
        var bookObserver : NSObjectProtocol?
        
        if let observer = bookObserver{
            nc.removeObserver(observer)
            bookObserver = nil
            book = nil
        }
    }

}


extension BooksTableViewCell: BookDelegate {
    
    func coverImageDidDownload(sender: Book) {
        syncWithBook(book: sender)
    }
}


