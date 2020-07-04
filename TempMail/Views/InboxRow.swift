//
//  MessageRow.swift
//  TempMail
//
//  Created by Aravind Koneru on 6/1/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct InboxRow: View {
    var messageInfo: InboxModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(messageInfo.from)")
            .font(.headline)
            .foregroundColor(Color(UIColor.label))
            .lineLimit(1)
            .truncationMode(.tail)
            
            Text("\(messageInfo.subject)")
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    .padding()
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        InboxRow(messageInfo: InboxModel(id: 1234,
                                           from: "sender@example.com",
                                           subject: "example subject",
                                           date: "Today"))
    }
}
