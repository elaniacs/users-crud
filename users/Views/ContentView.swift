//
//  ContentView.swift
//  users
//
//  Created by Cáren Sousa on 24/09/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var user: FetchedResults<User>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(totalUsersRegistered()) registered")
                    .foregroundColor(.red)
                    .padding(.horizontal)
                List {
                    ForEach(user) { user in
                        NavigationLink(destination: EditUserView(user: user)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(user.completeName!)
                                        .bold()
                                }
                                Spacer()
                                Text(calcTimeSince(date: user.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteUser)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add User", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddUserView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteUser(offsets: IndexSet) {
        withAnimation {
            DataController().deleteUser(user:  offsets.map { user[$0] }, offsets: offsets, context: managedObjContext)
        }
    }
    
    private func totalUsersRegistered() -> Int {
        return user.count
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
