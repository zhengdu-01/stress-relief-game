import SwiftUI

struct OfficeBackground: View {
    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.8, blue: 0.75)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                WallDecorations()
                    .frame(height: 200)
                
                DeskArea()
                
                Spacer()
            }
        }
    }
}

struct WallDecorations: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.8, green: 0.75, blue: 0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                WindowView()
                    .frame(width: 150, height: 180)
                
                Spacer()
                
                CertificateView()
                    .frame(width: 100, height: 130)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct WindowView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.6, green: 0.8, blue: 0.9))
                .border(Color(red: 0.4, green: 0.3, blue: 0.2), width: 8)
            
            VStack(spacing: 4) {
                Rectangle()
                    .fill(Color(red: 0.4, green: 0.3, blue: 0.2))
                    .frame(height: 4)
                
                HStack(spacing: 4) {
                    Rectangle()
                        .fill(Color(red: 0.4, green: 0.3, blue: 0.2))
                        .frame(width: 4)
                    Spacer()
                    Rectangle()
                        .fill(Color(red: 0.4, green: 0.3, blue: 0.2))
                        .frame(width: 4)
                }
            }
            .padding(4)
            
            CloudShape()
                .fill(Color.white)
                .frame(width: 40, height: 20)
                .offset(x: -30, y: -40)
            
            CloudShape()
                .fill(Color.white.opacity(0.8))
                .frame(width: 30, height: 15)
                .offset(x: 30, y: -20)
        }
        .cornerRadius(4)
    }
}

struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width * 0.3, y: rect.height * 0.6),
                   radius: rect.height * 0.4,
                   startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.width * 0.6, y: rect.height * 0.4),
                   radius: rect.height * 0.5,
                   startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.width * 0.8, y: rect.height * 0.6),
                   radius: rect.height * 0.35,
                   startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        return path
    }
}

struct CertificateView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.85, green: 0.75, blue: 0.6))
                .border(Color(red: 0.5, green: 0.35, blue: 0.2), width: 4)
            
            VStack(spacing: 8) {
                Text("优秀领导")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.primary)
                
                Rectangle()
                    .fill(Color(red: 0.7, green: 0.6, blue: 0.5))
                    .frame(height: 20)
                
                Text("2024年度")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            .padding(10)
        }
        .cornerRadius(2)
    }
}

struct DeskArea: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color(red: 0.6, green: 0.4, blue: 0.25))
                .frame(height: 60)
            
            VStack(spacing: 0) {
                DeskSurface()
                
                HStack(spacing: 20) {
                    CabinetView()
                    Spacer()
                    ComputerView()
                }
                .padding(.horizontal, 30)
                .offset(y: -120)
            }
        }
    }
}

struct DeskSurface: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.55, green: 0.35, blue: 0.2))
                .frame(height: 30)
            
            Rectangle()
                .fill(Color(red: 0.45, green: 0.28, blue: 0.15))
                .frame(height: 120)
                .offset(y: 75)
        }
    }
}

struct CabinetView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.5, green: 0.35, blue: 0.2))
                .frame(width: 80, height: 100)
                .cornerRadius(4)
            
            VStack(spacing: 4) {
                Drawer()
                Drawer()
                Drawer()
            }
            .padding(4)
        }
    }
}

struct Drawer: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.4, green: 0.28, blue: 0.15))
            
            Circle()
                .fill(Color(red: 0.3, green: 0.2, blue: 0.1))
                .frame(width: 8, height: 8)
        }
        .frame(height: 28)
    }
}

struct ComputerView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(red: 0.2, green: 0.25, blue: 0.3))
                    .frame(width: 100, height: 80)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(Color(red: 0.3, green: 0.3, blue: 0.35))
                    .frame(width: 20, height: 20)
                
                Rectangle()
                    .fill(Color(red: 0.25, green: 0.25, blue: 0.3))
                    .frame(width: 60, height: 10)
                    .cornerRadius(2)
            }
            
            Rectangle()
                .fill(Color(red: 0.3, green: 0.5, blue: 0.7))
                .frame(width: 90, height: 70)
                .offset(y: -5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("报表.xlsx")
                    .font(.system(size: 6))
                    .foregroundColor(.black)
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 1)
                Text("数据: OK")
                    .font(.system(size: 5))
                    .foregroundColor(.black)
            }
            .frame(width: 80, alignment: .leading)
            .offset(y: -5)
        }
    }
}

#Preview {
    OfficeBackground()
}
