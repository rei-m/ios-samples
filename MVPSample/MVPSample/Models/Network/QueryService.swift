//
//  QueryService.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/11.
//

import Foundation

//
// MARK: - Query Service
//

class QueryService {
    //
    // MARK: - Constants
    //
    let defaultSession = URLSession(configuration: .default)
    
    //
    // MARK: - Variables And Properties
    //
    var dataTask: URLSessionDataTask?

    //
    // MARK: - Type Alias
    //
    typealias JSONDictionary = [String: Any]

    //
    // MARK: - Error
    //
    enum QueryServiceError: Error {
        /// 取得に失敗
        case getFailure(_ reason: String)
        /// 内容が不正
        case invalidContents(_ reason: String)
    }
    
    //
    // MARK: - Internal Methods
    //
    func getSearchResults(searchCompletion: @escaping (Result<[Article], Error>) -> Void) {

        dataTask?.cancel()
        
        //  アクセストークンなしなので1時間に60回まで
        guard var urlComponents = URLComponents(string: "https://qiita.com/api/v2/items") else {
            return
        }

        urlComponents.query = "page=1&per_page=10"
        
        guard let url = urlComponents.url else {
          return
        }

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in

            defer {
                self?.dataTask = nil
            }

            if let error = error {
                DispatchQueue.main.async {
                    searchCompletion(Result.failure(QueryServiceError.getFailure(error.localizedDescription)))
                }
                return
            }
            
            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let result = self?.updateSearchResults(data)
            {
                DispatchQueue.main.async {
                   searchCompletion(result)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    //
    // MARK: - Private Methods
    //
    private func updateSearchResults(_ data: Data) -> (Result<[Article], Error>) {
        var response: [JSONDictionary]?

        do {
            response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [JSONDictionary]
        } catch let parseError as NSError {
            return Result.failure(QueryServiceError.invalidContents("JSONSerialization error: \(parseError.localizedDescription)\n"))
        }

        var articles: [Article] = []
        var errorMessage: String = ""
        let fmt = ISO8601DateFormatter()

        for articleDict in response! {
            if let title = articleDict["title"] as? String,
                let body = articleDict["body"] as? String,
                let createdAtString = articleDict["created_at"] as? String {
                articles.append(Article(title: title, body: body, createdAt: fmt.date(from: createdAtString)!))
            } else {
                errorMessage += "Problem parsing articleDictionary\n"
            }
        }

        if errorMessage.isEmpty {
            return Result.success(articles)
        } else {
            return Result.failure(QueryServiceError.invalidContents(errorMessage))
        }
    }
}
