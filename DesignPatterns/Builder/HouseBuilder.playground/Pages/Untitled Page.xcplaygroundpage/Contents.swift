//: [Previous](@previous)

import Foundation

/// define te o tempo que o juros é cobrado
enum TipoJuros {
    case year
    case month
    
    var numericValue: Double {
        switch self {
        case.year:
            return 1.0
        case.month:
            return 12.0
        }
    }
}

/// Define o tempo de duração do investimento
enum TipoTempo {
    case year
    case month
}

var aporteInicial: Double = 000
var aporteMensal: Double = 330.0
var taxaDeJuros: Double = pow((1 + 0.12), 1/12) - 1
var tempo = 30


let tipoTempo: TipoTempo = .month
let tipoJuros: TipoJuros = .month

func funcaoDeJuros(){
    var montante = aporteInicial
    var t = tempo
    var jurosEmDecimal: Double = taxaDeJuros
    
    for n in 1...t{
        montante = (montante * (1.0 + jurosEmDecimal)) + aporteMensal
    }
    
    var stringFormatada = String(format: "%.2f", montante)
    
    print(montante)
    print(stringFormatada)
}

//funcaoDeJuros()


func jurosComTempoCorreto(selfTaxaDeJuros: Double) {
    
    var juros: Double
    var montante: Double
    
    montante = aporteInicial
    
    if tipoJuros == .year {
        print("Calculado em anos")
        juros = pow((1 + selfTaxaDeJuros / 100), 1/12) - 1
    } else {
        print("Calculado em meses")
        juros = selfTaxaDeJuros / 100
    }
    
    for n in 1...tempo {
        montante = (montante * (1.0 + juros)) + aporteMensal
    }
    
    print(montante)
}

jurosComTempoCorreto(selfTaxaDeJuros: 12.0)

//: [Next](@next)
