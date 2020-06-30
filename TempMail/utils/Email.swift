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
    @Published var inbox: [InboxModel]?
    @Published var msgs: [Int:MessageModel]?
    
    //  init method
    init() {
        //need to initialize email_addr to an empty string first to avoid the error: "self" used in method call before all stored properties are initialized
        self.email_addr = ""
        self.email_addr = genNewEmailAddr()
        loadInbox()
    }
    
    //resets the email
    func reset() -> Void {
        self.msgs = nil
        self.inbox = nil
        self.email_addr = genNewEmailAddr()
    }
    
    //  generates an email address
    func genNewEmailAddr() -> String {
        //list of acceptable chars
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //      returns a random permutation of letters; string of up to length 8 for email addr
        return String((0..<8).map{ _ in letters.randomElement()!})
    }
    
    //parses JSON data
    private func parseData(data: Data, type: String) -> (inbox: [InboxModel]?, msg: MessageModel?, attachment: AttachmentModel?) {
        do {
            switch type {
            case "inbox":
                var response: [InboxModel]?
                response = try JSONDecoder().decode([InboxModel].self, from: data)
                return(response,nil, nil)
            case "msg":
                var response: MessageModel?
                response = try JSONDecoder().decode(MessageModel.self, from: data)
                return(nil,response, nil)
            case "attachment":
                var response: AttachmentModel?
                response = try JSONDecoder().decode(AttachmentModel.self, from: data)
                return(nil,nil, response)
            default:
                print("Model is not valid")
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        //will never reach here
        return (nil,nil, nil)
    }
    
    // loads the Inbox that corresponds to the email address from the server, refreshing every second
    private func loadInbox() -> Void {
        //creates the timer to refresh every 30 seconds and run the code in the block
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            let email_addr = self.email_addr
            //creates the url that will make the API call
            guard let url = URL(string: "https://www.1secmail.com/api/v1/?action=getMessages&login=test&domain=1secmail.com") else {fatalError("Invalid URL")}
            //makes the request to server
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                guard let data = data else {return}
                let info = self.parseData(data: data, type: "inbox")
                //updates instance variable
                DispatchQueue.main.async {
                    if self.email_addr == email_addr {
                        self.inbox = info.inbox
                    }
                }
            }.resume()
        }
    }
    
    //fetches message data
    private func fetchMessage(id: Int) -> MessageModel? {
        if msgs![id] != nil {
            return self.msgs![id]
        }
        guard let url = URL(string: "https://www.1secmail.com/api/v1/?action=readMessage&login=test&domain=1secmail.com&id=\(id)") else {fatalError("Invalid URL")}
        //makes the request to server
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {return}
            let info = self.parseData(data: data, type: "msg")
            //updates instance variable
            DispatchQueue.main.async {
                self.msgs![id] = info.msg
            }
        }.resume()
        return self.msgs![id]
    }

    //downloads attachments
    func getAttachments(id: Int, filename: String) -> AttachmentModel? {
        
    }
    
    //  getter for email addr
    func getEmailAddr() -> String {
        return email_addr
    }
    
    //  getter for emails
    func getInbox() -> [InboxModel]? {
        return inbox
    }
    
    // gets the contents of an individual message
    func getMessageContent(id: Int) -> MessageModel? {
        // Checks to see if a msg dict exists. If not, create a new empty one so that I can add values to it.
        if self.msgs == nil {
            self.msgs = [:]
        }
        return fetchMessage(id: id)
    }
}
