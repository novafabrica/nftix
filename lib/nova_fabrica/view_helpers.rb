module NovaFabrica

  module ViewHelpers

    def file_uploader(f, method, file_style = "original", options ={})
      return "" unless f.object.respond_to? "#{method}?"
      string = ""
      if f.object.send("#{method}?")
        string << image_tag(f.object.send("#{method}", file_style))
        string << "<br />"
        if f.object.respond_to? "remove_#{method}"
          string  << f.label("remove_#{method}", "Remove #{method.to_s.titleize}")
          string << f.check_box("remove_#{method}") 
          string << "<br/>"
        else
          raise "MISSING REMOVE_#{method.upcase} ATTRIBUTE FOR #{f.object.class.to_s}"
        end
        string << "<span>Or choose a new file:</span><br />"
      end
      string << f.file_field(method.to_sym)
      string << "<br />"
      if options[:height]
        string << "<span>Best size: #{options[:width]} W x#{ options[:height]} H</span>"
      end
      string.html_safe
    end

    def menu_link(name, path)
      link_to(name, path,
              :onmouseover => "writeText('status', 'Manage #{name});",
              :onmouseout  => "writeText('status', '');")
    end

    def error_messages_for(object)
      render(:partial => 'application/error_messages', :locals => {:object => object})
    end

    def truncate_on_space(text, *args)
      options = args.extract_options!
      options.reverse_merge!(:length => 30, :omission => "...")
      return text if text.blank? || text.size <= options[:length]

      new_text = truncate(text, :length => options[:length] + 1, :omission => "")
      while last = new_text.slice!(-1, 1)
        return new_text + options[:omission] if last == " "
      end
    end

    def status_tag(boolean, options={})
      options[:true]        ||= ''
      options[:true_class]  ||= 'status true'
      options[:false]       ||= ''
      options[:false_class] ||= 'status false'

      if boolean
        content_tag(:span, options[:true], :class => options[:true_class])
      else
        content_tag(:span, options[:false], :class => options[:false_class])
      end
    end

    # Format text for display.
    def format(text)
      sanitize(markdown(text))
    end

    def cancel_button(link)
      "<input type='button' value='Cancel' class='cancel-button' onclick=\"window.location.href='#{link}';\" />".html_safe
    end

  end

end
