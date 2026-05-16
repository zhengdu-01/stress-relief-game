import SwiftUI

struct WeaponCard: View {
    let weapon: WeaponType
    let onUse: (CGPoint) -> Void
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.95, green: 0.9, blue: 0.8))
                .frame(width: 100, height: 140)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
            
            VStack(spacing: 8) {
                WeaponIcon(weapon: weapon)
                    .frame(width: 50, height: 50)
                
                Text(weapon.name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(weapon.rarity)
                    .font(.system(size: 10))
                    .foregroundColor(weapon.color)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(weapon.color.opacity(0.2))
                    .cornerRadius(4)
                
                Text("伤害: \(weapon.damage)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .offset(offset)
        .scaleEffect(scale)
        .gesture(
            DragGesture()
                .onChanged { value in
                    isDragging = true
                    offset = value.translation
                    scale = 1.1
                }
                .onEnded { value in
                    let dropPoint = CGPoint(x: value.location.x, y: value.location.y)
                    onUse(dropPoint)
                    withAnimation(.spring()) {
                        offset = .zero
                        scale = 1.0
                    }
                    isDragging = false
                }
        )
        .animation(.spring(), value: offset)
    }
}

struct WeaponIcon: View {
    let weapon: WeaponType
    
    var body: some View {
        ZStack {
            switch weapon {
            case .rottenVegetable:
                RottenVegetableIcon()
            case .stinkyEgg:
                StinkyEggIcon()
            case .kitchenKnife:
                KitchenKnifeIcon()
            case .tiffany:
                TiffanyIcon()
            }
        }
    }
}

struct RottenVegetableIcon: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color(red: 0.4, green: 0.6, blue: 0.2))
                .frame(width: 40, height: 25)
            
            Ellipse()
                .fill(Color(red: 0.3, green: 0.5, blue: 0.1))
                .frame(width: 25, height: 15)
                .offset(x: 5, y: -5)
            
            Circle()
                .fill(Color(red: 0.2, green: 0.3, blue: 0.05))
                .frame(width: 8, height: 8)
                .offset(x: 10, y: 5)
        }
    }
}

struct StinkyEggIcon: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color(red: 0.9, green: 0.85, blue: 0.6))
                .frame(width: 35, height: 45)
            
            Ellipse()
                .fill(Color(red: 0.7, green: 0.65, blue: 0.4))
                .frame(width: 20, height: 15)
                .offset(x: 5, y: 10)
            
            Path { path in
                path.move(to: CGPoint(x: 30, y: 10))
                path.addCurve(to: CGPoint(x: 45, y: -5),
                             control1: CGPoint(x: 35, y: 0),
                             control2: CGPoint(x: 40, y: -5))
            }
            .stroke(Color(red: 0.6, green: 0.6, blue: 0.4), lineWidth: 2)
        }
    }
}

struct KitchenKnifeIcon: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.7, green: 0.7, blue: 0.7))
                .frame(width: 15, height: 40)
                .cornerRadius(2, corners: [.topLeft, .topRight])
            
            Rectangle()
                .fill(Color(red: 0.8, green: 0.8, blue: 0.8))
                .frame(width: 10, height: 35)
                .offset(y: -2)
            
            Rectangle()
                .fill(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(width: 20, height: 12)
                .cornerRadius(2)
                .offset(y: 25)
        }
    }
}

struct TiffanyIcon: View {
    var body: some View {
        ZStack {
            DiamondShape()
                .fill(Color(red: 0.29, green: 0.73, blue: 0.71))
                .frame(width: 40, height: 40)
            
            DiamondShape()
                .fill(Color(red: 0.4, green: 0.8, blue: 0.8))
                .frame(width: 25, height: 25)
        }
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    HStack(spacing: 20) {
        WeaponCard(weapon: .rottenVegetable, onUse: { _ in })
        WeaponCard(weapon: .stinkyEgg, onUse: { _ in })
        WeaponCard(weapon: .kitchenKnife, onUse: { _ in })
        WeaponCard(weapon: .tiffany, onUse: { _ in })
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
