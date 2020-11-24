//
//  LoadingVC.swift
//  VKClient
//
//  Created by AntonSobolev on 22.11.2020.
//

import UIKit

class LoadingVC: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    private var countOfAnimations = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimatingViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViews()
    }
    
    private func setupAnimatingViews() {
        
        firstView.layer.cornerRadius = firstView.bounds.height * 0.5
        secondView.layer.cornerRadius = secondView.bounds.height * 0.5
        thirdView.layer.cornerRadius = thirdView.bounds.height * 0.5
    }
    
    private func animateViews() {
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.firstView.alpha = 1
                        self.firstView.alpha = 0
                        self.thirdView.alpha = 1
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.5,
                                       animations: {
                                        self.firstView.alpha = 1
                                        self.secondView.alpha = 1
                                        self.secondView.alpha = 0
                                       },
                                       completion: { _ in
                                        UIView.animate(withDuration: 0.5,
                                                       animations: {
                                                        self.thirdView.alpha = 1
                                                        self.thirdView.alpha = 0
                                                        self.secondView.alpha = 1
                                                       },
                                                       completion: { _ in
                                                        if self.countOfAnimations != 3 {
                                                            self.countOfAnimations += 1
                                                            self.animateViews()
                                                        } else {
                                                            self.showLoginVC()
                                                        }
                                                       })
                                       })
                       })
    }
    
    
    private func showLoginVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC: LoginVC = storyBoard.instantiateViewController(withIdentifier: "loginView") as! LoginVC
        self.present(loginVC, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
