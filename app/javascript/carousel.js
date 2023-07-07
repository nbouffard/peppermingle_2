import 'owl.carousel';

document.addEventListener('DOMContentLoaded', () => {
  const recipeCarousel = $('#recipeCarousel');

  recipeCarousel.owlCarousel({
    items: 1,
    loop: true,
    autoplay: true,
    autoplayTimeout: 4000,
    autoplayHoverPause: true,
    animateOut: 'fadeOut',
    nav: true,
    navText: [
      '<span class="carousel-control-prev-icon"></span>',
      '<span class="carousel-control-next-icon"></span>'
    ]
  });
});
