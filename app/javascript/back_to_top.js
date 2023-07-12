window.addEventListener('scroll', function() {
  var button = document.getElementById('back-to-top-btn');
  if (window.pageYOffset > 100) {
    button.classList.add('show');
    button.classList.add('fade-in');
  } else {
    button.classList.remove('show');
    button.classList.remove('fade-in');
  }
});

document.getElementById('back-to-top-btn').addEventListener('click', function(e) {
  e.preventDefault();
  window.scrollTo({ top: 0, behavior: 'smooth' });
});
