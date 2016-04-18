define(["jquery"], function($) {
    
    $(function() {
    	$( '.toggle').click(function() {
    		  $('.expanded-active').not('.'+this.id+'_expand').hide();
    		  $( '.'+this.id+'_expand' ).addClass('expanded-active');
    		  $( '.'+this.id+'_expand' ).toggle();
    		});
		
    });
    
});
