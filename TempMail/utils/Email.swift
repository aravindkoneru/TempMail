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
    
    //  init method
    init() {
        self.email_addr = ""
        setNewEmailAddr()
    }
    //  generates an email address
    func setNewEmailAddr() -> Void {
        //list of acceptable chars
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //      returns a random permutation of letters; string of up to length 9       for email addr
        self.email_addr = String((0..<9).map{ _ in letters.randomElement()!})
    }
    
    //  getter for email addr
    func getEmailAddr() -> String {
        return email_addr
    }
    //  getter for emails
    func getEmails() {
        //        make the HTTP GET request to return the JSON shit
    }
    
    // @TODO: implement real functionality
    // gets all of the message meta data for this email address
    func getInbox() -> [InboxModel] {
        return [
            InboxModel(id: 1234,
                       from: "sender@example.com",
                       subject: "example subject",
                       date: "Today"),
            InboxModel(id: 1234,
                       from: "sender@example.com",
                       subject: "example subject",
                       date: "Today")]
    }
    
    // @TODO: implement real functionality
    // gets the contents of an individual message
    func getMessageContent(id: Int) -> MessageModel {
        return MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>")
    }
}
