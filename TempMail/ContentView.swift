//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
//    variable for Email struct
    @ObservedObject var email: Email = Email()
    //this variable is for later, when I implement a feature that will save user data even when the app is closed
    private let defaults = UserDefaults.standard
    
    // TODO: can the header be abstracted? lots of repeated code...
    var body: some View {
        return HStack {
            if orientation.isPortrait || orientation.isFlat {
                VStack {
                    Text("Temp Mail")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    
                    Button(action: {
                        self.email.setNewEmailAddr()
                    }) {
                        Text("Generate New Email")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.blue, lineWidth: 5))
                    }
                    
                    Spacer()
                    
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
                    
                    List {
                        MessageRow(messageInfo: InboxModel(id: 1234,
                                                           from: "sender@example.com",
                                                           subject: "example subject",
                                                           date: "Today"))
                        MessageRow(messageInfo: InboxModel(id: 1234,
                                                           from: "sender@example.com",
                                                           subject: "example subject",
                                                           date: "Today"))
                    }
                                        
                }
            } else {
                VStack {
                    Text("Temp Mail")
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: {
                        self.email.setNewEmailAddr()
                    }) {
                        Text("Generate New Email")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.blue, lineWidth: 5))
                    }
                    
                    Button(action: {
                        print("copy to clipboard")
                        UIPasteboard.general.string = "\(self.email.getEmailAddr())@1secmail.com"
                    }) {
                        Text("\(self.email.getEmailAddr())@1secmail.com")
                            .padding()
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                
                Spacer()
                
                List {
                    MessageRow(messageInfo: InboxModel(id: 1234,
                                                       from: "sender@example.com",
                                                       subject: "example subject",
                                                       date: "Today"))
                    MessageRow(messageInfo: InboxModel(id: 1234,
                                                       from: "sender@example.com",
                                                       subject: "example subject",
                                                       date: "Today"))
                }
                
            }
        }
        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) {_ in
            self.orientation = UIDevice.current.orientation
            print("portrait?: \(self.orientation.isPortrait)")
            print("flat?: \(self.orientation.isFlat)\n")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
