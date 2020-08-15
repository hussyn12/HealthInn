
       $(document).ready(function() {
              $(".hamburger").click( function() {
                    $(".mt-menu-hamburger").toggleClass("showing");
                    $('#cover').toggleClass('display'); 
                    
                   // $(".closebtn").toggleClass("toggle");
              });
              $(".closebtn" ).click(function () {
              $(".mt-menu-hamburger").removeClass("showing");
              $('#cover').removeClass('display');
  });
              $("#cover").click(function () {
              $(".mt-menu-hamburger").removeClass("showing");
              $('#cover').removeClass('display');
  });
        });
        
 //       $(function() {
   //       $('.dropdown').hover(function() {
     //       $(this).find('.dropdown-content').show(800);
       //   }, function() { 
         //   $(this).find('.dropdown-content').hide(1200);
        //  });
       // });

           $(document).ready(function () {
    $(".dropdown").hover(
  function () {
     $('.dropdown-content').slideDown('medium');
  }, 
  function () {
     $('.dropdown-content').slideUp('medium');
  }
);

});



      $(function () {
       //   $('.col-tabs li a').on('click', function(){
         //    var target = $(this).attr('rel');
           //  $("#"+target).show().siblings(".main-blog-wrap").hide(8000);
         // });
         $(".col-tabs li a").click(function(e) {
        e.preventDefault();
        $('.leftcolumn section').fadeOut('slow');
        $('#' + $(this).data('rel')).fadeIn('slow');
  });
        });



$(function() {
   var stickySidebar = $('.sticky');
if (stickySidebar.length > 0) { 
  var stickyHeight = stickySidebar.height(),
      sidebarTop = stickySidebar.offset().top;
}
// on scroll move the sidebar
$(window).scroll(function () {
  if (stickySidebar.length > 0) {   
    var scrollTop = $(window).scrollTop();
            
    if (sidebarTop < scrollTop) {
      stickySidebar.css('top', scrollTop - sidebarTop);

      // stop the sticky sidebar at the footer to avoid overlapping
      var sidebarBottom = stickySidebar.offset().top + stickyHeight,
          stickyStop = $('.leftcolumn').offset().top + $('.leftcolumn').height();
      if (stickyStop < sidebarBottom) {
        var stopPosition = $('.leftcolumn').height() - stickyHeight;
          footerTop = 40,
        stickySidebar.css('top', stopPosition - footerTop);
      }
    }
    else {
      stickySidebar.css('top', '0');
    } 
  }
});

$(window).resize(function () {
  if (stickySidebar.length > 0) {   
    stickyHeight = stickySidebar.height();
  }
});

});

$(function() {

      var yourNavigation = $(".topnav");
      stickyDiv = "topnavsticky";
      yourHeader = $('.header').height();

  $(window).scroll(function() {
    if( $(this).scrollTop() > yourHeader ) {
      yourNavigation.addClass(stickyDiv);
       $(".dropdown-content").css({
         "top": "3.78em"
       });
       $(".hamburger").css({
          "top": "25px"
       })
    } else {
      yourNavigation.removeClass(stickyDiv);
       $(".dropdown-content").css({
         "top": "6.74em"
       });
       $(".hamburger").css({
          "top": "70px"
       })
    }
  });
        
        $('.home-head-toggle-list li > a').click(function() {
      $('li').removeClass();
      $(this).parent().addClass('active');
  });
        });