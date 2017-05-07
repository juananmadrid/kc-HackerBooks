import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Borramos cachés
        AsyncData.removeAllLocalFiles()

        // Creamos una windows de verdad, no opcional
        window = UIWindow(frame: UIScreen.main.bounds)
    
        
            // cargamos json
        do{
        
            // Validamos url del json en local
            guard let url = Bundle.main.url(forResource: "books_readable", withExtension: "json") else{
                fatalError("Unable to read json file!")
            }
            
            // Decodificamos json y obtenemos array de diccionarios
            let data = try Data(contentsOf: url)
            let maybeArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONArray
            
            // Creamos array de clases tipo Book decodificando json
            var books = [Book]()
            
            guard let jsonArray = maybeArray else {
                throw LibraryError.emptyJSONObject
            }
            
            // Convertimos array de diccionarios en array de libros
            for book in jsonArray!{
                do{
                    let book = try decode(book: book)
                    books.append(book)
                }catch{
                    print("Error al procesar \(book)")
                }
                
                books.sort()        // Ordenamos array de books
            }
            
            
            // Creamos el modelo
            let model = Library(bookArray: books)
            
            // Creamos LibraryVC
            let lVC = LibraryTableViewController(model: model)
            
            // Creamos un Nav con Library
            let lNav = UINavigationController(rootViewController: lVC)
            
            // Detectamos tipo de dispositivo: iPhone o iPad
            
            if DeviceType.IS_IPHONE == true {
                print("Es un iphone")
                
                window?.rootViewController = lNav
            }
            
            if DeviceType.IS_IPAD {
                print("Es un iPad")
                
                // Definimos libro inicial 
                let bookDefault = model.book(forTagName: "Android", at: 0)!
                var bookToLoad = bookDefault
                
                // Recuperamos último libro seleccionado por usuario si lo hay
                let defaults = UserDefaults.standard
                
                func obtainBookToLoad (bookName: String, tagName: String) -> Book {
                    
                    let bookArray = model.books(forTagName: tagName)
                    var bookToLoad: Book?
                    
                    for book in bookArray! {
                        if book.titulo.hash == tagName.hash {
                            bookToLoad = book
                        }
                    }
                    
                    guard let _ = bookToLoad else {
                        return model.book(forTagName: "Android", at: 0)!
                    }
                    
                    return bookToLoad!
                }
                

                if let bookTitleSelected = defaults.string(forKey: "HackerBooks.Book") as String?,
                    let tagNameSelected = defaults.string(forKey: "HackerBooks.Tag") as String? {
                    bookToLoad = obtainBookToLoad(bookName: bookTitleSelected, tagName: tagNameSelected)
                }
                
                
                // Creamos navigation con Book
                
                // let bVC = BookViewController(model: model.book(forTagName: "Android", at: 0)!)
                let bVC = BookViewController(model: bookToLoad)
                let bNav = UINavigationController(rootViewController: bVC)
                
                // Asignamos delegados
                lVC.delegate = bVC
                
                // Creamos spliViewController
                let splitVC = UISplitViewController()
                splitVC.viewControllers = [lNav, bNav]
                
                window?.rootViewController = splitVC
            }
            
            
            // Mostramos la window
            window?.makeKeyAndVisible()
            
            return true
            
            
        }catch{
            fatalError("Error while loading Model from JSON")
        }
        
        return true
    }

    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}




