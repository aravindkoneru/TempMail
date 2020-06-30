//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var email: Email = Email()
    //TODO: this variable is for later, when I implement a feature that will save user data even when the app is closed
    private let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Temp Mail")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    print("copy to clipboard")
                    UIPasteboard.general.string = "\(self.email.getEmailAddr())@1secmail.com"
                }) {
                    Text("\(self.email.getEmailAddr())@1secmail.com")
                        .padding()
                        .foregroundColor(.black)
                        .font(.title)
                }
                
                Spacer()
                
                Button(action: {
                    self.email.reset()
                    
                }) {
                    Text("Generate New Email")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 5))
                }.padding()
                
                //I just added the optional value for testing purposes.
                //TODO: Remove and replace with the actual error messages.
                List(self.email.getInbox() ?? [InboxModel]()) { message in
                    NavigationLink(destination: MessageView(message: self.email.getMessageContent(id: message.id) ?? MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>"))) {
                        InboxRow(messageInfo: message)
                    }
                }
                .navigationBarHidden(true)
                .navigationBarTitle("", displayMode: .inline)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
