import UIKit

protocol LayoutInspectorViewOutput {
    func didCloseAction()
}

protocol LayoutInspectorViewInput: NSObjectProtocol {
    func rootView() -> UIView
}

class LayoutInspectorPresenter {
    weak var view: LayoutInspectorViewInput?
    
    func showInspectorView() {
        let appWindow = UIApplication.shared.keyWindow! as UIWindow
        guard let rootView = view?.rootView() else {return}
        appWindow.addSubview(rootView)
    }
}

extension LayoutInspectorPresenter: LayoutInspectorViewOutput {
    func didCloseAction() {
        let rootView = view?.rootView()
        rootView?.removeFromSuperview()
    }
}
