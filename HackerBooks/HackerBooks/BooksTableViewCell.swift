import UIKit

class BooksTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellID = "BookCell"
    static let cellHeight : CGFloat = 70.0
    
    private
    var book : Book?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var authorsBook: UILabel!
    @IBOutlet weak var tagsBook: UILabel!
    
    // private
    func syncWithBook(book: Book) {
        
        self.book = book
        
        imageBook.image = UIImage(data: (book.image._data))
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
