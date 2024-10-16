

Convertir archivo HTML (proveniente de una factura) a codigo, en este caso a un archivo .json

"sirve para facturas y constnacias de retenciones"

____________________________________________________________________________________

Pasos para convertir un XML a JSON con Python en VS Code:

1. Instalar Python y las extensiones necesarias en Visual Studio Code

     Si aún no lo has hecho, asegúrate de tener Python instalado en tu sistema. Puedes descargarlo desde python.org.

        Instala la extensión de Python en VS Code:  
              1. Abre VS Code.
              2. Ve a la pestaña de extensiones (icono de cuadrado con líneas) y busca "Python".
              3. Instala la extensión de Python de Microsoft.


2. Instalar la biblioteca xmltodict

        Abre la terminal integrada en VS Code (Puedes abrirla con Ctrl + ñ o desde el menú Terminal > New Terminal).

        Ejecuta el siguiente comando para instalar la biblioteca xmltodict, que se utilizará para convertir el archivo XML a JSON:

    
    pip install xmltodict

3. Crear el archivo Python para la conversión

        En VS Code, crea un nuevo archivo y guárdalo como convert_xml_to_json.py.

        Luego, agrega el siguiente código:



    import xmltodict
    import json

    # Ruta del archivo XML
    xml_file_path = 'archivo.xml'  # Cambia 'archivo.xml' por la ruta de tu archivo XML

    # Leer el contenido del archivo XML
    with open(xml_file_path, 'r', encoding='utf-8') as xml_file:
        xml_content = xml_file.read()

    # Convertir el XML a un diccionario de Python
    data_dict = xmltodict.parse(xml_content)

    # Convertir el diccionario a JSON con una indentación de 4 espacios
    json_data = json.dumps(data_dict, indent=4)

    # Guardar el JSON resultante en un archivo .json
    json_file_path = 'archivo.json'  # Cambia 'archivo.json' por el nombre de tu archivo JSON de salida
    with open(json_file_path, 'w', encoding='utf-8') as json_file:
        json_file.write(json_data)

    print(f"Conversión completa. JSON guardado en {json_file_path}")


4. Modificar el archivo XML y JSON

        Asegúrate de que el archivo XML que deseas convertir esté en la misma carpeta que el script de Python o especifica la ruta completa en el campo xml_file_path.

        Cambia también el nombre del archivo de salida .json en json_file_path si quieres que el resultado se guarde con otro nombre o en otra carpeta.


5. Ejecutar el script en Visual Studio Code      
        Una vez que hayas configurado el script, guarda el archivo.

       Abre la terminal en VS Code (Ctrl + ñ) y navega hasta la carpeta donde guardaste tu script convert_xml_to_json.py.

       Ejecuta el script con el siguiente comando:

       python convert_xml_to_json.py

6. Revisar el archivo JSON

       El script leerá el archivo XML, lo convertirá a JSON y guardará el archivo de salida en el directorio especificado.

       En el archivo JSON resultante, deberías ver la estructura del XML convertida en formato JSON con una indentación de 4 espacios para facilitar su lectura.