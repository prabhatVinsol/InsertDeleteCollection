import Foundation
import UIKit

class CollectionViewConfigurations {
    internal static let shared = CollectionViewConfigurations()
    private init() {}
    private let userDefault = UserDefaults.standard
    internal var itemsPerRow = 4
    internal var spaceBetweenItems: Int? {
        didSet {
            userDefault.set(CollectionViewConfigurations.shared.spaceBetweenItems, forKey: Constant.shared.spacingBetweenItemsKey)
        }
    }
    internal var cellHeight: Float? {
        didSet {
            userDefault.set(CollectionViewConfigurations.shared.cellHeight, forKey: Constant.shared.sizeOfItemKey)
        }
    }
    internal var animationDuration: Float? {
        didSet {
            userDefault.set(CollectionViewConfigurations.shared.animationDuration, forKey: Constant.shared.animationSpeedKey)
        }
    }
    
}
