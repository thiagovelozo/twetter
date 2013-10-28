class MentionLinker
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    if headers["Content-Type"] and headers["Content-Type"].match(Regexp.new("text/html"))
      if response.respond_to?(:first)
        [status, headers, [link_mentions(response.first)]]
      else
        [status, headers, response]
      end
    else
      [status, headers, response]
    end
  end

  def link_mentions(html)
    html.gsub(/(?<prefix>[>| ])@(?<username>(\w+))/, '\k<prefix><a href="/\k<username>">@\k<username></a>') if html
  end
end
