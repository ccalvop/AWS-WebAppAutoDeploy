# AWS-WebAppAutoDeploy
## Implementación automática de una aplicación web utilizando servicios de AWS

<br>

Proyecto colaborativo desarrollado por:

**Artem Pavlenko** [Linkedin](https://www.linkedin.com/in/srpavlenko/)

**Carlos Brizuela** [Linkedin](linkedin.com/in/carlos-b-aws-cloud)

**Carlos Calvo** [Linkedin](https://www.linkedin.com/in/carlos-calvo-pareja/)
<br>
<hr>

El proyecto lo dividiremos en dos partes:

**1**. Creación de un usuario AWS con los permisos adecuados

**2**. Desarrollo e implementación de la aplicación web en AWS
- Creación de un repositorio de GitHub para alojar el código de la aplicación web.
- Diseño y desarrollo de una aplicación web simple utilizando HTML, CSS y JavaScript.
- Configuración de un bucket de S3 para alojar y servir la aplicación web.
- Configuración de AWS CodePipeline y CodeBuild para el proceso de CI/CD.
- Creación de un webhook en GitHub para desencadenar automáticamente el proceso de CI/CD.
- Pruebas y documentación del proceso de CI/CD.

```
CI/CD es un acrónimo que se refiere a la Integración Continua (Continuous Integration, CI) y la Entrega Continua (Continuous Delivery, CD).

-Integración Continua (CI): Es la práctica de combinar automáticamente el código de los desarrolladores en un repositorio centralizado. El objetivo de la CI es detectar y solucionar rápidamente los problemas de integración y garantizar que el código esté siempre en un estado desplegable.

-Entrega Continua (CD): Es el proceso de desplegar automáticamente las aplicaciones en producción después de pasar por las etapas de CI.
```

***

## 1. Creación de un usuario en AWS con permisos adecuados
👍 _Antes de comenzar con el proyecto crearemos un nuevo usuario con los permisos adecuados:_

1. Inicia sesión en la consola de AWS con tu cuenta de administrador.

2. Navega al servicio **IAM (Identity and Access Management)**.

3. En el panel de navegación izquierdo, selecciona **Users** y haz clic en **Add user**.

4. Ingresa un nombre de usuario (por ejemplo, `WebAppAutoDeployUser`). En este punto, no selecciones ninguna de las opciones disponibles y simplemente haz clic en **Next: Permissions**.

5. En la página "Set permissions", selecciona la opción **Attach existing policies directly**. Busca y selecciona las siguientes políticas:

   - `AmazonS3FullAccess`
   - `AWSCodePipeline_FullAccess`
   - `AWSCodeBuildAdminAccess`
   - `AWSCloudFormationFullAccess`
   
   Estas políticas otorgan al usuario los permisos necesarios para trabajar con S3, CodePipeline, CodeBuild y CloudFormation.

6. Haz clic en **Next: Tags**. Puedes agregar etiquetas si lo deseas, pero no son necesarias para este proyecto. Haz clic en **Next: Review**.

7. Revisa la configuración del usuario y haz clic en **Create user**.

:pager:
![guia-crear-usuario](https://user-images.githubusercontent.com/126183973/232841803-42df89c9-fc1e-4fe0-bf66-747ef9b83b6d.JPG)

8. Para acceder a la consola de AWS con el nuevo usuario, necesitarás crear una contraseña y proporcionar acceso a la consola:
 
   - Busca y selecciona el usuario que acabas de crear (WebAppAutoDeployUser).
   - En la página de resumen del usuario, ve a la pestaña Security credentials.
   - En la sección Console sign-in, haz clic en **Enable console access**
   - Crea una contraeña o generala automaticamente y requiere opcionalmente que el usuario cambie su contraseña en el primer inicio de sesión.


:pager:
![guia-crear-usuario2](https://user-images.githubusercontent.com/126183973/232850735-31654c1f-e19b-4990-8f67-c69f003898e3.JPG)

![guia-crear-usuario3](https://user-images.githubusercontent.com/126183973/232850780-effc2ec2-cbe1-4f3d-9d1f-ee34fe00486d.JPG)
<br>
<hr>

## 2. Desarrollo e implementación de la aplicación web en AWS

1. Creación de un **repositorio de GitHub** para alojar el código de la aplicación web.

   En nuestro caso [AWS-WebAppAutoDeploy](https://github.com/ccalvop/AWS-WebAppAutoDeploy)

2. Diseño y desarrollo de una **aplicación web** simple utilizando HTML, CSS y JavaScript:

   Crea los siguientes archivos en la raíz de tu repositorio de GitHub: `index.html` `styles.css` `script.js`

3. Configuración de un **bucket de S3** para alojar y servir la aplicación web:
   
   1. Navega al servicio Amazon S3.
   2. Haz clic en Create bucket.
   3. Ingresa un nombre único para el bucket (por ejemplo, mi-webapp-autodeploy) y selecciona la región en la que deseas crear el bucket. 
   4. Permite el acceso público al bucket desmarcando "Block all public access".
   5. Haz clic en Create.
   6. Ve a la sección Permisos, Bucket policy o Política de bucket y haz clic en Edit.
   7. Agrega la siguiente política al editor de políticas:
      ![buckets3-3 policy](https://user-images.githubusercontent.com/126183973/232858066-a18ba578-e2d7-4b69-9527-5cc547eb062e.png)
   8. Configura el bucket como página web estática. En propiedades: **Alojamiento de sitios web estáticos** `Editar`
   9. En **Index document o Documento de índice** especificamos el nombre de la página: `index.html`
      ![buckets3-5](https://user-images.githubusercontent.com/126183973/232861967-72c4fc28-0959-43c7-bb81-32c30a462e88.JPG)
<br>
<hr>

**AWS CodePipeline** y **AWS CodeBuild** en este proyecto

```
- **AWS CodePipeline** es un servicio de entrega continua que nos permite automatizar el flujo de trabajo de CI/CD. En este proyecto, su función es organizar y coordinar las diferentes etapas del proceso, desde la obtención del código fuente hasta la implementación en Amazon S3. CodePipeline nos proporciona una visión general del estado de cada etapa y facilita la automatización del proceso de CI/CD.

- **AWS CodeBuild** es un servicio de compilación completamente administrado que compila y prueba automáticamente el código fuente cada vez que hay un cambio en el repositorio. En este proyecto, se encargará de compilar, validar y empaquetar la aplicación web antes de que sea implementada en Amazon S3. CodeBuild se integra con CodePipeline como una etapa dentro del proceso de CI/CD.
```
   Vamos a utilizar **AWS CodePipeline** para organizar y coordinar el flujo de trabajo de CI/CD, mientras que **AWS CodeBuild** se encargará de la compilación,        validación y empaquetamiento de la aplicación web como una etapa dentro de ese flujo de trabajo.

<br>
   
4. Configuración de **AWS CodePipeline** para crear un proceso de CI/CD

5. Configuración de **AWS CodeBuild** para compilar y desplegar la aplicación web en el bucket de S3


