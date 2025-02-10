var swiper = new Swiper(".swiper", {
    effect: "cube",
    allowTouchMove: false,
    grabCursor: false,
    cubeEffect: {
        shadow: true,
        slideShadows: true,
        shadowOffset: 20, // Corregido de shadow0ffset a shadowOffset
        shadowScale: 0.94,
    },
    mousewheel: true
});

// Evento para detectar cambios de slide
swiper.on('slideChange', function () {
    console.log("Slide actual: ", swiper.activeIndex);
});

function Navigate(indx) {
    // Remueve la clase activa de todos los elementos
    document.querySelectorAll(".Links li").forEach(item => item.classList.remove("activeLink"));

    // Agrega la clase activa al índice seleccionado
    let links = document.querySelectorAll(".Links li");
    if (links[indx]) {
        links[indx].classList.add("activeLink");
    }

    // Mueve el swiper al slide deseado
    swiper.slideTo(indx, 1000, true);
}
