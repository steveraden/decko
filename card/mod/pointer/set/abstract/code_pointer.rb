include_set Abstract::Pointer

abstract_basket :item_codenames

module ClassMethods
  def add_item codename
    if Card::Codename.exist? codename
      add_to_basket :item_codenames, codename
    else
      warn "unknown codename '#{codename}' added to code pointer"
    end
  end
end

def content
  item_codenames.map do |codename|
    Card.fetch_name codename
  end.compact.to_pointer_content
end
