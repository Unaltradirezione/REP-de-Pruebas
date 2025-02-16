from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service

# Configurar Selenium con Chrome
options = webdriver.ChromeOptions()
options.add_experimental_option("detach", True)  # Mantiene la ventana abierta

# Iniciar el navegador
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

# Ir al portal del SAT
driver.get("https://portalcfdi.facturaelectronica.sat.gob.mx/")

# Esperar que cargue la página
time.sleep(5)

# Ingresar RFC
rfc_input = driver.find_element(By.ID, "rfc")
rfc_input.send_keys("YASC020415FM9")

# Ingresar contraseña
password_input = driver.find_element(By.ID, "password")
password_input.send_keys("Chivas02")

# Esperar que el usuario resuelva el CAPTCHA manualmente
input("⚠️ Resuelve el CAPTCHA y presiona ENTER para continuar...")

# Hacer clic en el botón de "Enviar"
btn_enviar = driver.find_element(By.ID, "btnSubmit")
btn_enviar.click()

# Esperar que cargue la página de facturas
time.sleep(5)

print("✅ Login exitoso. Listo para extraer facturas.")
