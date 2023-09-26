//

import Foundation

extension URL {
    func isTelephone() -> Bool {
        return self.scheme == "tel"
    }
}
