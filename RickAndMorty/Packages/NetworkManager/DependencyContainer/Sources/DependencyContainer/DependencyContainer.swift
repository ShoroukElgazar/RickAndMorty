import Foundation

public final class DependencyContainer {
    public let shared = DependencyContainer()
    private var singleInstanceDependencies: [ObjectIdentifier:AnyObject] = [:]
    private var closureBasedDependencies: [ObjectIdentifier: ()-> Any] = [:]
    private let accessQueue = DispatchQueue(label: "com.dependencyContainer.accessQueue", attributes: .concurrent)
    private init(){}
    
    
    public func register(type: DependencyContainerRegistrationType, for interface: Any.Type) {
        accessQueue.sync(flags: .barrier) {
            let objectIdentifier = ObjectIdentifier(interface)
             switch type {
             case .singleInstance(let object):
                 singleInstanceDependencies[objectIdentifier] = object
             case .closureBased(let closure):
                 closureBasedDependencies[objectIdentifier] = closure
             }
        }
    }
    
    public func resolve<Value>(type: DependencyContainerRegistrationType, for interface: Value.Type) -> Value {
        var value: Value!
        accessQueue.sync {
            let objectIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance(let object):
                guard let singleInstanceDependency = singleInstanceDependencies[objectIdentifier] as? Value else {
                    fatalError("Could not resolve dependency for \(interface)")
                }
                value = singleInstanceDependency
            case .closureBased(let closure):
                guard let closure = closureBasedDependencies[objectIdentifier], let closureDependency = closure() as? Value else {
                    fatalError("Could not resolve closure dependency for \(interface)")
                }
                value = closureDependency
            }
        }
        return value
    }
}


