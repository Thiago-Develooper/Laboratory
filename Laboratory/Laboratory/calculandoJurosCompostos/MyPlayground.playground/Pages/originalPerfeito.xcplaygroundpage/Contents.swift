//: [Previous](@previous)

import Foundation

import Matter

var juros: Double = 1
var jurosAnual: Double = 12

var aporteInicial: Double = 0
var aporteMensal: Double = 330
var taxaDeJuros: Double = pow((1 + jurosAnual / 100), 1/12) - 1 //sempre converte a taxa de juros anual p/ mensal
var taxaJurosMensal: Double = juros / 100 // converte o tempo em anos (tempo em anos / 100)
var tempo = 360

func funcaoDeJuros(){
    var montante = aporteInicial
    var t = tempo
    var jurosEmDecimal: Double = taxaDeJuros
//    print("Juros em decimal: \(jurosEmDecimal)")
    print("Taxa de juros: \(taxaDeJuros)")
    print("Taxa de Mensal: \(taxaJurosMensal)")
    
    for n in 1...t{
        montante = (montante * (1.0 + jurosEmDecimal)) + aporteMensal
    }
    
//    print(montante)
    var stringFormatada = String(format: "%.2f", montante)
    print(stringFormatada)

}

funcaoDeJuros()

//: [Next](@next)
