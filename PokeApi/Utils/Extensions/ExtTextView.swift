//
//  ExtTextView.swift
//  listUps
//
//  Created by Mykhailo Zabarin on 1/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//
import UIKit

extension UITextView {

    
//    var numberOfCurrentlyDisplayedLines: Int {
//        let size = systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//        print("(\(size.height) - \(layoutMargins.top) - \(layoutMargins.bottom) / \(font!.lineHeight)) = \((size.height - layoutMargins.top - layoutMargins.bottom) / font!.lineHeight))")
//        return Int(((size.height - layoutMargins.top - layoutMargins.bottom) / font!.lineHeight))
//    }
    
//    var numberOfVisibleLines: Int {
//        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
//        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
//        let charSize: Int = lroundf(Float((self.font?.lineHeight)!))
//        return rHeight / charSize
//    }

    
    var numberOfLines: Int{
        if let fontUnwrapped = self.font{
            print("self.contentSize.height = \(self.contentSize.height)")
            let numberLines: Int = Int(self.contentSize.height / fontUnwrapped.lineHeight)
            
        //    let existingLines = self.text.components(separatedBy: .newlines)
        //    let maxNumbersL = self.textContainer.maximumNumberOfLines
            
            return numberLines
        }
        return 0
    }
        
    
    
    /**
     Calls provided `test` block if point is in gliph range and there is no link detected at this point.
     Will pass in to `test` a character index that corresponds to `point`.
     Return `self` in `test` if text view should intercept the touch event or `nil` otherwise.
     */
    public func hitTest(pointInGliphRange aPoint: CGPoint, event: UIEvent?, test: (Int) -> UIView?) -> UIView? {
        guard let charIndex = charIndexForPointInGlyphRect(point: aPoint) else {
            return super.hitTest(aPoint, with: event)
        }
        guard textStorage.attribute(NSAttributedStringKey.link, at: charIndex, effectiveRange: nil) == nil else {
            return super.hitTest(aPoint, with: event)
        }
        return test(charIndex)
    }
    
    /**
     Returns true if point is in text bounding rect adjusted with padding.
     Bounding rect will be enlarged with positive padding values and decreased with negative values.
     */
    public func pointIsInTextRange(point aPoint: CGPoint, range: NSRange, padding: UIEdgeInsets) -> Bool {
        var boundingRect = layoutManager.boundingRectForCharacterRange(range: range, inTextContainer: textContainer)
        boundingRect = boundingRect.offsetBy(dx: textContainerInset.left, dy: textContainerInset.top)
        boundingRect = boundingRect.insetBy(dx: -(padding.left + padding.right), dy: -(padding.top + padding.bottom))
        return boundingRect.contains(aPoint)
    }
    
    /**
     Returns index of character for glyph at provided point. Returns `nil` if point is out of any glyph.
     */
    public func charIndexForPointInGlyphRect(point aPoint: CGPoint) -> Int? {
        let point = CGPoint(x: aPoint.x, y: aPoint.y - textContainerInset.top)
        let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
        let glyphRect = layoutManager.boundingRect(forGlyphRange: NSMakeRange(glyphIndex, 1), in: textContainer)
        if glyphRect.contains(point) {
            return layoutManager.characterIndexForGlyph(at: glyphIndex)
        } else {
            return nil
        }
    }
    
//    func centerVerticallyTextInTextView() {
//        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
//        let size = sizeThatFits(fittingSize)
//        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
//        let positiveTopOffset = max(1, topOffset)
//        contentOffset.y = -positiveTopOffset
//        if isiPhone5 {
//            contentInset = .init(top: 0, left: 0, bottom: 5, right: 0)
//        } else if isiPhonePlus {
//            contentInset = .init(top: 5, left: 0, bottom: 0, right: 0)
//        }
//    }
}

extension NSLayoutManager {
    
    /**
     Returns characters range that completely fits into container.
     */
    public func characterRangeThatFits(textContainer container: NSTextContainer) -> NSRange {
        var rangeThatFits = self.glyphRange(for: container)
        rangeThatFits = self.characterRange(forGlyphRange: rangeThatFits, actualGlyphRange: nil)
        return rangeThatFits
    }
    
    /**
     Returns bounding rect in provided container for characters in provided range.
     */
    public func boundingRectForCharacterRange(range aRange: NSRange, inTextContainer container: NSTextContainer) -> CGRect {
        let glyphRange = self.glyphRange(forCharacterRange: aRange, actualCharacterRange: nil)
        let boundingRect = self.boundingRect(forGlyphRange: glyphRange, in: container)
        return boundingRect
    }
    
}

