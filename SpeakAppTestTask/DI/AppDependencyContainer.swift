//
//  AppDependencyContainer.swift
//  SpeakAppTestTask
//
//  Created by Ivan Nichipor on 2.03.25.
//

import Foundation
import Swinject

final class AppDependencyContainer {
    static let shared = AppDependencyContainer()
    let container: Container
    
    private init() {
        container = Container()
        let assemblies: [Assembly] = [
            ImageSearchAssembly(),
            ImagePreviewAssembly(),
            RepositoryAssembly(),
            ServiceAssembly()
        ]
        assemblies.forEach { $0.assemble(container: container) }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let service = container.resolve(type) else {
            fatalError("Dependency \(type) could not be resolved!")
        }
        return service
    }
    
    func resolve<T, Arg1, Arg2>(_ type: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        guard let service = container.resolve(type, arguments: arg1, arg2) else {
            fatalError("Dependency \(type) with arguments \(arg1), \(arg2) could not be resolved!")
        }
        return service
    }
}
