//: [Previous](@previous)

import Foundation

import Matter

var juros: Double = 1
//var jurosAnual: Double = 12
//
//var aporteInicial: Double = 0
//var aporteMensal: Double = 330
////var taxaDeJuros: Double = pow((1 + jurosAnual / 100), 1/12) - 1 //sempre converte a taxa de juros anual p/ mensal
////var taxaJurosMensal: Double = juros / 100 // converte o tempo em anos (tempo em anos / 100)
//var tempo = 30
//
/// define te o tempo que o juros é cobrado
enum TipoJuros {
    case year
    case month
}

enum TipoTempo {
    case year
    case month
}
//
//var tipoJuros: TipoJuros = .month
//
//var tipoTempo: TipoTempo = .year

func funcaoDeJuros(startMoney: Double, monthlyContribution: Double, interestRate: Double, timee: Int, timeType: TipoTempo, interestType: TipoJuros) -> Double {
    
    var montante = startMoney
    var t = timee
    var jurosEmDecimal: Double = 0.0 // taxaDeJuros

    if interestType == .year {
        jurosEmDecimal = pow((1 + interestRate / 100), 1/12) - 1
    } else {
        jurosEmDecimal = interestRate / 100
    }
    
    if timeType == .year {
        print("tempo igual a \(timeType)")
        t = timee * 12
    } else {
        print("tempo igual a \(timeType)")
        t = timee
    }
    
    for n in 1...t{
        montante = (montante * (1.0 + jurosEmDecimal)) + monthlyContribution
    }
    
    return montante
//    var stringFormatada = String(format: "%.2f", montante)
//    print(stringFormatada)

}

print(funcaoDeJuros(startMoney: 0.0, monthlyContribution: 330.0, interestRate: 1, timee: 30, timeType: .year, interestType: .month))



//: [Next](@next)
