(function($){
    $.fn.extend({
        numAnim: function(options) {
            if ( ! this.length)
                return false;
            this.defaults = {
                endAt: 0,
                numClass: 'lot-number',
                duration: 3,   // seconds
                interval: 80  // ms
            };
            var settings = $.extend({}, this.defaults, options);

            var $num = $('<span/>', {
                'class': settings.numClass
            });

            return this.each(function() {
                var $this = $(this);

                var frag = document.createDocumentFragment(),
                    numLen = settings.endAt.toString().length;
                for (x = 0; x < numLen; x++) {
                    var rand_num = Math.floor( Math.random() * 100 );
                    frag.appendChild( $num.clone().text(rand_num)[0] )
                }
                $this.empty().append(frag);

                var get_next_num = function(num) {
                    return parseInt(Math.random() * 100 - 1);
                };

                $this.each(function() {
                    var $num = $(this),
                        num = parseInt( $num.text() );

                    var interval = setInterval( function() {
                        num = get_next_num(num);
                        $num.text(num);
                    }, settings.interval);

                    setTimeout( function() {
                        clearInterval(interval);
                    }, settings.duration * 1000 - settings.interval);
                });

                setTimeout( function() {
                    $this.text( settings.endAt.toString() );
                }, settings.duration * 1000);
            });
        }
    });
})(jQuery);

$(document).ready(function () {
    var num = $("#lot-number").data('number');
    var drawed = $("#lot-number").data('drawed');
    if (drawed == 0) {
        $("#lot-number").numAnim({
            endAt: parseInt(num)
        });
    };
});
