//
//  MessageRow.swift
//  TempMail
//
//  Created by Aravind Koneru on 6/1/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct MessageRow: View {
    var messageInfo: InboxModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(messageInfo.from)")
                    .font(.headline)
                Spacer()
                Text("\(messageInfo.date)")
                    .font(.subheadline)
            }
            
            Text("\(messageInfo.subject)")
                .font(.subheadline)            
        }
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(messageInfo: InboxModel(id: 1234,
                                           from: "sender@example.com",
                                           subject: "example subject",
                                           date: "Today"))
    }
}
