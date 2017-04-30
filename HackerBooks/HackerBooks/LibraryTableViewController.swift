import UIKit
import Foundation

class LibraryTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    
    // MARK: - Properties
    var model : Library
    
    weak var delegate : LibraryTableViewController? = nil
    
    
    // MARK: - Inizialization
    init(model: Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table View Delegate
    
    // Método al que se llama al seleccionar una celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                                            // indexPath tiene 2 secciones: Section y Row
        
        // Descubrimos cual es el Tag seleccionado
        let tag = model.tagsArray[indexPath.section]
        
        // Descubrimos el libro seleccionado
        let book = model.book(forTagName: tag.name, at: indexPath.row)
        
        // Pusheamos
        let bookVC = BookViewController(model: book!)
        self.navigationController?.pushViewController(bookVC, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return model.tagsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Obtenemos tag seleccionado
        let tagName  = model.tagsArray[section].name
        
        // Obtenemos nº book en ese tag
        return model.bookCount(forTagName: tagName)
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForFooterInSection section: Int) -> String? {
        
        return model.tagsArray[section].name
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                            // indexPath tiene 2 secciones: Section y Row
        
        // Definir un Id para el tipo de celda (para pedir celda reutilizada)
        let cellId = "BookCell"
        
        // Averiguar el Tag
        let tag = model.tagsArray[indexPath.section]
        
        // Averiguar el libro
        let book = model.book(forTagName: tag.name, at: indexPath.row)

        // Creamos la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil{
            // Creamos nueva celda
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellId)
        }
        
        // Configuramos celda
        let image = UIImage(data: (book?.image._data)!)
        
        cell?.imageView?.image        =   image
        cell?.textLabel?.text         =   book?.titulo
        cell?.detailTextLabel?.text   =   tagArraytoString(fromArrayTags: (book?.tags)!)
        cell?.detailTextLabel?.text   =   book?.autores
        
        // Devolverla
        return cell!
    }
    
    
    
    // MARK: - Utils
    
    // Función para convetir array de Tag en string
    func tagArraytoString(fromArrayTags arraytags: [Tag]) -> String{
        
        var array : [String] = []
        for elem in arraytags{
            array.append(elem.name)
        }
        array.sort()
        return array.joined(separator: ",")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // suscribe()                 // Nos suscribimos a la notificación

    }

    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribe()
        
    }

}


//MARK: - Notifications
 extension LibraryTableViewController{
    
    
//    func suscribe(){
//        
//        let nc = NotificationCenter.default
//        
//        nc.addObserver(forName: BookViewController.notificationName, object: nil, queue: OperationQueue.main) { (note: Notification) in
//            
//            // extraemos libro a modificar y su estado de isFavorite
//            let userInfo = note.userInfo
//            let book = userInfo?[BookViewController.bookKey] as? Book
//            
//            // localizamos libro en array de libros
//            let index = self.model.books.index(of: book!)
//            let bookSelect = self.model.books[index!]
//            
//            // Añadimos a favoritos
//            if let newFavoritos = book?.isFavorite {
//                
//                // cambiamos flag en libro
//                bookSelect.isFavorite = true
//                
//                // Creamos nuevo Tag Favoritos
//                let favoritos = Tag(tagName: "Favoritos")
//                favoritos.isFavorite = true
//                
//                // añadimos tag en array de TAg
//                self.model.tags.append(favoritos)
//                
//                // añadimos tag y libro a Multidictionary
//                self.model.mdict.insert(value: bookSelect.titulo, forKey: favoritos.name)
//                
//            // Eliminamos de favoritos
//            } else{
//                // cambiamos flag en libro
//                bookSelect.isFavorite = false
//                
//                // elimina tag en array de Tag
//                let favoritos = Tag(tagName: "Favoritos")
//                let indexTag = self.model.tags.index(of: favoritos)
//                self.model.tags.remove(at: indexTag!)
//                
//                // Sacamos libro de Multidiccionario con Tag Favoritos
//                self.model.mdict.remove(value: bookSelect.titulo, fromKey: "Favoritos")
//                
//                // Si no hay más libros en Tag favotiros de Multidictionary el Tag
//                // Favoritos se elimina automáticamente
//                
//            }
//        }
//
//    }
    
    
    func unsubscribe(){

        let nc = NotificationCenter.default
        
        nc.removeObserver(self)                 // Nos da de baja de TODAS las notificaciones (Observer yo mismo)
        
    }
 
    
}


