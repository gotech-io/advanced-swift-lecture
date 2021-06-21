//
//  ToDoDetails.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import SwiftUI

struct ToDoDetails: View {
    let viewModel: TodoItemDetailsViewModel
    
    var body: some View {
        //ZSTACK to add background color
        ZStack(){
            
            //edgesIgnoringSafeArea to color safe are
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(){
                Spacer()
                Text("Todo Details").font(.title).foregroundColor(.hotPink).bold()
                Text(viewModel.todoItem.title).foregroundColor(.black).font(.body).padding()
                HStack(alignment:.center) {
                    Spacer()
                    Image(systemName:"checkmark.circle.fill").resizable().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.hotPink).padding().opacity( viewModel.todoItem.completed ? 1 : 0)
                    Spacer()
                }.padding()
                Spacer()
            }.padding()
            
            
        }
    }
}

struct ToDoDetails_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetails(viewModel: TodoItemDetailsViewModel(todoItem: Item(title: "test")))
    }
}
