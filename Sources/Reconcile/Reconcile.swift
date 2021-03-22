enum Reconcile {
    public static func naive<S: Sequence>(_ lhs: S, _ rhs: S) -> ([S.Element], [S.Element])
        where S.Element: Hashable & Comparable
    {
        let lhsSet = Set(lhs)
        let rhsSet = Set(rhs)

        return (
            lhsSet.subtracting(rhsSet).sorted(),
            rhsSet.subtracting(lhsSet).sorted()
        )
    }

    public static func merge<S: Sequence>(_ lhs: S, _ rhs: S) -> ([S.Element], [S.Element])
        where S.Element: Comparable
    {
        var lhs = ArraySlice(lhs.sorted())
        var rhs = ArraySlice(rhs.sorted())

        var uniqueLhs: [S.Element] = []
        var uniqueRhs: [S.Element] = []

        while let l = lhs.first, let r = rhs.first {
            if l == r {
                lhs = lhs.dropFirst()
                rhs = rhs.dropFirst()
                continue
            }

            if l < r {
                lhs = lhs.dropFirst()
                uniqueLhs.append(l)
            } else {
                rhs = rhs.dropFirst()
                uniqueRhs.append(r)
            }
        }

        uniqueLhs.append(contentsOf: lhs)
        uniqueRhs.append(contentsOf: rhs)

        return (uniqueLhs, uniqueRhs)
    }

    static func formatted<S: Sequence>(_ lhs: S, _ rhs: S) -> String
        where S.Element: CustomStringConvertible
    {
        """
        Numbers in array a that aren't in array b:
        \(lhs.map(String.init(describing:)).joined(separator: " "))

        Numbers in array b that aren't in array a:
        \(rhs.map(String.init(describing:)).joined(separator: " "))
        """
    }
}
