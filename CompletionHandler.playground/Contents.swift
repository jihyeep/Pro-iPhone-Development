import UIKit

enum BigError: Error {
    case powerOutage
    case endOfTheWorld
}

enum Response {
    case success
    case failure
}

let startTime = NSDate()

func doSomething(completion: (Result<Response, BigError>) -> Void) {
    print("Start task")
    Thread.sleep(forTimeInterval: 2)
    
    let randomNumber = Int.random(in: 0..<2)
    if randomNumber == 0 {
        completion(.failure(.powerOutage)) /// 비동기 작업이 끝났을 때 호출하여 결과를 전달
        return
    }
    
    completion(.success(.success)) /// 비동기 작업이 끝났을 때 호출하여 결과를 전달
}

doSomething { result in
    switch result {
    case .success(let response):
        print("Result = \(response)")
    case .failure(let error):
        print("This is the error = \(error)")
    }
    print("End task")
}

let endTime = NSDate()
print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds.")
