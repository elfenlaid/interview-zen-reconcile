@testable import Reconcile
import XCTest

final class PerformanceTests: XCTestCase {
    func testNaiveReconcilePerfomance() {
        measure(name: "Naive", Reconcile.naive)
    }

    func testMergeReconcilePerfomance() {
        measure(name: "Merge", Reconcile.merge)
    }

    let counts = [10, 100, 1000, 10000, 100_000, 1_000_000, 10_000_000]

    func makeData(count: Int) -> ([Int], [Int]) {
        (
            Array(stride(from: 0, to: count, by: 2)),
            Array(stride(from: 1, to: count, by: 2))
        )
    }

    func measure<A>(name: String, _ block: ([Int], [Int]) -> A) {
        for count in counts {
            let (lhs, rhs) = makeData(count: count)

            let startTime = CACurrentMediaTime()
            _ = block(lhs, rhs)
            let timeElapsed = CACurrentMediaTime() - startTime
            
            print("Time: \(name) \(count) - \(timeElapsed)")
        }
    }
}
