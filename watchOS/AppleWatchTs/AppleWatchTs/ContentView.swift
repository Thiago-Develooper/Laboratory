import SwiftUI
import CoreHaptics

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Chame a função para ativar o haptic pesado
                generateHapticFeedback(style: .heavy)
            }) {
                Text("Clique aqui")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    // Função para gerar feedback háptico
    func generateHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        // Verifique se o dispositivo suporta feedback háptico
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var engine: CHHapticEngine?
        do {
            // Crie uma instância do mecanismo háptico
            engine = try CHHapticEngine()
            try engine?.start()
            
            // Crie um gerador de feedback háptico
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
            
        } catch let error {
            print("Erro ao criar o mecanismo háptico: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
