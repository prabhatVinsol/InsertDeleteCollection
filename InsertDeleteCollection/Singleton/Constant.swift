import Foundation

class Constant {
    internal static let shared = Constant()
    private init() {}
    internal var itemsPerRowKey = "ItemsPerRow"
    internal var sizeOfItemKey = "SizeOfItem"
    internal var spacingBetweenItemsKey = "SpacingBetweenItmes"
    internal var animationSpeedKey = "AnimationSpeed"
}
