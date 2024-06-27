import Matter

var aporteInicial: Double = 0
var aporteMensal: Double = 330
var taxaDeJuros: Double = pow((1 + 12 / 100), 1/12) - 1 // sempre converte a taxa de juros anual p/ mensal
var taxaJurosMensal: Double = 1 / 100 // converte o tempo em anos (tempo em anos / 100)
var tempo = 360

var juros = 12.0

var tipoTempo: TipoTempo = .month

print("Taxa de juros: \(taxaDeJuros)")
print("Taxa de juros mensal: \(taxaJurosMensal)")

func funcaoDeJuros(){
    
    var jurosTeste: Double = juros
    var montante = aporteInicial
    var t = tempo
//    var jurosEmDecimal: Double = taxaJurosMensal
    
    if tipoTempo == .year {
        print("Tipo tempo = ano 🗺️")
        jurosTeste = pow((1 + juros / 100), 1/12) - 1
        print(jurosTeste)
    } else if tipoTempo == .month {
        print("Tipo tempo = mês 🗓️")
        jurosTeste = juros / 100
        print(jurosTeste)
    }
    
    for n in 1...t{
        montante = (montante * (1.0 + jurosTeste)) + aporteMensal
    }
    
//    print(montante)
    var stringFormatada = String(format: "%.2f", montante)
    print("Juros compostos: \(stringFormatada)")
}

funcaoDeJuros()

enum TipoTempo {
    case year
    case month
}



//func funcaoDeJuros(){
//    var montante = aporteInicial
//    var t = tempo
//    var jurosEmDecimal: Double = taxaJurosMensal
//    
//    for n in 1...t{
//        montante = (montante * (1.0 + jurosEmDecimal)) + aporteMensal
//    }
//    
//    print(montante)
//}
