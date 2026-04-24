# 🛒TuDespensa 
La Solucion movil diseñada para optimizar la gestión de víveres y productos del hogar, y hacer rendir tu bolsillo y maximizar la eficiencia del gasto familiar.

## 📱Caracteristicas propias del movil 
- **Portabilidad Crítica**: Acceso instantáneo a la app.
- **Interfaz Táctil Optimizada**: Selección rápida de productos y ajuste de cantidades mediante gestos.
- **Notificaciones Locales**: Alertas o recordatorios sobre el presupuesto.
- **Modo Offline**: Capacidad de consultar y editar la lista de compras incluso en pasillos de supermercados con baja cobertura.
### 📋Requerimientos (historias de usuarios y RF/RNF)
#### RF
- El sistema debe permitir el ingreso de un presupuesto total
- El sistema debe permitir agregar, editar u eliminar cosas de la despensa
- El sistema debe calcular automaticamente el gasto proyecto vs el presupuesto real e identificar el restante
- los productos deben poder clasificarse por niveles de prioridad
#### RNF
- La aplicacion debe ser reactiva y mostrar actualizaciones en tiempo real
- los datos deben persistir en el dispocitivo (persistencia de datos)

## Diagrama de flujo del caso de uso principal

```mermaid
graph TD
    A[Inicio: Usuario abre la App] --> B{¿Tiene presupuesto?}
    B -- No --> C[Definir Budget Mensual]
    B -- Sí --> D[Agregar/Seleccionar Producto]
    C --> D
    D --> E[Asignar Prioridad y Precio Estimado]
    E --> F{¿Precio <= Presupuesto?}
    F -- Sí --> G[Añadir a Lista de Compra]
    F -- No --> H[Alerta: Excede Presupuesto]
    G --> I[Actualizar Saldo Restante]
    H --> I
    I --> J[Fin: Visualización de Despensa]
```

## Investigacion
### Archivo [RESEARCH](RESEARCH.md) incluyendo la informacion de investigacion.




