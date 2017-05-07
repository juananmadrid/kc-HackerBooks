import UIKit
import Foundation

class LibraryTableViewController: UITableViewController {
    
    // MARK: - Properties
    var model : Library
    weak var delegate : LibraryTableViewControllerDelegate?

    let nc = NotificationCenter.default
    var notification : NSObjectProtocol?

    
    // MARK: - Inizialization
    init(model: Library, style: UITableViewStyle = .plain){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "HackerBooks"
    }
    
    deinit {
        stopObserve()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()       // Registro de celdas personalizadas
        
        suscribeNotify()
    }

    //MARK: - Cell personalized registration
    private func registerNib(){
        
        let nib = UINib(nibName: "BooksTableViewCell", bundle: Bundle.main)
        
        tableView.register(nib, forCellReuseIdentifier: BooksTableViewCell.cellID)
    }

    
    // MARK: - Table View Delegate
    
    // Creación de la table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Id para reutilizar celda. Ahora se implementa en BooksTableViewCell
        // let cellId = "BookCell"
        
        // Averiguar el Tag
        let tag = model.tagsArray[indexPath.section]
        
        // Averiguar el libro
        let book = model.book(forTagName: tag.name, at: indexPath.row)
        
        // Creamos la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.cellID, for: indexPath) as! BooksTableViewCell
        // var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
//        if cell == nil{
//            // Creamos nueva celda
//            cell = UITableViewCell(style: .subtitle,
//                                   reuseIdentifier: cellId)
//        }
        
        // Configuramos celda
//        let image = UIImage(data: (book?.image._data)!)
//        cell?.imageView?.image        =   image
//        cell?.textLabel?.text         =   book?.titulo
//        cell?.detailTextLabel?.text   =   tagArraytoString(fromArrayTags: (book?.tags)!)
//        cell?.detailTextLabel?.text   =   book?.autores
        
        // Sync model (book) -> View (cell)
        cell.syncAndObserve(book: book!)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! BooksTableViewCell
        cell.stopObserve()
    }
    
    
    // Definimos altura de la celda
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BooksTableViewCell.cellHeight
    }

    
    // Método al que se llama al seleccionar una celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                                            // indexPath tiene 2 secciones: Section y Row
        
        // Descubrimos cual es el Tag seleccionado
        let tag = model.tagsArray[indexPath.section]
        
        // Descubrimos el libro seleccionado
        let book = model.book(forTagName: tag.name, at: indexPath.row)
        
        if DeviceType.IS_IPHONE {
            // Pusheamos
            let bookVC = BookViewController(model: book!)
            self.navigationController?.pushViewController(bookVC, animated: true)
        }
        
        if DeviceType.IS_IPAD {
            
            delegate?.bookDidSelect(sender: book!)
        }
        
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return model.tagsArray[section].name
    }
    
    
    // MARK: - Utils
    
    // Función para convetir array de Tag en string
    func tagArraytoString(fromArrayTags arraytags: [Tag]) -> String{
        
        var array : [String] = []
        for elem in arraytags{
            array.append(elem.name)
        }
        array.sort()
        return array.joined(separator: ", ")
    }
    
}


// MARK: - Notifications

extension LibraryTableViewController{
    
    func suscribeNotify(){
        
        _ = nc.addObserver(forName: BookDidChange, object: nil, queue: nil) { (n: Notification) in
            self.tableView.reloadData()
        }
    }
    
    func stopObserve(){
        
        if let observer = notification {
            nc.removeObserver(observer)
        }
    }
    
}

// MARK: - Delegate

protocol LibraryTableViewControllerDelegate: class {
    
    func bookDidSelect(sender: Book)
    
}

extension LibraryTableViewControllerDelegate {
    
    func bookDidSelect(sender: Book) {}
}

