format :html do
  MODAL_SIZE = { small: "sm", medium: nil, large: "lg", full: "full" }
  view :modal_link do
    modal_link _render_title, size: voo.size
  end

  # @param size [:small, :medium, :large, :full] size of the modal dialog
  def modal_link text=nil, opts={}
    link_to text, modal_link_opts(opts)
  end

  def modal_dialog_classes opts
    classes = []
    if (size = opts.delete(:size)) && size != :medium
     classes << "modal-#{MODAL_SIZE[size]}"
    end
    if opts.delete(:vertically_centered)
      classes << "modal-dialog-centered"
    end
    classes.join " "
  end

  def modal_link_opts opts
    add_class opts, "_modal-link"
    opts.reverse_merge! path: {},
                        "data-toggle": "modal",
                        "data-target": "#modal-main-slot",
                        "data-modal-class": modal_dialog_classes(opts)

    opts[:path][:layout] ||= :modal
    opts
  end

  def modal_slot modal_id=nil
    wrap_with :div, class: "modal fade _modal-slot",
              role: "dialog", id: "modal-#{modal_id || 'main-slot'}" do
      wrap_with :div, class: "modal-dialog" do
        wrap_with :div, class: "modal-content" do
          modal_content unless modal_id
        end
      end
    end.html_safe
  end

  def modal_content
    return unless root.modal_opts
    with_nest_mode :normal do
      nest root.card, root.modal_opts
    end
  end

  view :modal_menu, tags: :unknown_ok do
    wrap_with :div, class: "modal-menu w-100" do
      [close_modal_window, pop_out_modal_window]
    end
  end

  view :modal_dialog_classes, cache: :never, perms: :none, tags: :unknown_ok do
    classes = ["modal-dialog"]
    classes << "modal-#{Env.params[:modal_size]}" if Env.params[:modal_size]
    classy classes
  end

  def close_modal_window
    link_to icon_tag(:close), path: "",
                              class: "close-modal float-right close",
                              "data-dismiss": "modal"
  end

  def pop_out_modal_window
    # we probably want to pass on a lot more params than just view,
    # but not all of them
    # (eg we don't want layout, id, controller...)
    popout_params = params[:view] ? { view: params[:view] } : {}
    link_to icon_tag(:new_window), path: popout_params,
                                   class: "pop-out-modal float-right close "
  end

  view :modal_footer, tags: :unknown_ok do
    button_tag "Close",
               class: "btn-xs close-modal float-right",
               "data-dismiss" => "modal"
  end
end
