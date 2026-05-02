# 🛒TuDespensa 
La Solucion movil diseñada para optimizar la gestión de víveres y productos del hogar, y hacer rendir tu bolsillo y maximizar la eficiencia del gasto familiar.
<p align="center">
  <img src="githubImages/6.png" width="15%">
  <img src="githubImages/5.png" width="15%">
  <img src="githubImages/4.png" width="15%">
  <img src="githubImages/3.png" width="15%">
  <img src="githubImages/2.png" width="15%">
  <img src="githubImages/1.png" width="15%">
</p>

## 👤 Historias de Usuarios

HU1: Como jefe del hogar, quiero definir un presupuesto mensual para evitar sobreendeudarme en el supermercado.

HU2: Como Estudiante universitario, debo mantener un presupuesto muy estrecho, por ello debo saber que es importante para saber qué artículos descartar si el dinero no alcanza.

HU3: Como joven adulto ahora vivo solo, para ello debo empezar a organizar mi presupuesto y mantener lo necesario en mi hogar asi tener mas dinero para el resto del mes.

## 📖 Guía de Uso (Manual de Usuario)

Para sacar el máximo provecho a **TuDespensa** y hacer rendir tu presupuesto mensual, sigue estos pasos:

### 1. Definir tu Presupuesto (Budget)
* Al iniciar el mes, dirígete a la pestaña **Presupuesto**.
* Ingresa el monto total de dinero que tienes destinado para tus compras del hogar. Este será tu límite máximo.

### 2. Organización de la Despensa
* Ve a la pestaña **Despensa**.
* Agrega los productos que necesitas comprar. 
* **Importante:** Clasifica cada producto según su prioridad:
    * 🔴 **Necesarios:** Alimentos básicos y artículos de higiene indispensables.
    * 🟠 **Básicos:** Productos que son útiles pero pueden esperar si el presupuesto es ajustado.
    * 🔵 **Opcionales/Extras:** Gustos personales o premios que solo comprarás si sobra dinero.

### 3. Registro con Cámara
* Cuando estés en el supermercado o almacén, usa el icono de la **Cámara** para registrar el producto real.
* Esto te permitirá reconocer la marca y el formato exacto en futuras compras sin tener que escribirlo de nuevo.

### 4. Control en el Punto de Venta
* A medida que agregas productos al carrito físico, verifica en la App cómo se reduce tu **Saldo Disponible**.
* Si el saldo llega a cero, la App te avisará. En ese momento, puedes decidir eliminar los productos de prioridad **Opcional** para dar espacio a los **Necesarios**.

### 5. Actualización de Precios
* Si el precio de un producto cambió desde la última vez, simplemente selecciónalo en la lista y actualiza el valor. El presupuesto se recalculará automáticamente.

## 📱Caracteristicas propias del movil 
- **Portabilidad Crítica**: Acceso instantáneo a la app.
- **Interfaz Táctil Optimizada**: Selección rápida de productos y ajuste de cantidades mediante gestos.
- **Notificaciones Locales**: Alertas o recordatorios sobre el presupuesto.
- **Modo Offline**: Capacidad de consultar y editar la lista de compras incluso en pasillos de supermercados con baja cobertura.
## 📋Requerimientos (historias de usuarios y RF/RNF)
### RF
- El sistema debe permitir el ingreso de un presupuesto total
- El sistema debe permitir agregar, editar u eliminar cosas de la despensa
- El sistema debe clasificar productos por niveles de prioridad.
- El sistema debe calcular automaticamente el gasto proyecto vs el presupuesto real e identificar el restante
- los productos deben poder clasificarse por niveles de prioridad
### RNF
- La aplicacion debe ser reactiva y mostrar actualizaciones en tiempo real
- Los datos deben persistir en el dispocitivo (persistencia de datos)
- La Navegacion del patron Master-Detail para gestionar los items
- Funcion "blur" para ocultar informacion sensible (montos financieros del usuario y no de los productos)
- Implementacion del ThemeData Global en el main

## 📂 Arquitectura y patrones 
Se aplicó una arquitectura modular para garantizar el bajo acoplamiento y la escalabilidad del proyecto:

- ** models/**: Contiene las clases de datos **(`Product`, `Pantry`)** y la lógica de negocio.
- ** screens/**: Interfaces de usuario independientes (Home, Budget, Inventory).
- ** widgets/**: Componentes reutilizables para mantener la modularidad de la UI. (actualmente no utilizada)

**Jerarquía de Navegación:** Se implementó un sistema de rutas centralizado y gestión de la pila (Push/Pop) para asegurar un flujo lógico y coherente.

## Caso de uso principal (Happy Path)
El foco técnico de esta maqueta es la **"Optimización de Presupuesto mediante Priorización"**.
### Diagrama de flujo del caso de uso principal

```mermaid
graph TD
    A[Inicio: Usuario abre la App] --> B[Splash Screen: Identidad Visual]
    B --> C{¿Configuró Presupuesto?}
    
    C -- No --> D[Pantalla Presupuesto: Asignar Monto Mensual]
    C -- Sí --> E[Home: Resumen de Despensa y Saldo]
    
    D --> E
    
    E --> F[Pantry Detail: Lista de Productos]
    F --> G[Añadir Producto desde Catálogo Maestro]
    
    G --> H[Asignar Cantidad +/- y Prioridad]
    H --> I[Cálculo Automático: Precio * Cantidad]
    
    I --> J{¿Costo <= Saldo Disponible?}
    
    J -- Sí --> K[Actualizar Saldo y Mostrar en Verde]
    J -- No --> L[Alerta: Saldo Insuficiente en Rojo]
    
    K --> M[Visualización con Opción de Privacidad -Blur-]
    L --> M
    
    M --> N[Fin: Gestión de Inventario Realizada]
```

## Material de Apoyo
- [**Video de Exposición**](https://youtu.be/fHktvrKx_qc)

## Investigacion
### Archivo [RESEARCH](RESEARCH.md) incluyendo la informacion de investigacion.




