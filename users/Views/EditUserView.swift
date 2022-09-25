//
//  EditUserView.swift
//  users
//
//  Created by Cáren Sousa on 24/09/22.
//

import SwiftUI

struct EditUserView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var completeName = ""
    @State private var email = ""
    @State private var password = ""
    
    var user: FetchedResults<User>.Element
    
    var body: some View {
        Form {
            Section(header: Text("YOUR INFO")) {
                TextField("Enter your complete name", text: $completeName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .onAppear {
                        completeName = user.completeName!
                        email = user.email ?? ""
                        password = user.password ?? ""
                    }
            }
            Section(header: Text("PASSWORD")) {
                SecureTextFieldView(text: $password)
                    .textInputAutocapitalization(.never)
            }
            Section {
                Button("Submit") {
                    if !completeName.isEmpty {
                        DataController().editUser(user: user, completeName: completeName, email: email, password: password, context: managedObjContext)
                        dismiss()
                    }
                    
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .navigationBarTitle("Update Form")
    }
}
