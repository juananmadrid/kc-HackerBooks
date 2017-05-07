import Foundation
import UIKit

struct DeviceType {

    static let IS_IPHONE  = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD  = UIDevice.current.userInterfaceIdiom == .pad
    
}
    
    
