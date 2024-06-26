import AppKit

extension Pdf {
    
    public enum GridColumnWidth {
        case flexible
        case relative(v: CGFloat)
        case fixed(v: CGFloat)
    }
    
    open class Grid: DocumentItemAutoBreak {
        
        let columns: [GridColumnWidth]
        let items: [DocumentItem]
        let separatorColor: NSColor
        
        public init(columns: [GridColumnWidth], items: [DocumentItem], separatorColor: NSColor = .separator) {
            self.columns = columns
            self.items = items
            self.separatorColor = separatorColor
        }
        
        open override func draw(rect: inout CGRect) {
                        
            let columnWidth = calculateColumnsWidth(rect: rect)
            let rowsCount = Int(ceil( Float(items.count) / Float(columns.count)))
            
            var rowOffsetY: CGFloat = 0
            
            for i in 0..<rowsCount {
                let row = items[(i * columns.count)..<min(items.count, (i * columns.count + columns.count))]
                
                let rowHeight = height(
                    row: [DocumentItem](row),
                    columnWidth: columnWidth,
                    maxHeight: rect.height)
                
                var cellOffset: CGFloat = 0
                
                for (index, cell) in row.enumerated() {
                    
                    var cellRect = CGRect(
                        x: rect.minX + cellOffset,
                        y: rect.minY + rowOffsetY,
                        width: columnWidth[index],
                        height: rowHeight)
                    
                    cellOffset += columnWidth[index]
                    
                    let context = UIGraphicsGetCurrentContext()                    
                    context?.setFillColor(cell.backgroundColorFill.cgColor)
                    context?.setStrokeColor(separatorColor.cgColor)
                    context?.fill(cellRect)
                    context?.stroke(cellRect)
                    
                    cell.draw(rect: &cellRect)
                }
                
                rowOffsetY += rowHeight
            }
            
            let height: CGFloat = rowOffsetY
            
            rect.origin.y += height
            if height > rect.size.height {
                rect.size.height = 0
            } else {
                rect.size.height -= height
            }
        }
        
        private func calculateColumnsWidth(rect: CGRect) -> [CGFloat] {
            var fixedWidth: CGFloat = 0
            var flexibleCount: CGFloat = 0
            
            for column in columns {
                switch column {
                
                case .flexible:
                    flexibleCount += 1
                case .relative(let v):
                    fixedWidth += rect.width * v
                case .fixed(let v):
                    fixedWidth += v
                }
            }
            var result = [CGFloat]()
            
            for column in columns {
                switch column {
                
                case .flexible:
                    result.append( (rect.width - fixedWidth) / flexibleCount )
                case .relative(let v):
                    result.append(rect.width * v)
                case .fixed(let v):
                    result.append(v)
                }
            }
            
            return result
        }
        
        private func height(row: [DocumentItem], columnWidth: [CGFloat], maxHeight: CGFloat) -> CGFloat {
            var rowHeight: CGFloat = 5
            for (index, cell) in row.enumerated() {
                var cellRect = CGRect(
                    x: 0,
                    y: 0,
                    width: columnWidth[index],
                    height: maxHeight)
                
                UIGraphicsBeginImageContext(cellRect.size)
                cell.draw(rect: &cellRect)
                UIGraphicsEndImageContext()
                
                let tempHeight = maxHeight - cellRect.height
                if tempHeight > rowHeight {
                    rowHeight = tempHeight
                }
            }
            return rowHeight
        }
    }
}



