//
//  ContentView.swift
//  MapTrain
//
//  Created by Admin on 30.11.2020.
//

import SwiftUI

struct ContentView: View {

    
    var body: some View {
        ZStack{
            MapView()
                .edgesIgnoringSafeArea(.all)
            Button(action: {
            }, label: {
                Image(systemName: "multiply.circle.fill").resizable()
            })
            .frame(width: 90, height: 90)
            .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 125)
            .foregroundColor(.black)

            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//init(_ parent: MapView){
//    self.parent = parent
//}
