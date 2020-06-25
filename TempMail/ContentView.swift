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
                    .foregroundColor(Color(UIColor.label))
                
                Button(action: {
                    print("copy to clipboard")
                    UIPasteboard.general.string = "\(self.email.getEmailAddr())@1secmail.com"
                }) {
                    Text("\(self.email.getEmailAddr())@1secmail.com")
                        .padding()
                        .foregroundColor(Color(UIColor.label))
                        .font(.title)
                }
                
                Button(action: {
                    self.email.reset()
                    
                }) {
                    Text("Generate New Email")
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(UIColor.systemBlue), lineWidth: 5))
                }.padding()
                
                Spacer()
                
                if (self.email.getInbox() == nil) {
                    Text("No Mail")
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .font(.title)
                        .frame(width: 150, height: 200, alignment: .top)
                    
                    Spacer()
                } else {
                    List(self.email.getInbox()!) { message in
                        NavigationLink(destination: MessageView(message: self.email.getMessageContent(id: message.id))) {
                            InboxRow(messageInfo: message)
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("Inbox", displayMode: .inline)
        }
        .statusBar(hidden: false)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .dark)
            ContentView()
                .environment(\.colorScheme, .light)
        }
        
    }
}
