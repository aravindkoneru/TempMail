import UIKit

//// send GET request for fetching inbox
//struct inboxModel: Codable {
//    let id: Int
//    let from: String
//    let subject: String
//    let date: String
//}
//
//func parseInboxJSON(data: Data) -> [inboxModel]? {
//    var responseDict: [inboxModel]?
//    do {
//        responseDict = try JSONDecoder().decode([inboxModel].self, from: data)
//    } catch {
//        print("Error occured: \(error.localizedDescription)")
//    }
//
//    return responseDict
//}
//
//let login = "demo"
//let domain = "1secmail.com"
//let action = "getMessages"
//
//var requestUrl = URLComponents()
//requestUrl.scheme = "https"
//requestUrl.host = "1secmail.com"
//requestUrl.path = "/api/v1/"
//requestUrl.queryItems = [
//    URLQueryItem(name: "action", value: action),
//    URLQueryItem(name: "domain", value: domain),
//    URLQueryItem(name: "login", value: login)
//]
//
//guard let request = requestUrl.url else {fatalError()}
//let requestTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//    if let error = error {
//        print("error occured: \(error)")
//        return
//    }
//
//    guard let data = data else {return}
//    guard let inbox = parseInboxJSON(data: data) else {return}
//
//    for message in inbox {
//        print(message)
//    }
//}
//
//requestTask.resume()
//
//// send GET request for fetching single message
//struct messageModel: Codable {
//    let id: Int
//    let from: String
//    let subject: String
//    let date: String
//    let attachments: [attachmentModel]?
//    let body: String
//    let textBody: String
//    let htmlBody: String
//}
//
//struct attachmentModel: Codable {
//    let filename: String
//    let contentType: String
//    let size: Int
//}
//
//func parseMessageJSON(data: Data) -> messageModel? {
//    var responseDict: messageModel?
//    do {
//        responseDict = try JSONDecoder().decode(messageModel.self, from: data)
//    } catch {
//        print("Error occured: \(error.localizedDescription)")
//    }
//
//    return responseDict
//}
//
//var messageRequestURL = URLComponents()
//messageRequestURL.scheme = "https"
//messageRequestURL.host = "1secmail.com"
//messageRequestURL.path = "/api/v1/"
//messageRequestURL.queryItems = [
//    URLQueryItem(name: "action", value: "readMessage"),
//    URLQueryItem(name: "login", value: login),
//    URLQueryItem(name: "domain", value: domain),
//    URLQueryItem(name: "id", value: "49479429") // this is an absolute value for testing
//]
//
//guard let messageRequest = messageRequestURL.url else {fatalError()}
//let messageRequestTask = URLSession.shared.dataTask(with: messageRequest) { (data, response, error) in
//    if let error = error {
//        print("error in getting message: \(error)")
//        return
//    }
//
//    guard let data = data else {return}
//    guard let message = parseMessageJSON(data: data) else {return}
//
//    print(message)
//}
//
//messageRequestTask.resume()

func formatDate(dateStr: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    let date = dateFormatter.date(from: dateStr)
    
    dateFormatter.timeZone = TimeZone.current
    print(dateFormatter.string(from: date!))
}

formatDate(dateStr: "2020-06-16 17:59:54")
