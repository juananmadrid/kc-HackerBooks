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
    

        /// TRASLADAR A JSONProcessing como segundo decoder
        /// Incluimos descarga de Json o lo usamos desde main local como profe? seguro que profe no lo descarga?
        
        
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
            
            // Convermtimos array de diccionarios en array de libros
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
            
            // Creamos un Nav
            let lNav = UINavigationController(rootViewController: lVC)
            
            
            // Indicamos a la windows elemento root
            window?.rootViewController = lNav
            
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

// Utils

/*
func downloadJSONFiles() throws {
    
    do{
        
        // No están los ficheros cargados, los descargamos y los guardamos
        let url = URL(string: "https://t.co/K9ziV0z3SJ")
        let data = try? Data(contentsOf: url!)
        guard let json = data else{
            throw LibraryError.resourcePointedByURLNotReachable
        }
        
        // Guardamos el json descargado en un archivo
        
        // Path de Documents
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // url del fichero
        let url_file: URL = URL(fileURLWithPath: "books_readable.json", relativeTo: path)
        // Creamos fichero
        let fileManager = FileManager.default
        let created = fileManager.createFile(atPath: url_file.path, contents: json, attributes: nil)
        
        // Creamos flag indicador para indicar fichero cargado
        let flag: Bool = created
        let defaults = UserDefaults.standard
        defaults.set(flag, forKey: "filesLoaded")
        
        
    }catch{
        throw LibraryError.resourcePointedByURLNotReachable
    }
}

*/
