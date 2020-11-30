//
//  ContentView.swift
//  wsrRCH2019
//
//  Created by Admin on 13.11.2020.
//

import SwiftUI
import RealmSwift

class observer : ObservableObject {
    @Published var boolFirst : Bool = false
    @Published var boolSecond : Bool = false
}

struct ContentView: View {
    var body: some View{
        SingInScreen()
    }
}



struct emptyScen : View {
    var body: some View {
        Button {
            
            let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
            let windowScenDelegate = scene.delegate as? SceneDelegate
            let window = UIWindow(windowScene: scene)
            window.rootViewController = UIHostingController(rootView: firstStep())
            windowScenDelegate?.window = window
            window.makeKeyAndVisible()
            
            
            
            
            
//            let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
//                                    let windowSceneDelegate = scene.delegate as? SceneDelegate
//                                    let window = UIWindow(windowScene: scene)
//                                    window.rootViewController = UIHostingController(rootView: firstStep() )
//                                    windowSceneDelegate?.window = window
//                                    window.makeKeyAndVisible()
                                    
            
        } label: {
            Text("Кубик льда кинь меня")
        } .frame(width: 300, height: 75)
        .foregroundColor(Color.black)
        
        .overlay(Capsule() .stroke(Color.gray, lineWidth: 1))
        .background(Color.white)
        .animation(.spring())
    }
}

struct firstStep : View{
    @State var arrayName : Array = ["Weight lose","Keeping fit","Built muscule"]
    @State var icons : Array = ["weight","fit","muscule"]
    
    @State var isPresented = false
    var body: some View{
        NavigationView{
            VStack{
                ZStack{
                    // color str
                    Color("mainColor").opacity(0.69)
                        .edgesIgnoringSafeArea(.all)
                    // text
                    VStack{
                            someText(currStep: "1")
                    } .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 4.5)
                    
                    VStack{
                        ForEach(0..<arrayName.count, id:\.self) { index in
                            HStack(){
                                Image(icons[index])
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    //.position(x: 50, y: 38)
                                
                                Button {
                                    let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
                                    let windowScenDelegate = scene.delegate as? SceneDelegate
                                    let window = UIWindow(windowScene: scene)
                                    window.rootViewController = UIHostingController(rootView: secondStep())
                                    windowScenDelegate?.window = window
                                    window.makeKeyAndVisible()
                                    
                                } label: {
                                    Text(arrayName[index])
                                }
                                    
                                .frame(width: 220, height: 76)
                                .foregroundColor(Color("mainColor"))
                                .font(.system(size: 21))
                            }
                            
                            .frame(width: 300, height: 76)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .overlay(Capsule() .stroke(Color.gray, lineWidth: 1))
                        }
                        
                    } .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 1.7)
                }
            }
        }
        
    }
}

struct secondStep: View {
    
    var body: some View{
        NavigationView{
            VStack{
                ZStack{
                    Color("mainColor").opacity(0.69)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                            someText(currStep: "2")
                          //
                    } .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 4.5)

                    VStack{
                        HStack{
                            VStack{
                                
                                Button { //action
                                    UserDefaults.standard.set("Female", forKey: "userSex")
                                } label: {
                                    Image("Female").resizable()
                                }
                                .frame(width: 125, height: 125)
                                .background(Color.white)
                                .clipShape(Circle())

                                Text("Female")
                                    .frame(width: 125, height: 50)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 25))
                            }
                            .padding(.trailing, 100)
                            
                            VStack{
                                Button { // action
                                    UserDefaults.standard.set("Male", forKey: "userSex")
                                } label: {
                                    Image("Male").resizable()
                                } .frame(width: 125, height: 125)
                                .background(Color.white)
                                .clipShape(Circle())
                                
                                Text("Male")
                                    .frame(width: 125, height: 50)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 25))
                            }
                        }
                        
                        .padding(.bottom, 100)
                        
                        
                        Button {
                            
                            let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
                            let windowScenDelegate = scene.delegate as? SceneDelegate
                            let window = UIWindow(windowScene: scene)
                            window.rootViewController = UIHostingController(rootView: thirdStep())
                            windowScenDelegate?.window = window
                            window.makeKeyAndVisible()
                            
                          
                            
                        } label: {
                            Text("Next").font(.system(size: 25))
                                .foregroundColor(Color("mainColor"))
                        }.frame(width: 300, height: 76)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .overlay(Capsule() .stroke(Color.gray, lineWidth: 1))
                        
                    } .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height / 1.7)
                }
            }
            .animation(.spring())
        } .navigationBarHidden(true)
        
        
    }
}


struct thirdStep : View{
    var body: some View {
        NavigationView{
            VStack{
                Text("Nu ti blizok")
                Button {
                    let def : String = UserDefaults.standard.string(forKey: "userSex")!
                    print("\(String(def)) usex")
                } label: {
                    Text("Tikni menya")
                }.padding()
            }
            

        }.navigationBarHidden(true)
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}




struct someText : View{
    @State var currStep : String
    var body : some View {
        Text("Step \(currStep)/5")
            .foregroundColor(.white)
            .font(.system(size: 50))
            .padding(.bottom, 50)
        Text("What is your purpose?")
            .foregroundColor(.white)
    }
}
