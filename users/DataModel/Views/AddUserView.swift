//
//  AddUserView.swift
//  users
//
//  Created by Cáren Sousa on 24/09/22.
//

import SwiftUI

struct AddUserView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var completeName = ""
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        Form {
            Section(header: Text("YOUR INFO")) {
                TextField("Enter your complete name", text: $completeName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
            }
            Section(header: Text("PASSWORD")) {
                TextField("Password", text: $password)
                    .textInputAutocapitalization(.never)
            }
            Section {
                HStack {
                    Button("Submit") {
                        if !completeName.isEmpty {
                            DataController().addUser(completeName: completeName, email: email, password: password, context: managedObjContext)
                            
                             dismiss()
                        }
                    }.buttonStyle(BorderlessButtonStyle())
                    Spacer()
                    
                    Button("Cancel") {
                        dismiss()
                    } .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .navigationBarTitle("Registration Form")
    }
}
//
//struct AddUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUserView()
//    }
//}
