//
//  Email.swift
//  TempMail
//
//  Created by Paul Jojy on 6/3/20.
//  Copyright © 2020 Paul Jojy. All rights reserved.
//

//This is supposed to be an "Email" Object. The purpose of the email object will be to generate and store the email address, along with the emails attached to it. 
import SwiftUI

class Email : ObservableObject{
    @Published var email_addr: String
    @Published var inbox: [InboxModel]
    var requestUrl: URLComponents
    
    //  init method
    init() {
        self.email_addr = ""
        self.inbox = [InboxModel]()
        requestUrl = URLComponents()
        requestUrl.scheme = "https"
        requestUrl.host = "1secmail.com"
        requestUrl.path = "/api/v1/"
        loadInbox()
        setNewEmailAddr()
    }
    
    //  generates an email address
    func setNewEmailAddr() -> Void {
        //list of acceptable chars
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //      returns a random permutation of letters; string of up to length 8 for email addr
        self.email_addr = String((0..<8).map{ _ in letters.randomElement()!})
    }
    
    // loads the Inbox that corresponds to the email address from the server, refreshing every second
    private func loadInbox() -> Void {
        //creates the timer to refresh every second and run the code in the block
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            //creates the url that will make the API call
            self.requestUrl.queryItems = [
                URLQueryItem(name: "action", value: "getMessages"),
                URLQueryItem(name: "domain", value: "1secmail.com"),
                URLQueryItem(name: "login", value: "test")
            ]
            guard let request = self.requestUrl.url else {fatalError()}
            //makes the request to server
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {return}
                //updates instance variable
                DispatchQueue.main.async {
                    guard let inbox = self.parseInboxData(data: data) else {return}
                    self.inbox = inbox
                }
            }.resume()
        }
    }
    
    //parses Inbox JSON data
    private func parseInboxData(data: Data) -> [InboxModel]? {
        var response: [InboxModel]?
        do {
            response = try JSONDecoder().decode([InboxModel].self, from: data)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return response
    }
    
    //  getter for email addr
    func getEmailAddr() -> String {
        return email_addr
    }
    
    //  getter for emails
    func getInbox() -> [InboxModel] {
        return inbox
    }
    
    
    // @TODO: implement real functionality
    // gets the contents of an individual message
    func getMessageContent(id: Int) -> MessageModel {
        return MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>")
    }
}
