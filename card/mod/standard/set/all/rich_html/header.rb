format :html do
  view :header do
    voo.hide :toggle
    main_header
  end

  def main_header
    header_wrap header_title_elements
  end

  def header_wrap content=nil
    haml :header_wrap, content: (block_given? ? yield : output(content))
  end

  def header_title_elements
    [_render_toggle, _render_title, _render_menu]
  end

  def show_draft_link?
    card.drafts.present? && @slot_view == :edit
  end

  view :toggle do
    verb, adjective, direction = toggle_verb_adjective_direction
    link_to_view adjective, icon_tag(direction.to_sym),
                 title: "#{verb} #{card.name}",
                 class: "#{verb}-icon toggler slotter nodblclick"
  end

  def toggle_verb_adjective_direction
    if @toggle_mode == :close
      %w[open open expand]
    else
      %w[close closed collapse_down]
    end
  end

  view :navbar_links do
    wrap_with :ul, class: "navbar-nav" do
      item_links.map do |link|
        wrap_with(:li, class: "nav-item") { link }
      end.join "\n"
    end
  end

  def structure_editable?
    card.structure && card.template.ok?(:update)
  end
end
