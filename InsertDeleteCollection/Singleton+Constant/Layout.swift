import Foundation
import UIKit

class Layout {
    internal static let shared = Layout()
    private init() { }
    
    internal func numberOfItemsPerRow(forAvailable width: CGFloat) {
       CollectionViewConfigurations.shared.itemsPerRow = calculateNumberOfItem(for: width)
    }
    
    private func calculateNumberOfItem(for width: CGFloat) -> Int {
        var counter = 1
        let savedHeight = Int(CollectionViewConfigurations.shared.cellHeight ?? 100.0)
        let savedSpacing = CollectionViewConfigurations.shared.spaceBetweenItems ?? 5
        var requiredWidth = counter * savedHeight + (counter - 1) * savedSpacing
        while CGFloat(requiredWidth) < (width) {
            counter += 1
            requiredWidth = counter * savedHeight + (counter - 1) * savedSpacing
        }
        return counter == 1 ? 1 : (counter - 1)
    }
    
    internal func cellWidthAndHeight() -> CGSize {
        let size = CollectionViewConfigurations.shared.cellHeight ?? 100.0
        return CGSize(width: Double(size), height: Double(size))
    }
    
    internal func interSpacingOfCells(ofAvailable width: CGFloat) -> CGFloat {
        let widthOfCell = Int(CollectionViewConfigurations.shared.cellHeight ?? 100.0)
        let calculatedWidth = CollectionViewConfigurations.shared.itemsPerRow * widthOfCell
        let numberOfItems = CollectionViewConfigurations.shared.itemsPerRow
        let spacing = (width - CGFloat(calculatedWidth))/CGFloat(numberOfItems == 1 ? 1 : (numberOfItems - 1))
        return spacing
    }
    
    internal func interSpaceOfCellsColumn() -> CGFloat {
        return CGFloat(CollectionViewConfigurations.shared.spaceBetweenItems ?? 5)
    }
}
