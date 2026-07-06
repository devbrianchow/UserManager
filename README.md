# UserManager

Proyecto de ejemplo iOS para gestión de usuarios construida con SwiftUI, siguiendo MVVM + Coordinator + Clean Architecture.

## 🏗 Arquitectura

MVVM + Coordinator + Clean Architecture dividida en capas:

```
UserManager/
├── Data/
│   ├── Repositories/    
│   ├── Persistence/          
│   └── Network/
      └── DTOs/
      └── APIService/  
├── App/
├── Domain/
│   ├── Entities/          
│   ├── UsesCases/       
│   └── Repositories/
├── Services/
│   └── LocationService
├── Coordinator/    
├── Presentation/
    ├── Components/ 
│   ├── UserList/        
│   ├── CreateUser/      
│   └── UserDetail/      
└── Utils/
└── Resources/   
```

---

## ✅ Features

- Listado de usuarios desde API remota
- Persistencia local con Realm
- Creación de usuario con validaciones
- Obtención de ubicación (latitud/longitud)
- Edición y eliminación de usuarios
- Soporte multilenguaje (Localizable.strings)

---

## 📋 Requisitos

- iOS 16+
- Xcode 15+
- Swift 5.5+

---

## ⚙️ Instalación

1. Clona el repositorio
```bash
git clone https://github.com/tu-usuario/UserManager.git
```
2. Abre `UserManager.xcodeproj`
3. Selecciona un simulador o dispositivo fisico
4. `⌘R` para correr

---

## 📍 Permisos

Agrega en `Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Necesitamos tu ubicación para completar el registro.</string>
```

## 🏗 Demo
<img width="335" height="697" alt="Captura de pantalla 2026-07-05 a la(s) 9 36 10 p  m" src="https://github.com/user-attachments/assets/8cbdd001-fe7a-4968-8998-3c0301fd4b96" />
