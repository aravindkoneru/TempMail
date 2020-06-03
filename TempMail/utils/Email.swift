//
//  Email.swift
//  TempMail
//
//  Created by Paul Jojy on 6/3/20.
//  Copyright © 2020 Paul Jojy. All rights reserved.
//

//This is supposed to be an "Email" Object. The purpose of the email object will be to generate and store the email address, along with the emails attached to it. 
import SwiftUI

struct Email: Hashable, Codable {
    var email_addr:String?
    
    mutating func GenEmail() {
        //list of acceptable chars
         let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         //returns a random permutation of letters; string of up to length 9 for email addr
         self.email_addr = String((0..<9).map{ _ in letters.randomElement()!})
     }
     
     //getter for email addr
     func getEmailAddr() -> String {
         if email_addr != nil{
             return "Current Address: \(email_addr!)@1secmail.com"
         }
         else{
             return "Press \"Generate New Email\" to get started! "
         }
     }
    //getter for emails
    func getEmails(){
        //make the HTTP GET request to return the JSON shit
    }
}
