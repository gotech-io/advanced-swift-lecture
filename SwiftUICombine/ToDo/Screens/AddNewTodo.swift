//
//  AddNewTodo.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import SwiftUI

struct AddNewTodo: View {
    @StateObject private var viewModel = AddNewTodoViewModel()
    //we use this Environment variable to dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    //using this envirement state we can check our colorScheme dark or light
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                
                Text("Add new Item").font(.title).bold()
                
                TextField("Description", text: $viewModel.title)
                    .padding()
                    .border( colorScheme == .dark ? Color.white : Color.black, width: 1)
                
                Button(action: {
                    viewModel.addTask()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Spacer()
                    Text("Add").padding().foregroundColor(.white)
                    Spacer()
                }).background(Color.hotPink).cornerRadius(10)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Spacer()
                    Text("Cancel").padding().foregroundColor(.white)
                    Spacer()
                }).background(Color.gray).cornerRadius(10)
                Spacer()
               
            }.padding()
           
           
        }
        
    }
}

struct AddNewTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTodo()
    }
}
