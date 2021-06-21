//
//  ContentView.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import SwiftUI
import Combine

struct TodoList: View {
    //simple state object that controls when to display AddNewTodo view
    @State var showAddToDo = false
    
    //for custom object we need to use StateObject instead state
    //and use Published for properties inside StateObject
    @StateObject private var viewModel = ToDoListViewModel()

    var body: some View {
        // NavigationView is the counterpart of UINavigation
        NavigationView() {
            ZStack {
                Color.turquoise.edgesIgnoringSafeArea(.all)
                VStack() {
                    Picker(selection: $viewModel.showItems, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                        Text("All").tag(0)
                        Text("Not Finished").tag(1)
                    }).pickerStyle(SegmentedPickerStyle()).padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing:15))
                    
                    //The counterpart of UITableView.
                    //it's very simple to use , hust pass the data . and build the view to use inside
                    List(viewModel.items) { item in
                        //NavigationLink is the SwiftUI way to navigate to new view
                        NavigationLink(destination: ToDoDetails(viewModel: TodoItemDetailsViewModel(todoItem: item))) {
                            TodoCell(viewModel: TodoItemViewModel(todoItem: item))
                        }
                    }.listStyle(PlainListStyle())
                    .navigationBarTitle(Text("Todo List"))
                    
                    Button(action: {
                        self.showAddToDo.toggle()
                    }) {
                        Spacer()
                        Text("Add a task").foregroundColor(.white).padding()
                        Spacer()
                    }.sheet(isPresented: $showAddToDo) {
                        AddNewTodo()
                    }.background(Color.hotPink)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }.accentColor(.black)
    }
    
}

//Cell for list
struct TodoCell: View {
    let viewModel: TodoItemViewModel

    func toggle(){
        viewModel.changeComplete()
    }
    
    var body: some View {
        HStack {
            Button(action: toggle){
                //Counterpart if UIImageView
                Image(systemName: viewModel.todoItem.completed ? "checkmark.circle.fill" : "circle").foregroundColor(.hotPink)
                
            }.buttonStyle(PlainButtonStyle())
            Text("\(viewModel.todoItem.title)")
                .frame(alignment: .leading)
                .font(.headline).padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
