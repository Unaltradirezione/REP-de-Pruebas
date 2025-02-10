function calcularImpuestos() {
  // Obtener el ingreso mensual y los deducibles desde el formulario HTML
  const ingreso = parseFloat(document.getElementById("ingresoMensual").value);
  const deducibles = parseFloat(document.getElementById("deducibles").value) || 0;

  if (!ingreso || ingreso <= 0) {
    document.getElementById("resultadoImpuestos").innerHTML = "<strong>Por favor, ingresa un monto válido.</strong>";
    return;
  }

  const tasaIVA = 0.16;
  const subtotalIngreso = ingreso; // Se usa el total del ingreso mensual sin dividir entre 1.16
  
  // Ajuste de los deducibles para el cálculo de ISR
  const baseDeducibles = parseFloat((deducibles / 1.16).toFixed(4)); // Dividir deducibles entre 1.16 para eliminar el IVA
  const ingresoNeto = subtotalIngreso - baseDeducibles; // Restamos el deducible ajustado del ingreso total para obtener el ingreso neto

  let isr = 0;
  let porcentajeISRActividadEmpresarial = 0;

  // Tablas de ISR para Actividad Empresarial (tarifas progresivas según el ingreso neto)
  const tarifasMensuales = [
    { limiteInferior: 0.01, limiteSuperior: 746.04, cuota: 0, tasa: 1.92 },
    { limiteInferior: 746.05, limiteSuperior: 6332.05, cuota: 14.32, tasa: 6.4 },
    { limiteInferior: 6332.06, limiteSuperior: 11128.01, cuota: 371.83, tasa: 10.88 },
    { limiteInferior: 11128.02, limiteSuperior: 12935.82, cuota: 893.63, tasa: 16 },
    { limiteInferior: 12935.83, limiteSuperior: 15487.71, cuota: 1182.88, tasa: 17.92 },
    { limiteInferior: 15487.72, limiteSuperior: 31236.49, cuota: 1640.18, tasa: 21.36 },
    { limiteInferior: 31236.50, limiteSuperior: 49233.00, cuota: 5004.12, tasa: 23.52 },
    { limiteInferior: 49233.01, limiteSuperior: 93993.90, cuota: 9236.89, tasa: 30 },
    { limiteInferior: 93993.91, limiteSuperior: 125325.20, cuota: 22665.17, tasa: 32 },
    { limiteInferior: 125325.21, limiteSuperior: 375975.61, cuota: 32691.18, tasa: 34 },
    { limiteInferior: 375975.62, limiteSuperior: Infinity, cuota: 117912.32, tasa: 35 },
  ];

  // Cálculo de ISR para Actividad Empresarial
  for (const tramo of tarifasMensuales) {
    if (ingresoNeto >= tramo.limiteInferior && ingresoNeto <= tramo.limiteSuperior) {
      const excedente = ingresoNeto - tramo.limiteInferior;
      isr = tramo.cuota + (excedente * tramo.tasa) / 100;
      porcentajeISRActividadEmpresarial = tramo.tasa;
      break;
    }
  }

  // Cálculo de ISR para RESICO usando el total del ingreso mensual
  const tasasRESICO = [
    { limite: 25000.00, tasa: 1.0 },
    { limite: 50000.00, tasa: 1.1 },
    { limite: 83333.33, tasa: 1.5 },
    { limite: 208333.33, tasa: 2.0 },
    { limite: 3500000.00, tasa: 2.5 },
  ];

  let resico = 0;
  let porcentajeISRRESICO = 0;

  for (const tramo of tasasRESICO) {
    if (subtotalIngreso <= tramo.limite) {
      resico = subtotalIngreso * (tramo.tasa / 100);
      porcentajeISRRESICO = tramo.tasa;
      break;
    }
  }

  // Cálculo del IVA para ambos regímenes (Actividad Empresarial y RESICO)
  const ivaActividadEmpresarial = subtotalIngreso * tasaIVA;  // IVA basado en el ingreso total para Actividad Empresarial
  const ivaRESICO = subtotalIngreso * tasaIVA;  // IVA basado en el ingreso total para RESICO

  // Cálculo del IVA deducible
  const ivaDeducible = baseDeducibles * tasaIVA;  // IVA deducible calculado usando la base de los deducibles

  // Restamos el IVA deducible del IVA a pagar en Actividad Empresarial
  const ivaPagar = ivaActividadEmpresarial - ivaDeducible; 

  // IVA deducible también se aplica en RESICO
  const ivaPagarRESICO = ivaRESICO - ivaDeducible;

  // Cálculo del total de impuestos
  const totalImpuestoActividadEmpresarial = isr + ivaPagar; // ISR + IVA a pagar (Actividad Empresarial)
  const totalImpuestoRESICO = resico + ivaPagarRESICO; // ISR + IVA a pagar (RESICO)

  // Cálculo de Ahorro Mensual y Anual
  const ahorroAnual = (totalImpuestoActividadEmpresarial - totalImpuestoRESICO) * 12;
  const ahorroMensual = totalImpuestoActividadEmpresarial - totalImpuestoRESICO;

  // Mostrar resultados en la tabla
  document.getElementById("ingresoMensualValor").innerText = "$" + Math.round(ingreso);
  document.getElementById("ingresoMensualRESICO").innerText = "$" + Math.round(ingreso);
  document.getElementById("gastosMensualesValor").innerText = "$" + Math.round(deducibles);
  document.getElementById("gastosMensualesRESICO").innerText = "$" + Math.round(deducibles);
  document.getElementById("ivaActividadEmpresarial").innerText = "$" + Math.round(ivaPagar);
  document.getElementById("ivaRESICO").innerText = "$" + Math.round(ivaPagarRESICO);
  document.getElementById("isrActividadEmpresarial").innerText = "$" + Math.round(isr);
  document.getElementById("isrRESICO").innerText = "$" + Math.round(resico);
  document.getElementById("porcentajeISRActividadEmpresarial").innerText = Math.round(porcentajeISRActividadEmpresarial) + "%";
  document.getElementById("porcentajeISRRESICO").innerText = porcentajeISRRESICO + "%";
  document.getElementById("totalImpuestosActividadEmpresarial").innerText = "$" + Math.round(totalImpuestoActividadEmpresarial);
  document.getElementById("totalImpuestosRESICO").innerText = "$" + Math.round(totalImpuestoRESICO);
  document.getElementById("ahorroMensual").innerText = "Ahorro estimado mensual: $" + Math.round(ahorroMensual);
  document.getElementById("ahorroAnual").innerText = "Ahorro estimado anual: $" + Math.round(ahorroAnual);
  document.getElementById("comparativaImpuestos").style.display = "block";
}

