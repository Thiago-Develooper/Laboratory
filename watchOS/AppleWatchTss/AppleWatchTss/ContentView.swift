import SwiftUI
import CoreHaptics

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Chame a função para ativar o haptic pesado
                generateHapticFeedback()
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
    func generateHapticFeedback() {
        // Verifique se o dispositivo suporta feedback háptico
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var engine: CHHapticEngine?
        do {
            // Crie uma instância do mecanismo háptico
            engine = try CHHapticEngine()
            try engine?.start()
            
            // Crie um evento para feedback háptico pesado
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 1)
            
            // Crie um padrão com o evento
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            
            // Crie um player com o padrão
            let player = try engine?.makePlayer(with: pattern)
            
            // Inicie a reprodução do feedback háptico
            try player?.start(atTime: CHHapticTimeImmediate)
            
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
