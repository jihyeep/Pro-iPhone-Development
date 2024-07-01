import UIKit

// 전통적인 함수 정의
func descriptiveName() {
    print("Run!")
}

// 전통적인 함수 실행
descriptiveName()

func multiplyBy2 (x: Int) -> Int {
    return x * 2
}

print(multiplyBy2(x: 4))
print(multiplyBy2(x: 17))

let y = { (x: Int) -> Int in return x * 2 }

print(y(4))
print(y(17))
