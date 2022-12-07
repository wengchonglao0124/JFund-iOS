//
//  CheckoutViewController.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 7/12/2022.
//

import UIKit
import StripePaymentSheet
import SwiftUI


struct TopUpRequestBody: Codable {
    let amounts: String
}


struct TopUpResponseBody: Codable {
    let ephemeralKey: String?
    let clientSecret: String?
    let customer: String?
}


enum TopUpError: Error {
    case custom(errorMessage: String)
}


class CheckoutViewController: UIViewController {

    private static let backendURL = URL(string: "https://xp.lycyy.cc")!

    private var paymentIntentEphemeralKey: String?
    private var paymentIntentClientSecret: String?
    private var paymentIntentCustomer: String?

    private lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
//        button.setTitle("Pay now", for: .normal)
//        button.backgroundColor = .systemIndigo
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        StripeAPI.defaultPublishableKey = "pk_test_51LImNKAOiNy9BWzWmrjh6L2oHrjbNtPDxaBkavZ4yJnFqy6bDUutFcvZLUFfC5enOPGNDIuTLHISMUes2m5mc0yJ00H7FnRIcj"

        view.backgroundColor = UIColor(Color(red: 246/255, green: 246/255, blue: 246/255))
        view.addSubview(payButton)

        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])


        //self.fetchPaymentIntent()
    }

    func fetchPaymentIntent(accessToken: String, amounts: String, completion: @escaping (Result<String, TopUpError>) -> Void) {
        let url = Self.backendURL.appendingPathComponent("/create-payment-intent")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = TopUpRequestBody(amounts: amounts)
        request.httpBody = try? JSONEncoder().encode(body)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : String],
                let jsonData = json["data"],
                let topUpResponse = try? JSONDecoder().decode(TopUpResponseBody.self, from: Data(jsonData.utf8)),
                let ephemeralKey = topUpResponse.ephemeralKey,
                let clientSecret = topUpResponse.clientSecret,
                let customer = topUpResponse.customer
               
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server."
                self?.displayAlert(title: "Error loading page", message: message)
                completion(.failure(.custom(errorMessage: "Failed to decode response from server.")))
                return
            }

            print("Created PaymentIntent")
            self?.paymentIntentEphemeralKey = ephemeralKey
            self?.paymentIntentClientSecret = clientSecret
            self?.paymentIntentCustomer = customer
            completion(.success("Created PaymentIntent"))

            DispatchQueue.main.async {
                self?.payButton.isEnabled = true
            }
        })

        task.resume()
    }

    func displayAlert(title: String, message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }

    @objc
    func pay(completion: @escaping (String) -> Void) {
        
        guard let paymentIntentCustomer = self.paymentIntentCustomer else {
            completion("fail")
            return
        }
        
        guard let paymentIntentClientSecret = self.paymentIntentClientSecret else {
            completion("fail")
            return
        }
        
        guard let paymentIntentEphemeralKey = self.paymentIntentEphemeralKey else {
            completion("fail")
            return
        }
        
        var customerConfiguration = PaymentSheet.CustomerConfiguration(id: paymentIntentCustomer, ephemeralKeySecret: paymentIntentEphemeralKey)
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Jacaranda, Inc."
        configuration.customer = customerConfiguration
        configuration.allowsDelayedPaymentMethods = true

        let paymentSheet = PaymentSheet(
            paymentIntentClientSecret: paymentIntentClientSecret,
            configuration: configuration)
        
        paymentSheet.present(from: self) { [weak self] (paymentResult) in
            print(paymentResult)
            switch paymentResult {
            case .completed:
                //self?.displayAlert(title: "Payment complete!")
                completion("success")
            case .canceled:
                print("Payment canceled!")
                completion("cancel")
            case .failed(let error):
                completion("fail")
                self?.displayAlert(title: "Payment failed", message: error.localizedDescription)
            }
        }
    }


}


