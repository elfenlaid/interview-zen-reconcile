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

## But... Performance?

When it comes to eloquence the [naive solution](https://github.com/elfenlaid/interview-zen-reconcile/blob/main/Sources/Reconcile/Reconcile.swift#L2-L12) is a winner. 

But how solutions compare performance wisely? 

|Count   |Merge (sec)    |Naive (sec)    |
|--------|---------------|---------------|
|10      |0.0004285539617|0.0003267820575|
|100     |0.0001519169891|0.0006182659999|
|1000    |0.001929043035 |0.007700359973 |
|10000   |0.01566403004  |0.05466747796  |
|100000  |0.140173972    |0.660093833    |
|1000000 |1.390728293    |7.828324841    |
|10000000|14.08142214    |55.4913044     |

![](assets/merge-vs-naive.svg)

So, [naive solution](https://github.com/elfenlaid/interview-zen-reconcile/blob/main/Sources/Reconcile/Reconcile.swift#L2-L12) is comparable to [merge solution](https://github.com/elfenlaid/interview-zen-reconcile/blob/main/Sources/Reconcile/Reconcile.swift#L14-L43) performance wisely on short sequences. 

## Conclusion
Unless we expect lengthy inputs, I think the naive solution is a go-to. Sure it lacks speed, yet it's sooo much easier to understand and maintain. 

Also, I'm far from being an expert when it comes to interview-like problems. For example, the initial iteration of this one has taken me around 40 minutes (property testing + naive/merge solutions). 

I'm sure there are much more concise and faster ways of solving the given problem. And what's more, Swift is so moody when it comes to performant data structures or performance reasoning in general. So, performance in Swift is a topic of its own :)
