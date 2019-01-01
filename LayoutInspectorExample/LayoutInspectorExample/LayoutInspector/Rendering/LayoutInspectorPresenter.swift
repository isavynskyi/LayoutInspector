import UIKit
import SceneKit

protocol LayoutInspectorViewOutput {
    func didCloseAction()
}

protocol LayoutInspectorViewInput: NSObjectProtocol {
    func rootView() -> UIView
    func addNodeToScene(_ node: SCNNode)
    func removeNode(_ node: SCNNode)
}

class LayoutInspectorPresenter {
    weak var view: LayoutInspectorViewInput?
    var wrapperNode = SCNNode()
    private lazy var renderingTreeBuilder: RenderingTreeBuilderProtocol = {
       return RenderingTreeBuilder()
    }()
    
    func showInspectorView(for viewDescription: ViewDescriptionProtocol) {
        renderLayoutNodes(for: viewDescription)
        showView()
    }
}

private extension LayoutInspectorPresenter {
    func showView() {
        let appWindow = UIApplication.shared.keyWindow! as UIWindow
        guard let rootView = view?.rootView() else {return}
        appWindow.addSubview(rootView)
    }
    
    func renderLayoutNodes(for viewDescription: ViewDescriptionProtocol) {
        let renderingTree = renderingTreeBuilder.build(from: viewDescription)
        if let rootNode = renderingTree.viewNode {
            wrapperNode.addChildNode(rootNode)
            view?.addNodeToScene(wrapperNode)
        }
    }
}

extension LayoutInspectorPresenter: LayoutInspectorViewOutput {
    func didCloseAction() {
        view?.removeNode(wrapperNode)
        wrapperNode.childNodes.forEach { $0.removeFromParentNode() }
        let rootView = view?.rootView()
        rootView?.removeFromSuperview()
    }
}
