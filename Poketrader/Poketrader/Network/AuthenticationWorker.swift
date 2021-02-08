//
//  LoginService.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

import Firebase

class AuthenticationWorker: GenericWorker {
    private var logou: Bool = false
    
    func login(email: String, senha: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: senha) { (authResult, error) in
            if let error = error {
                completion(error)
                return
            }
            if let _ = authResult {
                let usuario = User.userInstance.requestForUser()
                usuario.nome = authResult?.user.displayName
                usuario.email = authResult?.user.email
                usuario.telefone = authResult?.user.phoneNumber
                completion(nil)
            }
        }
    }
    
    func signup(nome: String, telefone: String, email: String, senha: String, imagem: Data?, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: senha) { (authResult, error) in
            if let error = error {
                completion(error)
                return
            }
            if let authResult = authResult {
                let user = authResult.user
                let db = Firestore.firestore()
                db.collection("telefones").document(user.uid).setData([
                    "telefone": telefone
                ]) { err in
                    if let _error = error {
                        print("Erro ao adicionar o telefone... \(_error)")
                    }
                }
                let changeRequest = user.createProfileChangeRequest()
                var photoURL: URL?
                changeRequest.displayName = nome
                if let imagemData = imagem {
                    let profileImageStorageRef = Storage.storage().reference().child("profile_image_urls").child("\(user.uid).png")
                    profileImageStorageRef.putData(imagemData, metadata: nil) { (metadata, error) in
                        if let _error = error {
                            print("Erro ao adicionar a imagem \(_error)")
                        } else {
                            profileImageStorageRef.downloadURL { (url, error) in
                                if let _error = error {
                                    print("Erro ao pegar imagem no Firebase \(_error)")
                                } else {
                                    if let url = url {
                                        photoURL = url
                                    }
                                }
                            }
                        }
                    }
                }
                if photoURL != nil {
                    changeRequest.photoURL = photoURL!
                }
                changeRequest.commitChanges { (error) in
                    if let _error = error {
                        print("Deu ruim ao commitar alterações \(_error)")
                    }
                }
                completion(nil)
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let _error = error {
                completion(_error)
            } else {
                completion(nil)
            }
        }
    }
    
    func upload(nome: String, telefone: String, email: String, console: String, imagem: Data?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("telefones").document(Auth.auth().currentUser!.uid).setData([
            "telefone": telefone
        ]) { error in
            if let _error = error {
                print("Erro ao adicionar o telefone... \(_error)")
            }
        }
        let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
        var photoURL: URL?
        changeRequest.displayName = nome
        if let imagemData = imagem {
            let profileImageStorageRef = Storage.storage().reference().child("profile_image_urls").child("\(Auth.auth().currentUser!.uid).png")
            profileImageStorageRef.putData(imagemData, metadata: nil) { (metadata, error) in
                if let _error = error {
                    print("Erro ao adicionar a imagem \(_error)")
                } else {
                    profileImageStorageRef.downloadURL { (url, error) in
                        if let _error = error {
                            print("Erro ao pegar imagem no Firebase \(_error)")
                        } else {
                            if let url = url {
                                photoURL = url
                            }
                        }
                    }
                }
            }
        }
        if photoURL != nil {
            changeRequest.photoURL = photoURL!
        }
        changeRequest.commitChanges { (error) in
            if let _error = error {
                print("Deu ruim ao commitar alterações \(_error)")
            }
        }
        completion(nil)
    }
}
