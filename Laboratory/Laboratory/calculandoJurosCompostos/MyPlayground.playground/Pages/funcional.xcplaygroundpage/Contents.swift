//: [Previous](@previous)

import Foundation
import Matter

/// define te o tempo que o juros é cobrado
enum TipoJuros {
    case year
    case month
}

var juros: Double = 12

var tipoJuros: TipoJuros = .year

var aporteInicial = 0.0
var aporteMensal = 330.0
var tempo = 360

var doom: Double = pow((1 + 12 / 100), 1/12) - 1
print("💰")

func calcJurosCompostos() {
    var montante = aporteMensal
    var jurosRefinado: Double = 0.0
    
    if tipoJuros == .year {
        jurosRefinado = doom
        print("Taxa de juros: \(jurosRefinado)")
    }
    
    for n in 1...tempo{
        montante = (montante * (1.0 + jurosRefinado)) + aporteMensal
    }
    
    var stringFormatada = String(format: "%.2f", montante)
    print(stringFormatada)

}

calcJurosCompostos()

//: [Next](@next)
