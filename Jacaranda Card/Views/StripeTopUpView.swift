//
//  StripeTopUpView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 7/12/2022.
//

import SwiftUI

struct StripeTopUpView: UIViewControllerRepresentable{
    
    typealias UIViewControllerType = CheckoutViewController
    
    let vc = CheckoutViewController()
    
    func makeUIViewController(context: Context) -> CheckoutViewController {
        // Do some configurations here if needed.
        return vc
    }
        
    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
    
    
    func fetchPaymentIntent(accessToken: String, amounts: String, completion: @escaping (Bool) -> Void) {
        
        vc.fetchPaymentIntent(accessToken: accessToken, amounts: amounts) { result in
            
            switch result{
            case .success(let data):
                print(data)
                completion(true)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func pay(completion: @escaping (Bool) -> Void) {
        vc.pay() { result in
            if result == "success" {
                completion(true)
            }
            else if result == "fail" {
                completion(false)
            }
            else {
                // result = "cancel"
                completion(false)
            }
        }
    }
}
