module ApplicationHelper

    # Returns the full title on a per-page basis.
    def full_title(page_title = '')
      base_title = "Mini CMS"
      if page_title.empty?
        base_title
      else
        page_title + " | " + base_title
      end
    end

    # Returns user name spliter
    def first_name(user)
      user.name.split(" ")[0..-2].join(" ")
    end

    def last_name(user)
      user.name.split(" ").last
    end
end
