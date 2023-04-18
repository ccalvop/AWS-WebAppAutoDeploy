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

:pager:
![guia-crear-usuario3](https://user-images.githubusercontent.com/126183973/232850780-effc2ec2-cbe1-4f3d-9d1f-ee34fe00486d.JPG)




