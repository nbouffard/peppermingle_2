import 'owl.carousel';
import $ from 'jquery';

$(function() {
    // Initialize Owl Carousel
    $('#recipeCarousel').owlCarousel({
      items: 1,
      loop: true,
      autoplay: true,
      autoplayTimeout: 6000,
      autoplayHoverPause: true,
      animateOut: 'fadeOut',
      nav: false,
    });
});
