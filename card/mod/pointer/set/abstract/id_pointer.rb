# store items as ids, not names

def standardize_item cardish
  if (id = Card.fetch_id cardish)
    "~#{id}"
  else
    Rails.logger.info "no id for '#{cardish}' added to id pointer"
  end
end

def item_ids args={}
  item_strings(args).map do |item|
    item.tr("~", "").to_i
  end
end

def item_names args={}
  item_ids(args).map(&:cardname).compact
end