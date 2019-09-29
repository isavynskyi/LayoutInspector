//
//  LayoutInspector.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import CoreMotion

/// Type of trigger used to fire layout inspection automatically
@objc public enum AutoTrigger: Int {
    case none
    
    /// Fire automatically when device screenshot is taken
    case screenshot
	
    /// Fire automatically when shaking device
	case shake
}

/**
 The `LayoutInspector` is designed to be single communication point for the entire LayoutInspector module
 
 - Important:
 Layout inspection shown only in DEBUG build configuration
 */
@objc public final class LayoutInspector: NSObject {
    /// Returns the singleton instance of an `LayoutInspector`.
    @objc public static let shared = LayoutInspector()
    private override init() {}
    
    private var currentAutoTrigger: AutoTrigger = .none
    private var viewController: LayoutInspectorContainerViewController?
    private var hierarchyBuilder: HierarchyBuilderProtocol = HierarchyBuilder()
    private var presenter: LayoutInspectorPresenter?
    private var isInspecting = false
	lazy var motionManager = CMMotionManager()
}

//MARK: - Public API
public extension LayoutInspector {
    /**
     Call this to fire layout inspection manually
     - Important:
     Layout inspection shown only in DEBUG build configuration
     */
    @objc func showLayout() {
        startLayoutInspection()
    }
    
    /**
     Specifies automatical trigger to start layout inspection
     - parameter trigger: The desired trigger type
     */
    @objc func setAutoTrigger(_ trigger: AutoTrigger) {
        guard currentAutoTrigger != trigger else { return }
        
        unsubscribeFromTrigger(currentAutoTrigger)
        currentAutoTrigger = trigger
        subscribeForTrigger(currentAutoTrigger)
    }
}

//MARK: - Private API
private extension LayoutInspector {
    /**
     Starts layout inspection
     - Important:
     Layout inspection shown only in DEBUG build configuration
     */
    @objc func startLayoutInspection() {
        #if DEBUG
        guard let viewDescriptionTree = hierarchyBuilder.captureHierarchy(), isInspecting == false else { return }
        presenter = makeLayoutInspectorPresenter()
        presenter?.showInspectorView(for: viewDescriptionTree)
        isInspecting = true
        #endif
    }
    
    func subscribeForTrigger(_ trigger: AutoTrigger) {
        switch trigger {
        case .screenshot:
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(startLayoutInspection),
                                                   name: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil)
		case .shake:
			addShake()
        case .none: return
        }
    }
    
    func unsubscribeFromTrigger(_ trigger: AutoTrigger) {
        switch trigger {
        case .screenshot:
            NotificationCenter.default.removeObserver(self,
                                                      name: UIApplication.userDidTakeScreenshotNotification,
                                                      object: nil)
		case .shake:
			removeShake()
        case .none: return
        }
    }
}


// MARK: - Container Module Configuration
private extension LayoutInspector {
    func makeLayoutInspectorPresenter() -> LayoutInspectorPresenter {
        viewController = ViewControllerFactory.createLayoutInspectorContainerViewController()
        viewController?.loadView()
        viewController?.viewDidLoad()
        
        let presenter = LayoutInspectorPresenter()
        viewController?.output = presenter
        presenter.view = viewController
        presenter.delegate = self
        return presenter
    }

}

extension LayoutInspector: LayoutInspectorPresenterDelegate {
    func didFinishLayoutInspection() {
        viewController = nil
        presenter = nil
        isInspecting = false
    }
}

// MARK: - Shake detection support
private extension LayoutInspector {
	func addShake() {
		guard motionManager.isAccelerometerAvailable else { return }
		motionManager.accelerometerUpdateInterval = 0.1
		motionManager.startAccelerometerUpdates(to: OperationQueue()) { [weak self] (data, error) in
			guard let self = self else { return }
            guard error == nil, let acceleration = data?.acceleration, self.currentAutoTrigger == .shake else {
				self.motionManager.stopAccelerometerUpdates()
				return
			}
			let accelerationMagnitude = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
            if accelerationMagnitude > LayoutInspector.Constants.shakeAccelerationThreshold {
				DispatchQueue.main.async {
					LayoutInspector.shared.showLayout()
				}
			}
		}
	}
	func removeShake() {
		self.motionManager.stopAccelerometerUpdates()
	}
}

// MARK: - Nested types
private extension LayoutInspector {
    enum Constants {
        static let shakeAccelerationThreshold = 2.3
    }
}
