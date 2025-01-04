import Foundation

func log(_ msg: String) {
    print("\(msg)")
}

extension UInt {
    func decremented(clamping: ClosedRange<Self> = UInt.min...UInt.max) -> Self {
        if self == clamping.lowerBound {
            log("returning min")
            return clamping.lowerBound
        }
        log("returning decremented")
        return self - 1
    }

    func incremented(clamping: ClosedRange<Self> = UInt.min...UInt.max) -> Self {
        if self == clamping.upperBound {
            log("returning max")
            return clamping.upperBound
        }
        log("returning incremented")
        return self + 1
    }
}

print("start")
let i: UInt = 2
print("\(i)")
print("\(i.decremented())")
print("\(i.decremented().decremented())")
