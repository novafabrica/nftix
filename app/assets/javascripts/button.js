jQuery.fn.ajaxifiedDropDown = function() {

    this.each(function(index, object){

        var self = $(object);
        var basicInfo = self.data('button');
        var button = {
            display: self.find('.display'),
            list: self.find('ul'),
            param: basicInfo['param'],
            url: basicInfo['url'],
            chosen: basicInfo['chosen'],
            choices: basicInfo['choices'],
            model: basicInfo['model']

        };

        button.dropdown = $(self).find(".dropdown-menu");

        _bindChange(button.dropdown.find('li a'), {method: "PATCH"});

        function _bindChange(links, options) {
            links.data('button', button);
            links.ajaxify_link(options, updateButton);
            return false;
        }

        function updateButton(link, response) {
            var button = link.data('button');
            button.display.html(button.choices[response['ticket'][button.param]]);
            createList(button.choices, response['ticket'][button.param]);
        }

        function createList(choices, chosen) {
            // Javascript Version of Clone
            var list = $.extend({}, choices);
            var $ul = $("<ul class='dropdown-menu'>");
            delete list[chosen];
            $.each(list, function(key) {
                var options = {};
                options.method = "PATCH";
                options.data = {};
                var model = options.data[button.model] = {};
                model[button.param] = key;
                var $a = $('<a>');
                $a.html(choices[key]);
                $a.attr("href", button.url);
                _bindChange($a, options);
                $ul.append($('<li>').html($a));
            });
            button.list.replaceWith($ul);
            // NB we need to updated the jquery pointer. Replace does not actually change the pointer.
            button.list = $ul;
            button.dropdown.blur();
        }

        return button;

    });

};

$(document).ready(function() {
    $('.btn-group').ajaxifiedDropDown();

});


//  function createSplitButton(options) {
//     var model = options["data"]["model"];
//     var attribute = options["data"]["attribute"];
//     var $container =  $("<div class='btn-group'>").css(options.css).data(options.data);
//     var $button = $("<button class='btn'>");
//     $button.html(option.chosen);
//     $button.append('<button class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>');
//     var $ul = $("ul class='dropdown-menu'");
//     var list = option.choices - options.chosen;
//     list.forEach(function(choice) {
//         var $li = $('li');
//         var $a = $('a');
//         $a.attrs('href', options.url).html(choice.key);
//         $a.click(function() {
//             $(this).ajaxify_link({method: "PATCH", model: { attribute: choice.value}}, updateButton);
//         $li.append($a);
//         $ul.append($li);
//         });
//     });
//     return $container.append($ul);
//  }

//  function updateButton(link, response){
//     var oldButton = $(link).closest('.btn-group');
//     var options =  {
//         model: oldButton.data('model'),
//         attribute: oldButton.data('attribute'),
//         url: oldButton.data('url'),
//         choices: oldButton.data.choices,
//         chosen: response.chosen
//     };
//     var newButton = createSplitButton();
//     oldButton.replaceWith(createSplitButton(options));
// }

// $(document).ready(function() {
//     $button = $('.btn-group.ajaxify');
//     var model = $button.data('model');
//     var attribute = $button.data('attribute');
//     $button.find('a').ajaxify_link({method: "PATCH", model: { attribute: $(this).data('value')}}, updateButton);
//     return false;
// });

 // def split_button_group(active_link, actions=[], options={})
 //    html = ""
 //    html << "<div class='btn-group #{options[:classes]}' data-button='#{options[:data]}'>"
 //    html << ''
 //    html << active_link
 //    html << '</button>'
 //    html << ''
 //    html << ''
 //    html << '</button>'
 //    html << '<ul class="dropdown-menu">'
 //    for action in actions
 //      html << "<li>#{action}</li>"
 //    end
 //    html << '</ul>'
 //    html << '</div>'
 //  end