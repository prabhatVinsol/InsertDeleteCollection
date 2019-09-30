import Foundation
import UIKit
class CollectionViewConfigurations {
    internal static let shared = CollectionViewConfigurations()
    private init() { }
    internal var itemsPerRow = 4
    internal var itemsList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    internal var spaceBetweenItems = 5
    internal var cellHeight = CGFloat(integerLiteral: 100)
    internal var animationDuration = 4
    internal var spacingPickerValue = [Int]()
    internal var sizePickerValue = [Int]()
}
