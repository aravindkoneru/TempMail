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
    
    //  init method
    init() {
        self.email_addr = ""
        self.inbox = [InboxModel]()
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
    func loadInbox() {
        //creates the timer to refresh every second and run the code in the block
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            //creates the url that will make the API call
            let url = URL(string: "https://www.1secmail.com/api/v1/?action=getMessages&login=\(self.email_addr)&domain=1secmail.com")!
            
            //sends URL request to server
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedResponse = try JSONDecoder().decode([InboxModel].self, from: data)
                        // we have good data – go back to the main thread
                        DispatchQueue.main.async {
                            // update our inbox instance variable
                            self.inbox = decodedResponse
                        }
                    } else {
                        print("No Data to fetch")
                    }
                } catch {
                    print("Fetch failed: \(error.localizedDescription )")
                }
            }.resume()
        }
    }
    
    
    //  getter for email addr
    func getEmailAddr() -> String {
        return email_addr
    }
    //  getter for emails
    func getEmails() -> [InboxModel] {
        return inbox
    }
    
    
    // @TODO: implement real functionality
    // gets the contents of an individual message
    func getMessageContent(id: Int) -> MessageModel {
        return MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>")
    }
}
