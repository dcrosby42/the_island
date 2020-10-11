module ItemHelper
  def find_item(items, subject)
    idx = nil
    case subject
    when /^\d+$/, Integer
      # Find by numeric index (1-based)
      idx = subject.to_i - 1
    else
      # match on name
      idx = (items.find_index { |item| item.type.to_s == subject })
      # fallback: partial string match (starts-with)
      idx ||= (items.find_index { |item| item.type.to_s.start_with?(subject) })
    end

    if idx
    return items[idx], idx
    end
    return nil, nil
  end

  def take_item(items, subject)
    item, idx = find_item items, subject
    if idx
      items.delete_at idx
      if item
        return item
      end
    end
  end
end
