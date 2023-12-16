//
//  OpenAIAPIModel.swift
//  BorusanAutoHack
//
//  Created by Mac on 10.12.2023.
//

import Foundation
import Alamofire

class OpenAIAPIModel {
    
    @frozen enum Constants {
        static let key = "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"
    }
    let url = URL(string: "https://api.openai.com/v1/chat/completions")
    
    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if sessionConfig != nil {
            session = URLSession(configuration: sessionConfig)
        } else {
            session = URLSession.shared
        }
        
        var requestData: Data?
        let task = session.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            } else if data != nil {
                requestData = data
            }
            
            print("Semaphore signalled")
            semaphore.signal()
        }
        task.resume()
        
        let timeout = DispatchTime.now() + .seconds(600)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }
    
    public func processPrompt(prompt: String) -> Optional<String> {
        
        var request = URLRequest(url: self.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Constants.key)", forHTTPHeaderField: "Authorization")
        let httpBody: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "system", "content": prompt]
            ],
            "max_tokens": 8000]
        
        var httpBodyJson: Data
        
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error.localizedDescription)")
            return nil
        }
        request.httpBody = httpBodyJson
        if let requestData = executeRequest(request: request, withSessionConfig: nil as URLSessionConfiguration? ?? .default) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(jsonStr)
            let responseHandler = OpenAIResponseHandler()
            print("Denemeeee \(jsonStr)")
            return responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].message.content
        }
        return nil
    }
}

struct OpenAIResponseHandler {
    func decodeJson(jsonString: String) -> OpenAIResponse? {
        let json = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode(OpenAIResponse.self, from: json)
            return product
        } catch {
            print("Error during OpenAI API Response")
        }
        return nil
    }
}

struct OpenAIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
    let index: Int
    let logprobs: String?
    let finish_reason: String
}

struct Message: Codable {
    let role: String
    let content: String
}
