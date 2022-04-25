/*==================== SHOW MENU ====================*/
const navMenu = document.getElementById('nav-menu'),
  navToggle = document.getElementById('nav-toggle'),
  navClose = document.getElementById('nav-close')

/*===== MENU SHOW =====*/
if (navToggle) {
  navToggle.addEventListener('click', () => {
    navMenu.classList.add('show-menu')
  })
}

/*===== MENU HIDDEN =====*/
if (navClose) {
  navClose.addEventListener('click', () => {
    navMenu.classList.remove('show-menu')
  })
}

/*===== REMOVE MENU MOBILE =====*/
const navLink = document.querySelectorAll('.nav__link')

function linkAction() {
  const navMenu = document.getElementById('nav-menu')
  navMenu.classList.remove('show-menu')
}
navLink.forEach(n => n.addEventListener('click', linkAction))


/*==================== SWIPER DISCOVER ====================*/

var swiper = new Swiper(".discover__container", {
  effect: "coverflow",
  grabCursor: true,
  centeredSlides: true,
  slidesPerView: "auto",
  loop: true,
  spaceBetween: 32,
  coverflowEffect: {
    rotate: 0
  }
});


/*==================== SHOW SCROLL UP ====================*/
function scrollUp() {
  const scrollUp = document.getElementById('scroll-up');
  // When the scroll is higher than 200 viewport height, add the show-scroll class to the a tag with the scroll-top class
  if (this.scrollY >= 200) {
    scrollUp.classList.add('show-scroll');
  } else {
    scrollUp.classList.remove('show-scroll')
  }
}
window.addEventListener('scroll', scrollUp)

/*==================== SCROLL SECTIONS ACTIVE LINK ====================*/
const sections = document.querySelectorAll('section[id]')

function scrollActive() {
  const scrollY = window.pageYOffset

  sections.forEach(current => {
    const sectionHeight = current.offsetHeight
    const sectionTop = current.offsetTop - 50;
    sectionId = current.getAttribute('id')

    if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
      document.querySelector('.nav__menu a[href*=' + sectionId + ']').classList.add('active-link')
    } else {
      document.querySelector('.nav__menu a[href*=' + sectionId + ']').classList.remove('active-link')
    }
  })
}
window.addEventListener('scroll', scrollActive)

/*==================== SCROLL REVEAL ANIMATION ====================*/
const sr = ScrollReveal({
  distance: '60px',
  duration: 2500,
  // reset: true,
})


sr.reveal(`.home__data, .home__info,
          .section__title,
         .discover__container,
         .experience__data, .experience__overlay,
         .place__card,
         .footer__data, .footer__rights`, {
  origin: 'top',
  // interval: 100,
})

sr.reveal(`.about__data,
         .subscribe__description`, {
  origin: 'left',
  interval: 100,
})

sr.reveal(`.about__img-overlay, 
         .subscribe__form`, {
  origin: 'right',
  interval: 100,
})
