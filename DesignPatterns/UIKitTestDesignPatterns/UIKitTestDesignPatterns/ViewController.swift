//
//  ViewController.swift
//  UIKitTestDesignPatterns
//
//  Created by Thiago Pereira de Menezes on 30/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Criar um retângulo rosa
        let pinkRectangle = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        pinkRectangle.backgroundColor = .systemPink
        pinkRectangle.center = view.center
        view.addSubview(pinkRectangle)
        
        // Adicionar um gesto de toque ao retângulo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pinkRectangleTapped))
        pinkRectangle.addGestureRecognizer(tapGesture)
        pinkRectangle.isUserInteractionEnabled = true
    }
    
    // Método chamado quando o retângulo é tocado
    @objc func pinkRectangleTapped() {
        // Criar uma nova instância da próxima visualização
        let nextViewController = NextViewController()
        
        // Navegar para a próxima visualização
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

class NextViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue // Definindo o fundo da nova view como azul
    }
}
