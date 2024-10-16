import xmltodict
import json

# Ruta del archivo XML
xml_file_path = 'B7881981-8E33-41C2-BDE7-367F43F78119.xml'  # Cambia 'archivo.xml' por la ruta de tu archivo XML

# Leer el contenido del archivo XML
with open(xml_file_path, 'r', encoding='utf-8') as xml_file:
    xml_content = xml_file.read()

# Convertir el XML a un diccionario de Python
data_dict = xmltodict.parse(xml_content)

# Convertir el diccionario a JSON con una indentación de 4 espacios
json_data = json.dumps(data_dict, indent=4)

# Guardar el JSON resultante en un archivo .json
json_file_path = 'facturas-prueba.json'  # Cambia 'archivo.json' por el nombre de tu archivo JSON de salida
with open(json_file_path, 'w', encoding='utf-8') as json_file:
    json_file.write(json_data)

print(f"Conversión completa. JSON guardado en {json_file_path}")
