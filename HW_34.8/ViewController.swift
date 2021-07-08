//
//  ViewController.swift
//  HW_34.8
//
//  Created by Mykhailo Romanovskyi on 08.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var inputText: UITextField!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 5
        textView.text = "Here will be your posts"
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if (inputText.text?.isEmpty == true) {
            textView.text = "Please input a post number"
        } else {
            guard let post = inputText.text, let postNumber = Int(post) else { return }
            inputText.resignFirstResponder()
            getRequest(with: postNumber)
        }
    }
    
    private func getRequest(with postNumber: Int) {
        let urlOptional = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postNumber)")
        guard let url = urlOptional  else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.textView.text = String(data: data, encoding: .utf8)
                }
            }
            
        }.resume()
    }
}
