//(
//  SingInScreen.swift
//  wsrRCH2019
//
//  Created by Admin on 14.11.2020.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct SingInScreen: View {
    @State var login : String = ""
    @State var password : String = ""
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    TextField("Ur username", text: $login)
                    TextField("Ur password", text: $password)
                    Button("SingIN"){
                            Loggining(pass: password, log: login)
                    } .frame(width: 200, height: 50)
                    .overlay(Capsule() .stroke(Color.gray,lineWidth: 1))
                    Button("SignUP"){
                        let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
                        let windowScenDelegate = scene.delegate as? SceneDelegate
                        let window = UIWindow(windowScene: scene)
                        window.rootViewController = UIHostingController(rootView: SingUpScreen())
                        windowScenDelegate?.window = window
                        window.makeKeyAndVisible()
                        
                    } .frame(width: 200, height: 50)
                    .clipShape(Capsule())
                }
            }
        }
        
    }
}

struct SingInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SingInScreen()
    }
}



struct SingUpScreen: View {
    @State var login : String = ""
    @State var password : String = ""
    @State var repPassword : String = ""
    @State var email : String = ""
    
    @State var loginIsEmpty : Bool = false
    @State var checkEmail : Bool = false
    @State var checkPassword : Bool = false
    
    @State var shownAlert : Bool = false
    
    // for ali with parameters
    //var head : HTTPHeaders = ["Content-Type": "application/json"]
    var body: some View {
        ZStack{
            VStack {
                TextField("Login", text: $login)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Re-password", text: $repPassword)
                Button("SingUP"){
                    if !(email.isEmpty) {
                        if email.contains("@") && email.contains("."){
                            checkEmail = true
                        } else {checkEmail = false}
                    } else { checkEmail = false}
                    
                    if !(login.isEmpty) {
                        loginIsEmpty = true
                    } else {loginIsEmpty = false}
                    
                    if password == repPassword{
                        checkPassword = true
                    } else {checkPassword = false}
                    
                    if (checkPassword == false ) || (loginIsEmpty == false) || (checkEmail == false) {
                        shownAlert = true
                    } else {print("All good")
                        
                        let url : String = "http://gym.areas.su/signup?username=\(self.login)&password=\(self.password)&email=\(self.email)&weight=80&height=80"
                        
                        AF.request(url, method: .post).validate().responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                
                                Loggining(pass: self.password, log: self.login)
                                print("JSON: \(json)")
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }

//                    AF.request(url ,method: .post , parameters: ["username": "Kawai", "email": "tutemale", "password": "123", "weight": "50","height": "50"], encoding: URLEncoding.default, headers: head).validate().responseJSON { response in
//                        switch response.result {
//                            case .success(let value):
//                                let json = JSON(value)
//                                print("JSON: \(json)")
//                            case .failure(let error):
//                                print(error)
//                        }
//                    }
                    
                    
                }
                
                .alert(isPresented: $shownAlert) {
                    Alert(title: Text("Ошибка"), message: Text("Проверте введенные данные"), dismissButton: .destructive(Text("Cancel")) {
                        self.shownAlert = false
                })
                }
                    
                
                .frame(width: 200, height: 50)
                .overlay(Capsule() .stroke(Color.gray,lineWidth: 1))
            }
        }
    }
}

func Loggining(pass : String, log : String) {
    var url : String = "http://gym.areas.su/signin?username=\(log)&password=\(pass)"
    AF.request(url, method: .post).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            
            UserDefaults.standard.set(log, forKey: "logginedUsername")
            UserDefaults.standard.set(json["notice"]["token"].stringValue, forKey: "logginedToken")
            
            let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
            let windowScenDelegate = scene.delegate as? SceneDelegate
            let window = UIWindow(windowScene: scene)
            window.rootViewController = UIHostingController(rootView: Loggined())
            windowScenDelegate?.window = window
            window.makeKeyAndVisible()
            
            print("JSON: \(json)")
        case .failure(let error):
            print(error)
        }
    }

}

struct Loggined : View {
    var body: some View {
        Text(UserDefaults.standard.string(forKey: "logginedToken") ?? "Zelepa")
        Text(UserDefaults.standard.string(forKey: "logginedUsername") ?? "Zelepa")
        Button("SignOUT"){
            
            let url : String = "http://gym.areas.su/signout?username=\(UserDefaults.standard.string(forKey: "logginedUsername")!)"
            
            AF.request(url, method: .post).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                }
            }
            
            let scene = UIApplication.shared.connectedScenes.first as! UIWindowScene
            let windowScenDelegate = scene.delegate as? SceneDelegate
            let window = UIWindow(windowScene: scene)
            window.rootViewController = UIHostingController(rootView: SingInScreen())
            windowScenDelegate?.window = window
            window.makeKeyAndVisible()
            
            
        } .frame(width: 200, height: 50)
        .overlay(Capsule() .stroke(Color.gray,lineWidth: 1))
    }
}
