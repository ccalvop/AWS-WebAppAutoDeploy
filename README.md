# AWS-WebAppAutoDeploy
Implementación automática de una aplicación web utilizando servicios de AWS

<br>

Proyecto colaborativo desarrollado por:

**Artem Pavlenko** [Linkedin](https://www.linkedin.com/in/srpavlenko/)

**Carlos Brizuela** [Linkedin](linkedin.com/in/carlos-b-aws-cloud)

**Carlos Calvo** [Linkedin](https://www.linkedin.com/in/carlos-calvo-pareja/)
<br>
<br>

👍 _Antes de comenzar con el proyecto crearemos un nuevo usuario en AWS con los permisos adecuados:_
### Creación de un usuario en AWS con permisos adecuados

1. Inicia sesión en la consola de AWS con tu cuenta de administrador.

2. Navega al servicio **IAM (Identity and Access Management)**.

3. En el panel de navegación izquierdo, selecciona **Users** y haz clic en **Add user**.

4. Ingresa un nombre de usuario (por ejemplo, `WebAppAutoDeployUser`) y selecciona la casilla **Programmatic access** como tipo de acceso. Haz clic en **Next: Permissions**.

5. En la página "Set permissions", selecciona la opción **Attach existing policies directly**. Busca y selecciona las siguientes políticas:

   - `AmazonS3FullAccess`
   - `AWSCodePipelineFullAccess`
   - `AWSCodeBuildAdminAccess`
   - `AWSCloudFormationFullAccess`
   
   Estas políticas otorgan al usuario los permisos necesarios para trabajar con S3, CodePipeline, CodeBuild y CloudFormation.

6. Haz clic en **Next: Tags**. Puedes agregar etiquetas si lo deseas, pero no son necesarias para este proyecto. Haz clic en **Next: Review**.

7. Revisa la configuración del usuario y haz clic en **Create user**.

8. En la página "Success", podrás ver el ID de clave de acceso y la clave secreta de acceso. Descarga el archivo CSV o anota estos valores, ya que los necesitarás para configurar el acceso desde tu entorno de desarrollo.

