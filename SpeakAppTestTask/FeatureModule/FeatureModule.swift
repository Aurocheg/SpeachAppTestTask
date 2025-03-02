//
//  FeatureModule.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import UIKit

public protocol ModuleOutput: AnyObject {
    var viewController: UIViewController { get }
}

open class FeatureModuleOutput: ModuleOutput {
    public let viewController: UIViewController

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

open class FeatureModule<Output: ModuleOutput> {
    public let output: Output
    
    public init(output: Output) {
        self.output = output
    }
}

public extension FeatureModule {
    var presentation: UIViewController {
        return output.viewController
    }
}
