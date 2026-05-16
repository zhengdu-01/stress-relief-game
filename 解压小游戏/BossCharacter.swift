import SwiftUI

struct BossCharacter: View {
    let isMale: Bool
    let mood: BossMood
    let isStunned: Bool
    
    var body: some View {
        ZStack {
            PixelBossBody(isMale: isMale)
            PixelBossFace(isMale: isMale, mood: mood)
            
            if isStunned {
                StunStars()
            }
        }
    }
}

struct PixelBossBody: View {
    let isMale: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.2, green: 0.2, blue: 0.3))
                .frame(width: 120, height: 100)
                .cornerRadius(8)
            
            PixelSuit(isMale: isMale)
            
            Rectangle()
                .fill(isMale ? Color(red: 0.95, green: 0.8, blue: 0.6) : Color(red: 1.0, green: 0.85, blue: 0.7))
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .offset(y: -30)
        }
    }
}

struct PixelSuit: View {
    let isMale: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 50)
            
            Rectangle()
                .fill(Color(red: 0.15, green: 0.2, blue: 0.35))
                .frame(width: 100, height: 80)
                .cornerRadius(4)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 30, height: 50)
                .offset(y: -65)
            
            if isMale {
                Rectangle()
                    .fill(Color(red: 0.5, green: 0.1, blue: 0.1))
                    .frame(width: 8, height: 30)
                    .cornerRadius(2)
                    .offset(y: -55)
            }
        }
    }
}

struct PixelBossFace: View {
    let isMale: Bool
    let mood: BossMood
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isMale ? Color(red: 0.95, green: 0.8, blue: 0.6) : Color(red: 1.0, green: 0.85, blue: 0.7))
                .frame(width: 70, height: 70)
                .cornerRadius(8)
                .offset(y: -40)
            
            PixelGlasses()
                .offset(y: -40)
            
            PixelEyes(mood: mood)
                .offset(y: -40)
            
            PixelMouth(mood: mood)
                .offset(y: -25)
            
            if isMale {
                PixelHair()
                    .offset(y: -70)
            } else {
                PixelFemaleHair()
                    .offset(y: -75)
            }
        }
    }
}

struct PixelGlasses: View {
    var body: some View {
        HStack(spacing: 8) {
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 20, height: 15)
            
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 20, height: 15)
        }
    }
}

struct PixelEyes: View {
    let mood: BossMood
    
    var body: some View {
        HStack(spacing: 20) {
            EyeShape(mood: mood)
            EyeShape(mood: mood)
        }
    }
}

struct EyeShape: View {
    let mood: BossMood
    
    var body: some View {
        switch mood {
        case .arrogant:
            Circle()
                .fill(Color.black)
                .frame(width: 6, height: 6)
        case .angry:
            Capsule()
                .fill(Color.black)
                .frame(width: 8, height: 10)
        case .委屈:
            VStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 5, height: 5)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 3, height: 3)
                    .offset(y: 5)
            }
        case .beg:
            Circle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
        }
    }
}

struct PixelMouth: View {
    let mood: BossMood
    
    var body: some View {
        switch mood {
        case .arrogant:
            Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 20, height: 10)
        case .angry:
            Arc(startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 20, height: 10)
        case .委屈:
            Arc(startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 15, height: 8)
        case .beg:
            Ellipse()
                .fill(Color.black)
                .frame(width: 25, height: 12)
        }
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        return path
    }
}

struct PixelHair: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.2, green: 0.15, blue: 0.1))
            .frame(width: 75, height: 25)
            .cornerRadius(8, corners: [.topLeft, .topRight])
    }
}

struct PixelFemaleHair: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.3, green: 0.2, blue: 0.15))
                .frame(width: 85, height: 40)
                .cornerRadius(12, corners: [.topLeft, .topRight])
            
            HStack {
                Rectangle()
                    .fill(Color(red: 0.3, green: 0.2, blue: 0.15))
                    .frame(width: 15, height: 50)
                    .cornerRadius(8)
                    .offset(y: 20)
                
                Spacer()
                
                Rectangle()
                    .fill(Color(red: 0.3, green: 0.2, blue: 0.15))
                    .frame(width: 15, height: 50)
                    .cornerRadius(8)
                    .offset(y: 20)
            }
            .frame(width: 85)
        }
    }
}

struct StunStars: View {
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                StarShape()
                    .fill(Color.yellow)
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat(i * 30 - 30), y: -80)
                    .rotationEffect(.degrees(rotation + Double(i * 60)))
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let points = 5
        let outerRadius = rect.width / 2
        let innerRadius = outerRadius * 0.4
        
        for i in 0..<points * 2 {
            let angle = Double(i) * .pi / Double(points) - .pi / 2
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    VStack {
        BossCharacter(isMale: true, mood: .arrogant, isStunned: false)
        BossCharacter(isMale: true, mood: .angry, isStunned: false)
        BossCharacter(isMale: true, mood: .委屈, isStunned: false)
        BossCharacter(isMale: true, mood: .beg, isStunned: true)
        BossCharacter(isMale: false, mood: .arrogant, isStunned: false)
    }
}
