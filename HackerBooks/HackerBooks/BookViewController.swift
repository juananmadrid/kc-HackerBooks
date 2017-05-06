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
    
//    let nc = NotificationCenter.default
//    var notification : NSObjectProtocol?

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
        
        // Cambiamos icono
        if self.model.isFavorite{
            self.model.isFavorite = false
            favoriteItem.image = imageFavOff
            
        }else{
            self.model.isFavorite = true
            favoriteItem.image = imageFavOn
        }
        
    }
    
    
    @IBAction func readPDF(_ sender: Any) {
        
        let pVC = PdfViewController(model: model)
        navigationController?.pushViewController(pVC, animated: true)
    }
    
    
}


// MARK: - Notificaciones

// Notificación de pulsación de favoritos
//extension BookViewController{
//    
//    func suscribeNotify(bookFavoriteChanged book: Book){
//        
//        
//        let notification = Notification(name: BookViewController.notificationName, object: self, userInfo: [BookViewController.bookKey : book])
//        
//        nc.post(notification)
//    }
//    
//    func stopObserve(){
//        
//        if let observer = notification {
//            nc.removeObserver(observer)
//
//        }
//    }
//}








