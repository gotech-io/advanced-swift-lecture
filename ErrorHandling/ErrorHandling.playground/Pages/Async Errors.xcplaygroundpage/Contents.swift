import Foundation

enum NetworkError: Error {
    case badURL
}

// This is copied from swift code :) it's new from Swift 5
//enum Result<Success, Failure> where Failure : Error {
//    case success(Success)
//    case failure(Failure)
//}

func fetchStuff(urlString: String, completionHandler: (Result<Int, NetworkError>) -> Void)  {
    guard let url = URL(string: urlString) else {
        completionHandler(.failure(.badURL))
        return
    }

    print("Fetching \(url.absoluteString)...")
    completionHandler(.success(42))
}

fetchStuff(urlString: "not a real url!") { result in
    switch result {
    case .success(let meaningOfLife):
        print("It's \(meaningOfLife)")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
