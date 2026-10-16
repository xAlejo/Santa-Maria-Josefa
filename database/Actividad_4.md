# Actividad 4: Diseñar Modelo Entidad-Relación

## Descripción

Se diseñó un modelo Entidad-Relación para representar la estructura de la base de datos que será utilizada por la página web del Consultorio Santa María Josefa. El modelo considera la información necesaria para administrar especialidades médicas, profesionales, horarios de atención, datos de contacto e información institucional.
<br>
```mermaid
graph TD
    CW[CONTENIDO WEB]
        
    CW --> Imagen
    CW --> Contacto
    CW --> Nosotros
    CW --> Especialidades
    CW --> Horario
    CW --> Ubicación

    style CW fill:#fff,stroke:#333,stroke-width:1px
    style Imagen fill:#fff,stroke:#333,stroke-width:1px
    style Contacto fill:#fff,stroke:#333,stroke-width:1px
    style Nosotros fill:#fff,stroke:#333,stroke-width:1px
    style Especialidades fill:#fff,stroke:#333,stroke-width:1px
    style Horario fill:#fff,stroke:#333,stroke-width:1px
    style Ubicación fill:#fff,stroke:#333,stroke-width:1px
```
