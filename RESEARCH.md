# 📄Investigacion
## 📱Aplicaciones Similares
### - Bring! Lista de compras (Web/Desktop)
- Esta Aplicacion esta enfocada en listas compartidas, pero tiene un control menos detallado respecto a los presupuestos.

### - Out of milk
- Una Aplicacion muy completa respecto a los inventarios, pero tiene la desventaja de no ser muy facil de utilizar debido a todas sus funciones no siendo tan atractiva para un usuario promedio que busca control de presupuesto rapido.

### - SoftList
- Una Aplicacion con una excelente gestion de precios, pero con una interfaz que suele ser menos intuitiva que una solucion nativa, sin sistema de prioridades.

## ⚠️Problemas con las alternativas
Las aplicaciones similares encontradas, suelen ser opciones solidas pero todas en excepcion de softlist cuentan con un problema, son aplicaciones con muchos features y que terminan relentizando el proceso de gestionar nuestra despensa, ademas de considerar que Bring! es de tipo web y desktop pero no necesariamente optimizada para movil
### 🔴Problemas encontrados
- Aplicaciones muy complejas.
- Exceso de features.
- Aplicacion Desactualizada (como `softlist`).
- Falta de prioridad al `Budget`.
## 💡Idea de nuestra solucion movil
Tomar la idea base y simplificarla con el objectivo de que al momento que utilizemos la app no corramos por los mismos problemas que tienen las otras apps.
### 🟢Problemas a solucionar
- Simplificar la app
- Integrar funciones simples para evitar hacerla un problema sino que una ayuda.
- Utilizar recursos modernos y actualizables para mantener la app actualizada.
- Volver la principal prioridad de la aplicacion el `budget` de la despensa.

## 📱Detalles tecnicos
### ⚙️Framework: Flutter
El uso de flutter nos ayudara a la velocidad de produccion y desarrollo de la app al utilizar una sola base de codigo.
### 🎯Lenguaje: `Dart`
Lenguaje PRINCIPAL utilizado en el framework de flutter.
### 🖥️Implementacion de las funcionalidades
Para cumplir con las características propias del móvil, la arquitectura se basará en los siguientes pilares técnicos:
#### ‼️ Sistema de Prioridades (Lógica de Negocio)
Se implementará mediante un **Enumerado (`enum`)** en Dart para categorizar los productos. Esto permite realizar filtrados eficientes en la interfaz de usuario:
* `Priority.high` (Necesarios)
* `Priority.medium` (Básicos)
* `Priority.low` (Opcionales/Extra)

#### 💰 Visualización de Presupuestos en Tiempo Real
Para que el usuario vea el impacto de cada producto en su bolsillo instantáneamente:
* **Gestión de Estado:** Se utilizará el paquete `Provider`. Al modificar el precio de un producto, el `BudgetNotifier` notificará a los widgets de la cabecera para actualizar el saldo restante sin refrescar toda la pantalla.
* **Segregación de Gastos:** La app calculará sub-totales por categoría para informar al usuario cuánto está gastando solo en "Esenciales".

#### 📷 Implementación de Cámara y Persistencia de Imágenes
Esta funcionalidad permite que el usuario no tenga que escribir nombres largos, sino reconocer el producto visualmente:
* **Captura:** Uso del paquete `image_picker` para disparar la cámara nativa.
* **Almacenamiento Local:** Las fotos se guardarán en el directorio de documentos del sistema (usando `path_provider`) para asegurar que persistan aunque se limpie la caché.
* **Base de Datos:** Se utilizará `sqflite` (SQLite) para almacenar un registro tipo "catálogo". 
    * **Esquema:** (id, nombre, precio, prioridad, image_path).
    * **Funcionalidad de Modificación:** Al seleccionar un producto ya registrado, la app consultará la base de datos por el `image_path` y permitirá actualizar el campo `precio` mediante un formulario reactivo.


