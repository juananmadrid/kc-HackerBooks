import Foundation

class Library{
    
    // MARK: Utility types
    typealias BooksArray = [Book]
    typealias Multidictionary = MultiDictionary<Tag, Book>
    
    // MARK: - Properties
//    var books 	: [Book]               // Array de libros
//    var tags    : Set<Tag>
    var mdict   : Multidictionary

    
    // MARK: - Initialization
    init(bookArray : BooksArray){
        
//        books 	= 	[]
//        tags    = 	[]
        mdict 	= 	Multidictionary()
        
        bookLoad(array: bookArray)
        
    }
    
    // Carga multidiccionario desde [Book]
    private
    func bookLoad(array: [Book]) {
        
        for book in array{
            for tag in book.tags{
                mdict.insert(value: book, forKey: tag)
            }
        }
        
//        for book in array{
//            
//            // Asigno a books
//            books.append(book)
//            
//            // Asigno a tags
//            for element in book.tags{
//                tags.insert(element)
//            }
//            
//            // Asigno a mdict
//            for tag in book.tags{
//                
//                var bucket = Set<String>()      // creo set vacío
//                bucket.insert(book.titulo)      // inserto titulo del libro
//                mdict[tag.name] = bucket        //
//            }
//        }
    }

    
    // MARK: - Accesors
    
    
    // Nº Total de LIBROS
    var booksCount: Int{
        get{
            // let count: Int = self.books.count
            let count: Int = self.mdict.countUnique
            return count
        }
    }

    // Nº total de TAGS ó SECCIONES
    var tagCount: Int{
        get{
            // let countTag : Int = self.tags.count
            let countTag: Int = self.mdict.countBuckets
            return countTag
        }
    }
    
    // Nº total de libros por tag. Si no existe el tag devolvemos 0
    func bookCount(forTagName name: String) -> Int{

        let tag = Tag(tagName: name)
        
        if let bucket = mdict[tag] {
            return bucket.count
        } else {
            return 0
        }
    }
    
    // Array de libros (instancias de Book) que hay por Tag.
    // Si no hay libros en un Tag devolvemos nil (opcional vacío)
    func books(forTagName name: String) -> [Book]?{
        
        let tag = Tag(tagName: name)
        
        guard let books = mdict[tag] else {
            return nil
        }
        if books.count == 0 {
            return nil
        }
        return books.sorted()
    }

    // Array de Tag ordenado extraído del Multidiccionario _books
    var tagsArray : [Tag]{
        get{
            return mdict.keys.sorted()
        }
    }
    
    // AGTBook para el libro que está en la posición index de aquellos bajo un cierto tag
    // Devuelve libro que está en posición index
    // Si el index no existe o el tag no existe, devolvemos nil
    func book(forTagName name: String, at:Int?) -> Book?{
        
        // Comprobamos que existe index
        if let index = at {
            // Obtenemos array de libros en ese Tag
            let booksTag = books(forTagName: name)
            let book = booksTag?[index]
            return book
            
        }else{
            return nil
        }
    }
    
    
    var isEmpty: Bool{
        get{
            let empty : Bool = mdict.isEmpty
            return empty
        }
    }
    
    var countBooks: Int{                   // Nº Total de LIBROS (sin repetir)
        get{
            let countb : Int = mdict.countUnique
            return countb
        }
    }
    
    var countCubos: Int{                    // Nº Total de LIBROS q aparecen (con repetidos)
        get{
            let countcub : Int = mdict.count
            return countcub
        }
    }
    

    
    
    
    
}







