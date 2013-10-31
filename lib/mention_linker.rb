# ref: http://guides.rubyonrails.org/rails_on_rack.html
#
# This is Rack Middleware designed to wrap all instances of @username with a link to '/username'.
# It is included in the application in config/application.rb#32.
#
# NOTE: An easier way to accomplish this, would be to wrap all output of @username in a link
# on the Rails side of things. If you take / took this approach, make sure to remember linking
# @username mentions in Twets as you display them. You can accomplish this by making the #link_mentions
# method a view helper and running all Twet#content displays through it.
#
class MentionLinker

  # Make the middleware aware of the application.
  #
  def initialize(app)
    @app = app
  end

  # Gets called by the stack after the page is generated. Based on where we are in the Rack stack,
  # if the response is an Array instance, the first value will be the HTML for the page. In this case,
  # the HTML is parsed by the #link_mentions method to perform the substitution described above.
  #
  def call(env)
    status, headers, response = @app.call(env)
    if headers["Content-Type"] and
       headers["Content-Type"].match(Regexp.new("text/html")) and
       response.respond_to?(:first)
      [status, headers, [link_mentions(response.first)]]
    else
      [status, headers, response]
    end
  end

  # Uses a simple regex to find all instances of @username which occur after a space or '>' character
  # and replace these with a link to that user. When working with regular expressions in Ruby,
  # http://rubular.com will be your best friend.
  #
  # additional ref: http://ruby-doc.org/core-2.0.0/String.html#method-i-gsub
  #
  def link_mentions(html)
    html.gsub(/(?<prefix>[>| ])@(?<username>(\w+))/, '\k<prefix><a href="/\k<username>">@\k<username></a>') if html
  end
end
