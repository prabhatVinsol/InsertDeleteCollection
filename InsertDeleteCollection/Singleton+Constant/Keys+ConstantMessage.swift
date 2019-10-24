import Foundation

class Keys {
    internal static let shared = Keys()
    private init() {}
    internal var itemsPerRowKey = "ItemsPerRow"
    internal var sizeOfItemKey = "SizeOfItem"
    internal var spacingBetweenItemsKey = "SpacingBetweenItmes"
    internal var animationSpeedKey = "AnimationSpeed"
}

class AlertMessages {
    internal static let shared = AlertMessages()
    private init() {}
    internal let valueNotFoundTitle = "Not found!"
    internal let indexNotFoundTitle = "Index not available"
    internal let valueNotFoundMessage = "Value e is not present in collection."
    internal let indexNotFoundMessage = "Please add more values to collection as required index in not available in the collection."
}