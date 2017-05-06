import Foundation
import UIKit

class Book {
    
    // MARK: - Stored Properties
    let titulo      :   String
    let autores     :   String
    var tags        :   Tags
    let image       :   AsyncData
    let pdf         :   AsyncData
    
    weak var delegate : BookDelegate?
    
    // MARK: - Inizialization
    
    init(title: String,
         authors: String,
         tags: Tags,
         photo: AsyncData,
         pdf: AsyncData){
        
        titulo = title
        autores = authors
        self.tags = tags
        image = photo
        self.pdf = pdf
        
        image.delegate = self
        pdf.delegate = self
    }
    
    // MARK: - Proxies
    func proxyForEquality() -> String{
        return "\(titulo)\(autores)\(pdf)"
    }
    
    func proxyForComparison() -> String{
        return proxyForEquality()
    }
    
    func tagList () -> String {
        return tags.sorted().map{$0.name}.joined(separator: ", ").capitalized
    }

}

// MARK: - Favoritos

extension Book {
    
    func addTagFavorito() {
        
        let tagFavorito = Tag(tagName: "Favorito")
        tags.insert(tagFavorito)
    }
    
    func removeTagFavorito() {
        
        let tagFavorito = Tag(tagName: "Favorito")
        tags.remove(tagFavorito)
    }
    
    
    var isFavorite : Bool{
        
        get{
            return self.isFavorite
        }
        
        set{
            if newValue == true{
                
                // Añadimos Tag favorito en Book
                addTagFavorito()
                // Notificación para añadir Tag en Multidict (Library)
                // y para recargar tabla que actualice Tag Favorito
                notify(nameNotification: BookDidChange)
                
            }else{
                
                // Borramos Tag favorito en Book
                removeTagFavorito()
                //  Notificación para borrar Tag en Multidict y recargar tabla
                notify(nameNotification: BookDidChange)
            }
        }
    }
}



// MARK: - Protocols

extension Book: Equatable{

    public static func ==(lhs: Book,
                          rhs: Book) -> Bool{
        return (lhs.proxyForEquality() == rhs.proxyForEquality())
    }
}

extension Book: Comparable{
    
    public static func <(lhs: Book,
                         rhs: Book) -> Bool{
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

extension Book : CustomStringConvertible{
    
    public var description: String{
        get{
            return "<\(type(of:self)): \(titulo) -- \(autores)>"
        }
    }
}

extension Book: Hashable{
    
    var proxyForHashing : String{
        get{
            return "\(titulo)\(autores)"
        }
    }
    var hashValue: Int {
        return proxyForHashing.hashValue
    }
}


// MARK: - DELEGATE

protocol BookDelegate: class {

    func bookDidChange(sender: Book)
    func coverImageDidDownload(sender: Book)
    func pdfDidDownload(sender: Book)
}

extension BookDelegate {
    
    func bookDidChange(sender: Book) {}
    func coverImageDidDownload(sender: Book) {}
    func pdfDidDownload(sender: Book) {}
}

// MARK: - NOTIFICATIONS

// To BookTableViewCell (cuando carga coverImage)
let CoverImageDidDownload = Notification.Name(rawValue: "BookCoverImageDidDownload")
// To PdfViewController (cuando carga pdf)
let PDFDidDownload = Notification.Name(rawValue: "BookPDFDidDownload")
// To LibraryViewController (cuando cambia Favorito)
let BookDidChange = Notification.Name(rawValue: "BookDidChange")


extension Book {
    
    // Notificación común para los 3 tipos de notificaciones, solo cambia Notification.Name
    func notify(nameNotification: Notification.Name) {
        let nc = NotificationCenter.default
        let notification = Notification(name: nameNotification, object: self, userInfo: ["BookChange": self])
        nc.post(notification)
    }
}

// MARK: - ASYNCDATADELEGATE

extension Book: AsyncDataDelegate {
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL){
        
        if sender == image {
            delegate?.coverImageDidDownload(sender: self)
            notify(nameNotification: CoverImageDidDownload)
        }
        if sender == pdf {
            notify(nameNotification: PDFDidDownload)
        }
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL){
        print("Start Loading from \(url)")
    }
        

}


