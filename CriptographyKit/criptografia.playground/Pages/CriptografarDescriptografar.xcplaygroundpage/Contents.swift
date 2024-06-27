//: [Previous](@previous)
import UIKit
import CryptoKit

// Defina uma chave simétrica
let key = SymmetricKey(size: .bits256)

// Mensagem a ser criptografada
let message = "Hello world"

// Criptografar a mensagem
let sealedBox = try! AES.GCM.seal(message.data(using: .utf8)!, using: key)

// Converta a imagem criptografada para uma representação de string e imprima
if let sealedBoxData = sealedBox.combined {
    let sealedBoxString = sealedBoxData.base64EncodedString()
    print("Imagem criptografada: \(sealedBoxString)")
}

// Descriptografar a mensagem
let decryptedData = try! AES.GCM.open(sealedBox, using: key)
let decryptedMessage = String(data: decryptedData, encoding: .utf8)!

print("Mensagem original: \(message)")
print("Mensagem descriptografada: \(decryptedMessage)")

//: [Next](@next)
