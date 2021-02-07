module HeraCms
  module TagHelper
    def hera_link(identifier, args = {}, &block)
      puts "Attempt"
      link = HeraCms::Link.identify(identifier)
      inner_text, style, identifier, path = translate_service.translate(link), link.style, link.identifier, link.path
      classes = set_classes(args, link)

      html_options = {
        class: classes,
        style: style,
        id: identifier,
        data: { editable_id: link.id, editable_type: link.model_name.route_key}
      }

      args[:attributes].each do |key, value|
        html_options[key] = value
      end

      if block_given?
        link_to(path, html_options, &block)
      else
        link_to(inner_text, path, html_options)
      end
    end

  # BANNER
    def hera_media_banner(identifier, args={}, &block)
      media = Media.identify(identifier)
      identifier, upload, style = media.identifier, media.upload, media.style
      classes = set_classes(args, media)

      url = upload.url.to_s
      html_options = {
        class: classes,
        style: "background: url(\"#{url}\"); width: 100vw;, padding: 0; height: calc(100vh - 80px); background-position: center center; background-size: cover;",
        id: identifier,
        data: { editable_id: media.id, editable_type: media.model_name.route_key}
      }
      if block_given?
        content_tag(:div, "", html_options, &block)
      else
        content_tag(:div, "", html_options)
      end
    end

  # Assign media to rails helpers for videos and images
    def hera_media_tag(identifier, args = {})
      media = Media.identify(identifier)
      identifier, upload, style = media.identifier, media.upload, media.style
      classes = set_classes(args, media)
      args[:type] ||= "image"
      url = upload.url if upload

      html_options = {
        class: classes,
        style: style,
        id: identifier,
        data: { editable_id: media.id, editable_type: media.model_name.route_key}
      }

      if args[:type] == "video"
        content_tag(:div, video_tag(url, style: "max-width: 100%; max-height: 100%;"), html_options)
      else
        content_tag(:div, image_tag(url, style: "max-width: 100%; max-height: 100%;"), html_options)
      end
    end

  # Generate HTML tag
    def hera_text(identifier, args = {})
      text = Text.identify(identifier)
      inner_text, style, identifier = translate_service.translate(text), text.style, text.identifier
      classes = set_classes(args, text)
      args[:html_tag] ||= "div"

      html_options = {
        class: classes,
        style: style,
        id: identifier,
        data: { editable_id: text.id, editable_type: text.model_name.route_key}
      }
      return content_tag(args[:html_tag].to_sym, inner_text, html_options)
    end

  # Generate Form Tag
    def hera_form(identifier, args = {})
      form = Form.identify(identifier)
      set_editable(form) unless args[:editable] == false
      identifier, send_to, classes, style = form.identifier, form.send_to, form.classes, form.style
      html_options = {
        class: classes,
        style: style,
        id: identifier,
        data: { editable_id: form.id, editable_type: form.model_name.route_key, mail: form.send_to}
      }
      form_tag("/contact", html_options ) do
        concat hidden_field_tag("form_id", form.id)
        concat text_field_tag('name',"", placeholder: "Nome")
        concat text_field_tag('email',"", placeholder: "E-mail")
        concat text_field_tag('phone',"", placeholder: "Telefone")
        concat text_area_tag('message',"", placeholder: "Digite sua mensagem aqui")
        concat submit_tag('Enviar')
      end
    end

    def set_editable(editable)
      editable.classes += " js-editable" if editable.editable? && (editable.classes && !editable.classes.include?("js-editable"))
    end

    def set_classes(args, editable)
      args[:add_class] ||= ""
      classes = "#{ args[:class] || editable.classes } #{args[:add_class]}"
      classes += " js-editable" unless args[:editable] == false || editable.classes.include?("js-editable") || !editable.editable?
    end

  end
end
