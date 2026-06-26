# Nexus Health - Microservicio de Pacientes (ms_pacientes)

## Descripcion del Proyecto
Este repositorio contiene el microservicio `ms_pacientes` del sistema Nexus Health, diseñado para la gestion y validacion de datos de pacientes. Como parte de la Evaluacion Parcial 3 de Ingenieria DevOps, este proyecto ha sido extendido para incorporar un entorno real automatizado, garantizando observabilidad, trazabilidad y cumplimiento normativo.

## 1. Arquitectura de Observabilidad (Monitoreo y Metricas)
Para asegurar una operación confiable y transparente, se implementó el siguiente stack tecnológico mediante Docker Compose:
* **Prometheus:** Encargado de la recolección de metricas de uso y rendimiento expuestas por el microservicio mediante Spring Boot Actuator.
* **Loki:** Centraliza y gestiona los logs transaccionales del sistema (ej. consultas de RUT exitosas o fallidas controladas).
* **Grafana:** Proporciona dashboards interactivos que unifican las métricas de Prometheus y los logs de Loki. Esto nos permite visualizar en tiempo real:
    * Tiempos de respuesta de la API.
    * Consumo de recursos (CPU/Memoria).
    * Trazabilidad de errores.

## 2. Pipeline CI/CD y Políticas de Cumplimiento
El ciclo de vida del software está automatizado mediante GitHub Actions (`.github/workflows/ci.yml`).

* **Integración Continua:** Ante cada `push` o `pull_request` a la rama principal, el pipeline compila el codigo en un entorno con JDK 21 y ejecuta las pruebas unitarias automatizadas.
* **Calidad y Seguridad (SonarCloud):** Se integró SonarQube (SonarCloud) para evaluar la cobertura de código, bugs y vulnerabilidades.
* **Quality Gate (Bloqueo Automático):** El pipeline está configurado con el parámetro `-Dsonar.qualitygate.wait=true`. Si SonarCloud detecta una falla crítica de seguridad o no se cumplen los estándares de calidad definidos, el proceso se interrumpe automáticamente, protegiendo el entorno productivo.

## 3. Toma de Decisiones Técnicas Informadas
La integración de estas herramientas en nuestro flujo de trabajo nos permite tomar decisiones basadas en datos concretos:
* **Dashboards de Grafana:** Nos ayudan a identificar cuellos de botella. Si observamos picos de latencia en la consulta de pacientes por RUT, podemos decidir si es necesario optimizar las consultas a la base de datos o escalar el servicio.
* **Alertas y Logs de Loki:** Al tener trazabilidad sobre el origen de los fallos (ej. picos de `ResourceNotFoundException`), podemos decidir si el problema es un ataque, un error de usuario o una falla de comunicación con `ms-auditoria`.
* **SonarQube en el Pipeline:** Nos obliga a no acumular deuda técnica. Si el pipeline se detiene por baja cobertura, la decisión técnica inmediata es no fusionar la rama hasta que el desarrollador implemente las pruebas faltantes.
