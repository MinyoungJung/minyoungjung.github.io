# Plugin Usage
#
# 1. Make a _plugins directory in your jekyll site, and put this class in a file there.
# 2. In anyone of your pages, you can use the 'tag_name' liquid tag like so:
#     {% longest_date_streak %}
# 3. Each Tags refer to:
#   current_date_streak : Posting date streak including latest post
#   longest_date_streak : Longest date streak in whole blogging day
#

module Jekyll
  def self.getStreak(context)
    date_arr = Array.new()
    site = context.registers[:site]
    for document in site.posts.docs do
      date_arr << document.date.strftime('%Y-%m-%d').to_s
    end

    current = 1
    max_streak = 1
    (0..date_arr.length - 2).each do |i|
      if (Date.parse(date_arr[i])+1).to_s == date_arr[i+1]
        current += 1
        if current > max_streak
          max_streak = current
        end
      else
        current = 1
      end
    end

    # if last posting date passed two days
    if Date.parse(date_arr.last) < Date.today()-1
      current = 0
    end

    return current, max_streak
  end

  class RenderCurrentDateStreak < Liquid::Tag
    def render(context)
      Jekyll.getStreak(context)[0]
    end
  end

  class RenderLongestDateStreak < Liquid::Tag
    def render(context)
      Jekyll.getStreak(context)[1]
    end
  end
end

Liquid::Template.register_tag('current_date_streak', Jekyll:: RenderCurrentDateStreak)
Liquid::Template.register_tag('longest_date_streak', Jekyll:: RenderLongestDateStreak)
