//
//  ContentView.swift
//  gridTrain
//
//  Created by Admin on 30.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State var images = ["bed.double.fill","tv.music.note.fill","multiply.circle.fill", "hare.fill"]
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                LazyVGrid(columns:
                            [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())
                            ],spacing: 3){
                    ForEach(images, id: \.self){ img in
                        Image(systemName: img)
                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .onTapGesture(count: 1, perform: {
                                print("U tapped \(img)")
                            })
                            
                            .onLongPressGesture(minimumDuration: 1) {
                                self.images.remove(at: self.images.index(of: img)!)
                                print("removed")
                            }

                        
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
