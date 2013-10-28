require 'digest/md5'

module ApplicationHelper
  def follow_link(user)
    follow = Follow.where(:user => current_user, :following => user)
    if follow.exists?
      button_to("Unfollow", follow_path(follow.first), :method => :delete, :class => 'btn btn-danger mar-top-5', :form => { :class => 'form-inline pull-right' })
    else
      form_for(:follow, :url => follows_path, :method => 'POST', :html => { :class => 'pull-right' }) do |f|
        f.hidden_field(:following_id, :value => user.id.to_s) +
        f.submit('Follow', :class => "btn btn-primary mar-top-5")
      end
    end
  end

  # http://en.gravatar.com/site/implement/images/ruby/
  def gravatar(user)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?s=48"
  end

  def nav_item(name, path)
    content_tag(:li, link_to(name, path), :class => is_active?(name))
  end

  def notices
    content_tag :div, :class => 'alert-float' do
      html = ''
      [:alert, :error, :notice, :success].each do |type|
        html += content_tag(:div, notice_text(type), :class => notice_class(type)) if notice?(type)
      end
      html.html_safe
    end
  end

  private

  def is_active?(name)
    case name
    when "Follow" then
      controller_name == 'follows' ? 'active' : ''
    when "Tweet" then
      controller_name == 'tweets' ? 'active' : ''
    end
  end

  def notice?(type)
    flash[type].present?
  end

  def notice_class(type)
    case type
    when :error then 'alert text-danger'
    when :success then 'alert text-success'
    else
      'alert text-warning'
    end
  end

  def notice_text(type)
    html = content_tag :button, "Dismiss Alert", :class => 'close', 'data-dismiss' => 'alert', 'aria-hidden' => true
    html += content_tag :strong, flash[type]
    html.html_safe
  end
end
