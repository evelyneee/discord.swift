
import Foundation

extension Task {
    @discardableResult
    func finish() async -> Result<Success, Failure>  {
        await self.result
    }
}
