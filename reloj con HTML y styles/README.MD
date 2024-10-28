

----------------------------------------------------------------------html para un reloj digial---------------------------------------------------------------------------

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Neon Digital Clock</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #000;
            margin: 0;
        }

        #clock {
            font-family: 'Digital', sans-serif;
            font-size: 80px;
            color: #bbff00;
            text-shadow: 0 0 10px #88ff00, 0 0 20px #d9ff00, 0 0 30px #000000,
                0 0 40px rgb(0, 0, 0), 0 0 70px rgb(0, 0, 0), 0 0 80px rgb(0, 0, 0), 0 0 100px rgb(0, 0, 0);
        }
    </style>
</head>

<body>
    <div id="clock"></div>

    <script>
        function updateClock() {
            const clock = document.getElementById('clock');
            const now = new Date();
            let hours = now.getHours();
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            const ampm = hours >= 12 ? 'PM' : 'AM';

            hours = hours % 12 || 12; // Convierte 0 en 12 y ajusta a formato de 12 horas
            hours = String(hours).padStart(2, '0');

            clock.textContent = `${hours}:${minutes}:${seconds} ${ampm}`;
        }

        setInterval(updateClock, 1000);
        updateClock();
    </script>
</body>

</html>




----------------------------------------------------------------------estilos para un reloj digital-----------------------------------------------------------------------
#time .circle svg circle {
    width: 100%;
    height: 100%;
    fill: transparent;
    stroke: #4b4b4b;
    stroke-width: 4px;
    transform: translate(5px, 5px);
}

#time div {
    position: absolute;
    text-align: center;
    font-size: 2rem;
    font-weight: 500;
}

.time-text {
    font-size: 1.2rem;
    font-weight: 200;
}

#time div span {
    position: absolute;
    transform: translate(-20px, 0);
    /* Corrección aplicada */
    font-size: 0.5rem;
    font-weight: 300;
    letter-spacing: 0.1rem;
}

.dots {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    /* Alineación vertical */
    z-index: 10;
}

