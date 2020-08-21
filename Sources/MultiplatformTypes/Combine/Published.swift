import Foundation
import Combine

class PublishedStorage {
    static var storage: Set<AnyCancellable> = []
}

public extension Published {
    
    init(wrappedValue: Value, key: String) {
        let value: Value = UserDefaults.standard.object(forKey: key) as? Value ?? wrappedValue
        self.init(wrappedValue: value)
        self.projectedValue.sink { value in
            UserDefaults.standard.set(value, forKey: key)
        }
        .store(in: &PublishedStorage.storage)
    }
    
}



