import Foundation

struct Constant {
    struct Keys {
        internal static var itemsPerRowKey = "ItemsPerRow"
        internal static var sizeOfItemKey = "SizeOfItem"
        internal static var spacingBetweenItemsKey = "SpacingBetweenItmes"
        internal static var animationSpeedKey = "AnimationSpeed"
    }

    struct AlertMessages {
        internal static let invalidValueMessage = "Please check value for size and spacing. It is invalid."
        internal static let valueNotFoundMessage = "Value 'E' is not present in collection."
        internal static let indexNotFoundMessage = "Please add more values to collection as required index in not available in the collection."
    }

    struct AlertTitles {
        internal static let valueNotFoundTitle = "Not found!"
        internal static let indexNotFoundTitle = "Index not available"
        internal static let invalidValueTitle = "Invalid Value"
    }

    struct ReuseIdentifiers {
        internal static let alphaCollCellIdentifier = "collectionIdentifier"
    }
}
