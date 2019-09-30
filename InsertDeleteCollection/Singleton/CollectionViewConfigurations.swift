import Foundation
import UIKit
class CollectionViewConfigurations {
    static let shared = CollectionViewConfigurations()
    private init() { }
    var itemsPerRow = 4
    var itemsList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var spaceBetweenItems = 5
    var cellHeight = CGFloat(integerLiteral: 100)
    var animationDuration = 4
    var spacingPickerValue = [Int]()
    var sizePickerValue = [Int]()
}
