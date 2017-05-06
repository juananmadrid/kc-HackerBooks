import UIKit
import Foundation


class BookViewController: UIViewController {

    //MARK: - Constants
    static let notificationName = Notification.Name(rawValue: "CharacterDidChangeFavorite")
    static let bookKey = "BookKey"

    // MARK: - Properties
    let model : Book

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    
    let imageFavOn = UIImage(named: "favorite_ON.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    let imageFavOff = UIImage(named: "favorite_OFF.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    
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

        let image = UIImage(data: model.image.data)
        photoView.image = image
        title = model.titulo
        
        if model.isFavorite {
            favoriteItem.image = imageFavOn
        } else {
            favoriteItem.image = imageFavOff
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func favoriteSwitch(_ sender: Any) {
        
        // Actualizamos modelo
        model.isFavorite = !model.isFavorite

        // Cambiamos icono con isFavorite ya actualizado
        if self.model.isFavorite{
            favoriteItem.image = imageFavOn
        }else{
            favoriteItem.image = imageFavOff
        }
        
    }
    
    
    @IBAction func readPDF(_ sender: Any) {
        
        let pVC = PdfViewController(model: model)
        navigationController?.pushViewController(pVC, animated: true)
    }
    
    
}









