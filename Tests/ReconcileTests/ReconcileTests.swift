@testable import Reconcile
import SwiftCheck
import XCTest

final class ReconcileTests: XCTestCase {
    let a = [5, 3, 4]
    let b = [4, 3, 10, 6]
    let output = ([5], [6, 10])

    func testNaiveReconcilesExampleInput() {
        let naive = Reconcile.naive(a, b)

        XCTAssertEqual(naive.0, output.0)
        XCTAssertEqual(naive.1, output.1)
    }

    func testMergeReconcilesExampleInput() {
        let merge = Reconcile.merge(a, b)

        XCTAssertEqual(merge.0, output.0)
        XCTAssertEqual(merge.1, output.1)
    }

    func testReconcileFormatter() {
        let formattedOutput =
            """
            Numbers in array a that aren't in array b:
            5

            Numbers in array b that aren't in array a:
            6 10
            """

        XCTAssertEqual(
            Reconcile.formatted([5], [6, 10]),
            formattedOutput
        )
    }

    func testMergeReconcileBehavesLikeNaiveReconcile() {
        property("Merge Reconsile behaves like Naive Reconcile") <- forAll { (lhs: Set<Int>, rhs: Set<Int>) in
            Reconcile.merge(lhs, rhs) == Reconcile.naive(lhs, rhs)
        }
    }
}
