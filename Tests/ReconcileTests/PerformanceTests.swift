@testable import Reconcile
import XCTest

final class PerformanceTests: XCTestCase {
    let count = 1_000_000
    
    func makeData() -> ([Int], [Int]) {
        (
            Array(stride(from: 0, to: count, by: 2)),
            Array(stride(from: 1, to: count, by: 2))
        )
    }
    
    func testNaiveReconcilePerfomance() {
        let (lhs, rhs) = makeData()
        
        measure {
            _ = Reconcile.naive(lhs, rhs)
        }
    }
    
    func testMergeReconcilePerfomance() {
        let (lhs, rhs) = makeData()
        
        measure {
            _ = Reconcile.merge(lhs, rhs)
        }
    }
}
