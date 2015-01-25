// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require mootools

window.addEvent('domready', function() {
	$("#user_star").click(function() {
		$.ajax({
			url: '/reviews/5',
			method: "PATCH",
			data: { rating: 3 }
		});
	});
	commentsHandler.initComments();
});

commentForm = function(container) {
	this.container = container;
	this.build();
}

commentForm.prototype.toggle = function () {
	if (this.container.hasClass('hidden')) {
		this.show();
	} else {
		this.hide();
	}
};

commentForm.prototype.show = function() {
	this.container.set('styles', {
		'overflow' : 'hidden',
		'maxHeight' : 0
	});
	this.container.removeClass('hidden');
	this.container.get('morph').removeEvents('complete');
	this.container.set('morph', {
		duration : 222,
		onComplete : (function () {
			this.visible = true;
		}).bind(this)
	});
	this.container.morph({
		'maxHeight' : 1000
	}); 
}

commentForm.prototype.hide = function() {
	this.container.set('morph', {
		duration : 222,
		onComplete : (function () {
			this.container.addClass('hidden');
			this.visible = false;
			if (onComplete) {
				onComplete();
			}
		}).bind(this)
	});

	this.container.morph({
		'maxHeight' : 0
	}); 
}

commentForm.prototype.build = function() {
	this.container.innerHTML = "<textarea></textarea>";
}

commentsHandler = {
	initComments : function() {
		var comment_blocks = $$('div.comment-block');
		comment_blocks.each(function(comment_block) {
			commentsHandler.initComment(comment_block);
		});
	},

	initComment: function(comment_block) {
		var comment_id = comment_block.getProperty('data-comment-id');
		comment_block.getElements('.c_answer').addEvent('click', function() {
			commentsHandler.toggleCommentForm(this, comment_id);
		})
	},

	new_comments_form : {},

	toggleCommentForm : function(link, comment_id) {
		var comment_block = link.getParent('.comment-block');
		if (commentsHandler.new_comments_form[comment_id]) {
			commentsHandler.new_comments_form[comment_id].toggle();
		} else {
			var comment_place_holder = new Element('div', {text: "URAAAAAAAAAAAAAAAAAAAA"});
			comment_place_holder.inject(comment_block);
			commentsHandler.new_comments_form[comment_id] = new commentForm(comment_place_holder);
		}
	}
}

/*	$("a[data-remote]").on("ajax:success", (e, data, status, xhr) ->
		alert "Deleted")*/

/*window.addEvent('domready', function() {
	$(function() {
	  $('.movie-star').click(function() {
	    var star = $(this);
	    var form_id = star.attr("data-form-id");
	    var stars = star.attr("data-stars");
	    $('#' + form_id + '_stars').val(stars);
	    $.ajax({
	      type: "post",
	      url: $('#' + form_id).attr('action') + '.json',
	      data: $('#' + form_id).serialize(),
	      success: function(response){
	        console.log(response);
	        update_stars();
	        if(response["avg_rating"]){
	          $('#average_rating').text(response["avg_rating"]);
	          }
	        }
	      })
	  });        
	});

	


});

function update_stars(){
		$('.movie-stars-form').each(function() {
    		var form_id = $(this).attr('id');
    		set_stars(form_id, $('#' + form_id + '_stars').val());
  		});
	}
	
	function set_stars(form_id, stars) {
  		for(i = 1; i <= 3; i++){
    		if(i <= stars){
      			$('#' + form_id + '_' + i).addClass("on");
    		} else {
      			$('#' + form_id + '_' + i).removeClass("on");
    		}
  		}
	}*/
/*window.addEvent('domready', function() {
    $$('a.reply-link').addEvent('click', function() {
    	var comment_holder = $$(this).getParent('.comment-block');
		var new_comment_form_holder = new Element('div', {
			'style' : 'zoom:1;'
		});
    	new_comment_form_holder.inject(comment_holder);
    });
});*/




/*var comment_holder = $(button).getParent('.comment');
			commentsHandler.new_comment_forms[comment_id] = new commentForm(new_comment_form_holder, {
				onSubmit : function () {
					commentsHandler.sendNewComment({
						data : new_comment_form_holder.getElement('form').toQueryString(),
						new_comment_form : commentsHandler.new_comment_forms[comment_id],
						post_id : post_id,
						onSubmitComment : function () {
							commentsHandler.new_comment_forms[comment_id].clear();
							commentsHandler.new_comment_forms[comment_id].hide();
						}
					});
				},
				post_id : post_id,
				comment_id : comment_id,
				comment_user_name : comment_holder.getElement('.c_user') ? comment_holder.getElement('.c_user').innerHTML : '',
				focus_on_show : true,
				focus_on_build : true,
				closable : true,
				button_src: button_src
			});
			commentsHandler.new_comment_forms[comment_id].show();
			
		}*/



/*commentForm.prototype.show = function () {
	this.container.set('styles', {
		'overflow' : 'hidden',
		'maxHeight' : 0
	});
	this.container.removeClass('hidden');
	
	this.container.get('morph').removeEvents('complete');
	this.container.set('morph', {
		duration : 222,
		onComplete : (function () {
			this.visible = true;
			// Удаление файла при раскрытии блока комментариев
			// с уже проинициализированным загрузчиком файлов
			// чтобы избежать возникаемой ошибки в IE из-за скрытия flash-блока
			if (this.uploader && Browser.name == 'ie') {
				this.deleteFile();
			}
		}).bind(this)
	});
	
	this.container.morph({
		'maxHeight' : 1000
	});
	
	this.container.getElement('textarea').addEvent('focus', function () {
		keypress.stop_listening();
	});
	this.container.getElement('textarea').addEvent('blur', function () {
		keypress.listen();
	});
	
	this.container.getElement('textarea').value = this.container.getElement('textarea').value;
	if (this.options.focus_on_show) {
		if (/\bMSIE 6/.test(navigator.userAgent) && !window.opera) {
			
		} else {
			this.container.getElement('textarea').focus();
		}
		if (this.container.getElement('textarea').value.trim().length == 0) {
			this.container.getElement('textarea').value = this.options.comment_user_name ? this.options.comment_user_name + ', ' : '';
		}
	}
};

commentForm = function (container, options) {
	if (!container) {
		alert('Укажите элемент для контейнера.');
		return false;
	}
	this.container = container;
	this.options = options || {};
	this.options.onSubmit = options.onSubmit || function () {};
	this.options.onClose = options.onClose || function () {};
	this.options.post_id = options.post_id || function () {};
	this.options.comment_id = options.comment_id || '';
	this.options.comment_user_name = options.comment_user_name || false;
	this.options.focus_on_build = options.focus_on_build || false;
	this.options.focus_on_show = options.focus_on_show || false;
	this.options.closable = options.closable || false;
	this.options.button_src = options.button_src || false;
	this.visible = false;
	this.build();
}*/