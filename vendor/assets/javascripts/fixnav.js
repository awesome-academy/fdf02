 $(document).ready(function($) {
    $(window).scroll(function(){
      if($(this).scrollTop()>150){
        $(".header-bottom").addClass('fixNav')
      }else{
        $(".header-bottom").removeClass('fixNav')
      }}
      )
  })
 // user js
$(document).ready(function() {
    var panels = $('.user-infos');
    var panelsButton = $('.dropdown-user');
    panels.hide();

    //Click dropdown
    panelsButton.click(function() {
        //get data-for attribute
        var dataFor = $(this).attr('data-for');
        var idFor = $(dataFor);

        //current button
        var currentButton = $(this);
        idFor.slideToggle(400, function() {
            //Completed slidetoggle
            if(idFor.is(':visible'))
            {
                currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
            }
            else
            {
                currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
            }
        })
    });


    $('[data-toggle="tooltip"]').tooltip();

    $('button').click(function(e) {
        e.preventDefault();
        alert("This is a demo.\n :-)");
    });
});
/*
$(document).ready(function() {
    $('.btnCartProduct').on('click', function() {
        url= $('.update_product_form').attr('action');
        $.ajax({
            url: url,
            type: 'put',
            dataType: 'json',
            success: function(data) {
                if(data)
                {
                    $(".cart_list").html("<%= escape_javascript(render partial: 'cart_product', collection: @cart_products) %>");
                    $(".cart_total").html("<%= escape_javascript(render 'carts/total')%>");
                    $(".cart_mini_top").html("<%= escape_javascript(render 'carts/cart_mini', cart_products: @cart_products) %>");
                }
                else
                {
                    alert('Your username/password are incorrect');
                }
            },
            error: function() {
                alert('There has been an error, please alert us immediately');
            }
        });

    });
});*/

