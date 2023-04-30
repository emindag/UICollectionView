//
//  CarouselLayout.swift
//  UICollectionViewFlowLayout
//
//  Created by Emin Dağ on 29.04.2023.
//

import UIKit

final class CarouselLayout: UICollectionViewFlowLayout {
    private let standardItemAlpha: CGFloat = 0.5
    private let standardItemScale: CGFloat = 0.5
    private var isSetup = true
    
    override func prepare() {
        super.prepare()
        if isSetup {
            setupCollectionView()
            isSetup = false
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
        
        return attributesCopy
    }
    
    private func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.height / 2
        let offset = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offset
        
        let maxDistance = itemSize.height + minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let alpha = ratio * (1 - standardItemAlpha) + standardItemAlpha
        let scale = ratio * (1 - standardItemScale) + standardItemScale
        
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(10 * alpha)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let layoutAttributes = layoutAttributesForElements(in: collectionView!.bounds)
        let center = collectionView!.bounds.size.height / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.y + center
        
        let closest = layoutAttributes!.sorted {
            abs($0.center.y - proposedContentOffsetCenterOrigin)
            < abs($1.center.y - proposedContentOffsetCenterOrigin)
        }.first ?? UICollectionViewLayoutAttributes()
        
        let targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - center))
        
        return targetContentOffset
    }
    
    private func setupCollectionView() {
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        let collectionSize = collectionView!.bounds.size
        let yInset = (collectionSize.height - itemSize.height) / 2
        let xInset = (collectionSize.width - itemSize.width) / 2
        
        sectionInset = UIEdgeInsets(
            top: yInset,
            left: xInset,
            bottom: yInset,
            right: xInset
        )
    }
}
