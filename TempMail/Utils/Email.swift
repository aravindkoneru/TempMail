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
    @Published var email_addr: String = ""
    @Published var inbox: [InboxModel]?
    
    private var timer: Timer?
    
    //  init method
    init() {
        self.email_addr = setNewEmailAddr()
        fetchInbox()
    }
    
    func reset() -> Void {
        self.inbox = nil
        self.email_addr = setNewEmailAddr()
        
        print("Reset complete")
    }
    
    //  generates an email address
    func setNewEmailAddr() -> String {
        //list of acceptable chars
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //      returns a random permutation of letters; string of up to length 9       for email addr
        return String((0..<8).map{ _ in letters.randomElement()!})
    }
    
    //  getter for email addr
    func getEmailAddr() -> String {
        return email_addr
    }
    
    private func parseInboxJSON(data: Data) -> [InboxModel]? {
        var responseDict: [InboxModel]?
        do {
            responseDict = try JSONDecoder().decode([InboxModel].self, from: data)
        } catch {
            print("Error occured: \(error.localizedDescription)")
        }
        
        if (responseDict?.count == 0) {
            responseDict = nil
        }
        
        return responseDict
    }
    
    //  getter for emails
    func fetchInbox() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            let cachedEmail = self.email_addr
            let request: URL = URL(string: "https://www.1secmail.com/api/v1/?action=getMessages&login=\(self.email_addr)&domain=1secmail.com")!
            let requestTask = URLSession.shared.dataTask(with: request) { data, response, error in
                print("fetched inbox")
                print(cachedEmail)
                print(self.email_addr)
                
                if let error = error {
                    print("error occured: \(error)")
                    return
                }
                
                guard let data = data else {return}
                let inbox = self.parseInboxJSON(data: data)
                
                DispatchQueue.main.async {
                    // only updates if the current email address is the same one the request used
                    if cachedEmail == self.email_addr {
                        self.inbox = inbox
                    }
                }
            }
            requestTask.resume()
        }
    }
    
    // gets all of the message meta data for this email address
    func getInbox() -> [InboxModel]? {
        return self.inbox
    }
    
    // @TODO: implement real functionality
    // gets the contents of an individual message
    func getMessageContent(id: Int) -> MessageModel {
        return MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>")
    }
    
    deinit {
        timer!.invalidate()
    }
}
