//
//  ContentView.swift
//  Hero
//
//  Created by Balaji on 04/07/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        Home()
            .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State var selected : Travel = data[0]
    @State var show = false
    @Namespace var namespace
    // to load Hero View After Animation is done....
    @State var loadView = false
    
    var body: some View{
        
        ZStack{

            ScrollView(.vertical, showsIndicators: false) {
                
                HStack{
                    
                    Text("MIrjalol777 🔥")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        
                        Image(systemName: "cart")
                            .foregroundColor(.black)
                           
                        
                    }
                }
                // due to top area is ignored...
                .padding([.horizontal,.top])
                
                // Grid View...
                
                LazyVGrid(columns: columns,spacing: 25){
                    
                    ForEach(data){travel in
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            Image(travel.image)
                                .resizable()
                                .frame(height: 180)
                                .cornerRadius(15)
                                // assigning ID..
                                .onTapGesture {
                                    
                                    withAnimation(.spring()){
                                        
                                        show.toggle()
                                        selected = travel
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            
                                            loadView.toggle()
                                        }
                                    }
                                }
                                .matchedGeometryEffect(id: travel.id, in: namespace)
                            
                            Text(travel.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding([.horizontal,.bottom])
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)

            // Hero View....
            
            if show{
                
                VStack{
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        
                       
                        
                        if loadView{
                            
                            
                            HStack{
                                
                                Button {
                                    
                                    loadView.toggle()
                                    
                                    withAnimation(.spring()){
                                        
                                        show.toggle()
                                    }
                                    
                                } label: {
                                 
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(Circle())
                                }

                                Spacer()
                                
                                Button {
                                    
                                    
                                } label: {
                                 
                                    Image(systemName: "cart")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                
                            }
                            .padding(.top,45)
                            .padding(.horizontal)
                           
                            
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Image(selected.image)
                            .resizable()
                            .frame(height: 300)
                            .matchedGeometryEffect(id: selected.id, in: namespace)
                    }
                    
                    // you will get this warning becasue we didnt hide the old view so dont worry about that it will work fine...
                    
                    // Detail View....
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        // loading after animation completes...
                        
                        if loadView{
                            
                            VStack{
                                
                               
                            }
                        }
                    }
                }
                .background(Color.white)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        // hiding for hero Vieww.....
        .statusBar(hidden: show ? true : false)
    }
}

// sample Data...

struct Travel : Identifiable {
    
    var id : Int
    var image : String
    var title : String
}

var data = [

    Travel(id: 0, image: "sweater1", title: "London"),
    Travel(id: 1, image: "sweater2", title: "USA"),
    Travel(id: 2, image: "sweater3", title: "Canada"),
    Travel(id: 3, image: "sweater4", title: "Australia"),
    Travel(id: 4, image: "sweater5", title: "Germany"),
    Travel(id: 5, image: "sweater6", title: "Dubai"),

]
