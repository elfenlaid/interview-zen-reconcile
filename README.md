# Reconcile

InterviewZen's [reconcile question](https://www.interviewzen.com/question/5fxFPQr) playground

## References

### Question https://www.interviewzen.com/question/5fxFPQr
### Answer https://www.interviewzen.com/record/dgBv2pG

## Blaberring

Due to the lack of test examples I've improvised with property testing:

- We need a baseline("naive") [solution](https://github.com/elfenlaid/interview-zen-reconcile/blob/main/Sources/Reconcile/Reconcile.swift#L2-L12)
    - We keep the method's correctness as the top priority

- Test input generator [SwiftCheck](https://github.com/typelift/SwiftCheck.git)

- And here's the [actual test](https://github.com/elfenlaid/interview-zen-reconcile/blob/main/Tests/ReconcileTests/ReconcileTests.swift#L40-L44):

  ```swift
  property("Merge Reconsile behaves like Naive Reconcile") <- forAll { (lhs: Set<Int>, rhs: Set<Int>) in
      Reconcile.merge(lhs, rhs) == Reconcile.naive(lhs, rhs)
  }
  ```
Just with three lines, we ended up with an unlimited number of tests 🤯 <br/>
Can't stress enough how property testing shines in such cases :)
