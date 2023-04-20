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

:oncoming_automobile: _Posibilidad de automatizar este paso_ 

Tenemos varias posibilidades para crear el usuario: 

- A. Añadiendo los permisos uno a uno

- B. Creando una politica de permisos 

- C. Automatizando con cloudformation o terraform

**Crear el usuario desde la cuenta Administrador**

1. Inicia sesión en la consola de AWS con tu cuenta de administrador.

2. Navega al servicio **IAM (Identity and Access Management)**.

3. En el panel de navegación izquierdo, selecciona **Users** y haz clic en **Add user**.

4. Ingresa un nombre de usuario (por ejemplo, `WebAppAutoDeployUser`). En este punto, no selecciones ninguna de las opciones disponibles y simplemente haz clic en **Next: Permissions**.

   **A. Añadiendo los permisos uno a uno**

5. En la página "Set permissions", selecciona la opción **Attach existing policies directly**. Busca y selecciona las siguientes políticas:

   - `AmazonS3FullAccess`
   - `AWSCodePipeline_FullAccess`
   - `AWSCodeBuildAdminAccess`
   - `AWSCloudFormationFullAccess`
   - `IAMFullAccess`
   
   Estas políticas otorgan al usuario los permisos necesarios para trabajar con S3, CodePipeline, CodeBuild y CloudFormation.
   
   Ten en cuenta que `IAMFullAccess` otorga un amplio conjunto de permisos y no se recomienda en un entorno de producción. En su lugar, se recomienda limitar el alcance de estos permisos según sea necesario.

6. Haz clic en **Next: Tags**. Puedes agregar etiquetas si lo deseas, pero no son necesarias para este proyecto. Haz clic en **Next: Review**.

7. Revisa la configuración del usuario y haz clic en **Create user**.

:pager:
![guia-crear-usuario](https://user-images.githubusercontent.com/126183973/232841803-42df89c9-fc1e-4fe0-bf66-747ef9b83b6d.JPG)

   **B. Creando una politica de permisos y agregandola al usuario** (Recomendado)

      [politica json](https://github.com/ccalvop/AWS-WebAppAutoDeploy/tree/main/Politicas)

   **C. Automatizando con cloudformation o terraform**

    [archivos automatización](https://github.com/ccalvop/AWS-WebAppAutoDeploy/tree/main/Automatizacion)

   **AWS CloudFormation** archivo `iam_user.yml`

     > usando la interfaz de línea de comandos de AWS (CLI) para crear un stack en CloudFormation

     ```aws cloudformation create-stack --stack-name WebAppAutoDeployUserStack --template-body file://iam_user.yml```

     **Terraform** archivo `main.ft`

     > iniciarlizar terraform ```terraform init``` y aplicamos el archivo de configuracion ```terrafom apply```

8. Necesitarás crear una contraseña y proporcionar acceso a la consola al nuevo usuario:
 
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

_(En AWS, usaremos el nuevo usuario creado en el paso 1)_

<ins>:one: Creación de un **repositorio de GitHub** para alojar el código de la aplicación web.<ins>

   En nuestro caso [AWS-WebAppAutoDeploy](https://github.com/ccalvop/AWS-WebAppAutoDeploy)

<ins>:two: Diseño y desarrollo de una **aplicación web** simple utilizando HTML, CSS y JavaScript:<ins>

   Crea los siguientes archivos en la raíz de tu repositorio de GitHub: `index.html` `styles.css` `script.js`

<ins>:three: Configuración de un **bucket de S3** para alojar y servir la aplicación web:<ins>
   
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

**AWS CodeBuild** Para una aplicación web simple compuesta de archivos HTML, CSS y JavaScript, no es necesario compilar en el sentido tradicional. Sin embargo, en este contexto, el término "compilar" se refiere al proceso de preparar y empaquetar los archivos de la aplicación web antes de implementarlos en el bucket de S3.

```
Al utilizar AWS CodeBuild en este caso, estás aprovechando algunas ventajas:

1. Automatización: CodeBuild se integra fácilmente con CodePipeline, lo que te permite automatizar el proceso de preparación y despliegue de tu aplicación web en respuesta a los cambios en el repositorio de GitHub.

2. Consistencia: Aunque la aplicación web es simple en este caso, es posible que en el futuro desees agregar más funcionalidades, como la utilización de un marco de trabajo o bibliotecas de terceros que requieran una etapa de construcción. Al utilizar CodeBuild desde el principio, estableces un flujo de trabajo coherente que se puede ampliar fácilmente en el futuro.

3. Optimización: Aunque no es necesario en una aplicación web simple, CodeBuild también te permite realizar tareas de optimización, como la minificación de archivos CSS y JavaScript, comprimir imágenes, etc. Esto puede mejorar el rendimiento y la eficiencia de tu aplicación web.

4. Pruebas: Si tu aplicación crece y decides incluir pruebas unitarias o de integración, CodeBuild te permitirá ejecutar estas pruebas automáticamente como parte del proceso de CI/CD.

En resumen, aunque la compilación en sí misma no es necesaria para una aplicación web simple, el uso de AWS CodeBuild en este caso te proporciona un proceso automatizado y coherente que se puede adaptar fácilmente a medida que tu aplicación web evoluciona
```
<hr>
<br>
   
<ins>:four: Configuración de **AWS CodePipeline** para crear un proceso de CI/CD<ins>
   
   1. Navega al servicio AWS CodePipeline. Haz clic en Create pipeline.
   2. Ingresa un nombre para la pipeline (por ejemplo, WebAppAutoDeployPipeline) y selecciona la ubicación para almacenar los artefactos de la pipeline en S3 (puedes usar la opción predeterminada). Haz clic en Next.
   3. En la sección Source, selecciona GitHub (Version 2) como el proveedor de origen. A continuación, haz clic en Connect to GitHub y sigue las instrucciones para autorizar a CodePipeline a acceder a tu repositorio de GitHub. Selecciona el repositorio y la rama que deseas usar (por ejemplo, ccalvop/AWS-WebAppAutoDeploy y la rama main). Haz clic en Next.
   4. En la sección Build, selecciona AWS CodeBuild como el proveedor de compilación. Haz clic en Create build project. Ingresa un nombre para el proyecto de compilación (por ejemplo, WebAppAutoDeployBuildProject).
   5. En la sección Environment, selecciona Managed image y elige Amazon Linux 2 como el sistema operativo. Elige Standard como el tipo de tiempo de ejecución y selecciona la última imagen disponible (por ejemplo, aws/codebuild/standard:5.0). Deja la configuración del entorno como Linux y x86_64.
   6. En la sección Buildspec, selecciona Use a buildspec file. Esto le indicará a CodeBuild que busque un archivo buildspec.yml en la raíz de tu repositorio para obtener instrucciones de compilación.
   
   El archivo buildspec.yml es un archivo de configuración que AWS CodeBuild utiliza para definir las acciones que debe realizar durante la etapa de compilación. En    nuestro caso, dado que la aplicación web es simple, el archivo buildspec.yml será bastante básico:
   
   ```
   version: 0.2
   
   phases:
      build:
         comands:
            - echo "No build required for a simple HTML, CSS, and JavaScript application."
         
      postbuild:
         comands:
            - aws s3 sync . s3://webapp-auto-deploy-bucket --exclude ".git/*" --exclude "buildspec.yml" --delete
   ```
   Este archivo buildspec.yml contiene dos fases: build y post_build. En la fase de build, simplemente se imprime un mensaje indicando que no es necesario compilar la aplicación. En la fase de post_build, se utiliza el comando aws s3 sync para sincronizar todos los archivos del repositorio (excepto los archivos en la carpeta .git y el propio archivo buildspec.yml) con el bucket de S3 que has creado para alojar la aplicación web. La opción --delete asegura que cualquier archivo que ya no esté presente en el repositorio se elimine del bucket de S3
   
   7. Deja las configuraciones restantes como están y haz clic en Continue to CodePipeline.En la página de CodePipeline, haz clic en Next.
   8. En la sección Deploy, selecciona Amazon S3 como el proveedor de implementación. Elige el bucket de S3 que creaste en el paso 3 y escribe index.html en el campo S3 object key. Marca la casilla Extract file before deploy para descomprimir los archivos antes de implementarlos. Haz clic en Next.
   9. Revisa la configuración de la pipeline y haz clic en Create pipeline.

<ins>:five: Configuración de **AWS CodeBuild** para compilar y desplegar la aplicación web en el bucket de S3<ins>


