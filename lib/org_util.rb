#
# Org mode 用のユーティリティ
#
module OrgUtil
  module_function

  #
  # 戻り値: ハッシュ[:xxx]
  # - 項目がない、空白のみの場合は nil (項目なし)
  # - 「#+XXX:」の後ろは空白が必要
  #
  def parse_property(content)
    properties = {}

    content.each_line do |line|
      if (value  = get_value(line, "ULID"))
        properties[:ulid] = value
        next
      end

      if (value = get_value(line, "POST_ID"))
        properties[:post_id] = value.to_i
        next
      end

      if (value = get_value(line, "TITLE"))
        properties[:title] = value
        next
      end

      if (value = get_value(line, "SITE_ID"))
        properties[:site_ids] = [ value.to_i ]
        next
      end

      if (value = get_value(line, "SITE_IDS"))
        properties[:site_ids] = value.split(",").map { |s| s.strip.to_i }
        next
      end

      if (value = get_value(line, "TAGS"))
        properties[:tags] = value.split(",").map(&:strip)
        next
      end

      if (value = get_value(line, "POSTED_AT"))
        properties[:posted_at] = value
        next
      end

      if (value = get_value(line, "THUMBNAIL"))
        properties[:thumbnail] = value
        next
      end

      if (value = get_value(line, "YOUTUBE_ID"))
        properties[:youtube_id] = value
        next
      end
    end

    properties
  end

  #
  # - 与えられた文字列が「#+XXX: 」の形式かチェックして、値を返す
  # - 空白文字のみなら nil を返す
  #
  def get_value(line, key)
    if (m = line.match(/\A#\+#{key}:\s+(.+?)\s*\z/))
      value = m[1].strip
      value.empty? ? nil : value
    else
      nil
    end
  end
end
