#
# Org mode 用のユーティリティ
#
module OrgUtil
  module_function

  def parse_property(content)
    properties = {}

    content.each_line do |line|
      if line.match?(/^#\+ULID: +/)
        properties[:ulid] = line.gsub(/^#\+ULID: +/, "")
        next
      end

      if line.match?(/^#\+POST_ID: +/)
        properties[:post_id] = line.gsub(/^#\+POST_ID: +/, "").to_i
        next
      end

      if line.match?(/^#\+TITLE: +/)
        properties[:title] = line.gsub(/^#\+TITLE: +/, "")
        next
      end

      if line.match?(/^#\+SITE_ID: +/)
        properties[:site_ids] = [ line.gsub(/^#\+SITE_ID: +/, "").to_i ]
        next
      end
      if line.match?(/^#\+SITE_IDS: +/)
        str = line.gsub(/^#\+SITE_IDS: +/, "")
        properties[:site_ids] = str.split(",").map { |s| s.strip.to_i }
        next
      end

      if line.match?(/^#\+TAGS: +/)
        str = line.gsub(/^#\+TAGS: +/, "")
        properties[:tags] = str.split(",").map(&:strip)
        next
      end

      if line.match?(/^#\+POSTED_AT: +/)
        properties[:posted_at] = line.gsub(/^#\+POSTED_AT: +/, "")
        next
      end

      if line.match?(/^#\+THUMBNAIL: +/)
        properties[:thumbnail] = line.gsub(/^#\+THUMBNAIL: +/, "")
        next
      end

      if line.match?(/^#\+YOUTUBE_ID: +/)
        properties[:youtube_id] = line.gsub(/^#\+YOUTUBE_ID: +/, "")
        next
      end
    end

    properties
  end
end
