//
//  DebugNode.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/1/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol ViewMetadataProtocol {
    var className: String { get }
    var isUserInteractionEnabled: Bool { get }
    var alpha: Float { get }
    var backgroundColor: UIColor? { get }
    var tint: UIColor? { get }
    var clipToBounds: Bool { get }
    var frame: CGRect { get }
}

struct ViewMetadata: ViewMetadataProtocol {
    var className: String
    var isUserInteractionEnabled: Bool
    var alpha: Float
    var backgroundColor: UIColor?
    var tint: UIColor?
    var clipToBounds: Bool
    var frame: CGRect
    
    init(with viewDescriptor: ViewDescriptionProtocol) {
        self.className = viewDescriptor.className
        self.isUserInteractionEnabled = viewDescriptor.isUserInteractionEnabled
        self.alpha = viewDescriptor.alpha
        self.backgroundColor = viewDescriptor.backgroundColor
        self.tint = viewDescriptor.tint
        self.clipToBounds = viewDescriptor.clipToBounds
        self.frame = viewDescriptor.frame
    }
}

class DebugNode: SCNNode {
    var metadata: ViewMetadataProtocol? = nil
    private var selectionBorderNodeName = "DebugNode.selectionBorderNodeName"
    
    var isSelected = false {
        didSet { updateSelectionState() }
    }
}

// Private API
private extension DebugNode {
    func updateSelectionState() {
        isSelected ? highlight() : unhighlight()
    }
    
    func highlight() {
        setFirstMaterialTransparency(0.5)
        
        let (min, max) = boundingBox
        let topLeft = SCNVector3Make(min.x, max.y, 0)
        let bottomLeft = SCNVector3Make(min.x, min.y, 0)
        let topRight = SCNVector3Make(max.x, max.y, 0)
        let bottomRight = SCNVector3Make(max.x, min.y, 0)
        
        let bottomSide = createLineNode(fromPos: bottomLeft, toPos: bottomRight, color: .selectionBorders)
        let leftSide = createLineNode(fromPos: bottomLeft, toPos: topLeft, color: .selectionBorders)
        let rightSide = createLineNode(fromPos: bottomRight, toPos: topRight, color: .selectionBorders)
        let topSide = createLineNode(fromPos: topLeft, toPos: topRight, color: .selectionBorders)
        
        [bottomSide, leftSide, rightSide, topSide].forEach {
            $0.name = selectionBorderNodeName
            addChildNode($0)
        }
    }
    
    func unhighlight() {
        setFirstMaterialTransparency(1.0)

        let highlightningNodes = childNodes.filter { $0.name == selectionBorderNodeName}
        highlightningNodes.forEach { $0.removeFromParentNode() }
    }
    
    func createLineNode(fromPos origin: SCNVector3, toPos destination: SCNVector3, color: UIColor) -> SCNNode {
        let line = lineFrom(vector: origin, toVector: destination)
        let lineNode = SCNNode(geometry: line)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = color
        line.materials = [planeMaterial]
        
        return lineNode
    }
    
    func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        return SCNGeometry(sources: [source], elements: [element])
    }

    func setFirstMaterialTransparency(_ value: Float) {
        geometry?.firstMaterial?.transparency = CGFloat(value)
    }
    
}
