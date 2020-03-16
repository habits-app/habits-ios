//
//  ContentView.swift
//  Habits
//
//  Created by Mario Hahn on 13.03.20.
//  Copyright © 2020 Mario Hahn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showCreate = false
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationBarTitle("hallo")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showCreate.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
            )
        }
        .sheet(isPresented: $showCreate) {
            CreateView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

extension DateFormatter {
    
    struct Predefined {
        
        public static let `default`: DateFormatter = {
            $0.dateStyle = .full
            $0.timeStyle = .none
            
            return $0
        }(DateFormatter())
    }
}

struct CreateView: View {
    
    @State private var showDatePicker = false
    
    @State private var name: String = ""
    @State private var started: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .multilineTextAlignment(.center)
                .font(Font.largeTitle)
                .padding()
            
            DatePickerRow(date: $started)
                .padding()
            
            Button("Baukasten hinzufügen") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct DatePickerRow: View {
    
    @State private var showDatePicker: Bool = false
    
    var date: Binding<Date>
    
    init(date: Binding<Date>) {
        self.date = date
    }
    
    var body: some View {
        Button(action: {
            self.showDatePicker.toggle()
        }) {
            VStack {
                DateRow(date: date.wrappedValue)
                
                if showDatePicker {
                    DatePicker(selection: date) {
                        Text("")
                    }
                }
            }
        }
        .animation(.interactiveSpring())

    }
}

struct DateRow: View {
    
    var date: Date
    
    var body: some View {
        HStack {
            Text("Seit")
            Spacer()
            Text(DateFormatter.Predefined.default.string(from: date))
        }
    }
}
