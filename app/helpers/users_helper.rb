module UsersHelper
  def convert_username(username)
    "/#{username.gsub('@', '')}"
  end
end