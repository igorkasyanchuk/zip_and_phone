module ApplicationHelper

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << "<div class='#{msg} flash'>#{html_escape(flash[msg.to_sym])}</div>" unless flash[msg.to_sym].blank?
    end
    flash.clear
    messages
  end
  
  def title(t = SEO[:title], index = '')
    content_for :title do
      I18n.t('city_post_index_seo', :code => t, :index => index)
    end
  end

  def page_title(t = SEO[:page_title], index = '')
    content_for :object_title do
      t
    end
  end

  
  def init_wufoo_and_tabs
    content_for :on_ready do
      %w(
      jQuery('#tabs').tabs();
      initForm();
      )
    end
  end
  
  def check_icon
    image_tag 'icons/accept.png'
  end
  
  def description(t = SEO[:description], index = '')
    content_for :seo_description do
      I18n.t('city_post_index_seo', :code => t, :index => index).mb_chars.downcase
    end
  end
  
  def form_field_show(parent, field, label, b=false, l=false, f=:default)
    v = parent.send(field)
    return if v.blank?
    v = v.as_text if b
    v = l(v, :format => f) if l
    return "<dt>#{label}</dt><dd>#{h(v)}</dd>"
  end
  
  def keywords(t = SEO[:keywords], index = '')
    content_for :seo_keywords do
      I18n.t('city_post_index_seo', :code => t, :index => index).mb_chars.downcase
    end
  end
  
  def footers(t = '')
    content_for :seo_footer do
      (t || "") + ' ' + (SEO[:footer] || "").mb_chars.downcase
    end 
  end
  
  def include_extended_tiny_mce
    output =<<EOF
    <script type="text/javascript" src="/javascripts/tiny_mce_jquery/tiny_mce.js"></script>
    <script type="text/javascript" src="/javascripts/tiny_mce_jquery/jquery.tinymce.js"></script>
EOF
    output
  end
  
  def use_extended_tiny_mce(basic = true)
    output = ''
    if basic
    output=<<EOF
		jQuery('textarea.mceEditor').tinymce({
			// Location of TinyMCE script
			script_url : '/javascripts/tiny_mce_jquery/tiny_mce.js',

			// General options
			theme : "advanced",
			plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

			// Theme options
			theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull",
			theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
			theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
			theme_advanced_buttons4 : "",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,

			// Example content CSS (should be your site CSS)
			content_css : "/stylesheets/tinymce.css?100",
			width: '100',
			height: '300'
		});
EOF
    else
    output=<<EOF
		jQuery('textarea.mceEditor').tinymce({
			// Location of TinyMCE script
			script_url : '/javascripts/tiny_mce_jquery/tiny_mce.js',

			// General options
			theme : "advanced",
			plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

			// Theme options
			theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
			theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
			theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
			theme_advanced_buttons4 : "",
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : true,

			// Example content CSS (should be your site CSS)
			content_css : "/stylesheets/tinymce.css?100",

			width: 300,
			height: 300,
			theme_advanced_source_editor_width : 400

		});
EOF
    end
    content_for :on_ready do
      output
    end
  end
  
  # Yield the content for a given block. If the block yiels nothing, the optionally specified default text is shown. 
  #
  #   yield_or_default(:user_status)
  #
  #   yield_or_default(:sidebar, "Sorry, no sidebar")
  #
  # +target+ specifies the object to yield.
  # +default_message+ specifies the message to show when nothing is yielded. (Default: "")
  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end     
  
  #
  # Evaluates the content of <tt>block</tt> and stores the result as <tt>content_for :sidebar</tt>.
  #
  # Because <tt>content_for</tt> concatenates the block, you can call <tt>sidebar</tt> multiple time
  # and yield all the final content once.
  #
  # See <tt>ActionView::Helpers::CaptureHelper#content_for</tt> for the full API documentation.
  #
  # ==== Examples
  #
  # <% sidebar do %>
  # <p>Sidebar</p>
  # <% end %>
  #
  # <%= yield :sidebar %>
  # # => <p>Sidebar</p>   
  def sidebar(&block)
    content_for :sidebar, &block
  end

  def inside_layout(layout_name, &block)
    layout_name = layout_name.include?('/') ? layout_name : "layouts/#{layout_name}"
    @template.instance_variable_set("@content_for_layout", capture(&block))
    concat(@template.render(:file => layout_name, :user_full_path => true))
  end
  
  def logged_in?
    !!current_user
  end
  
  def is_admin?
    return false unless logged_in?
    current_user.admin?
  end
  
  def is_moderator?
    return false unless logged_in?
    current_user.moderator?
  end
  
  def wa(&block)
    content = capture(&block)
    concat("what we want write before block", block)
    concat(content,block)
    concat("what we want write after block", block)
  end
  
  def home_page?
    controller.controller_name == "home" && controller.action_name = "index"
  end
  
  def rating_field(name, ratable, star_class='read-only-star')
    value = ratable.average_rating_percent
    value = ((value + 1) / 10).round  * 10
    res = "<div>"
    (1..10).each do |n|
      res << "<input name='#{ratable.class.name.downcase}-#{ratable.id.to_s}-#{name}' type='radio' class='#{star_class} #{ratable.class.name.downcase}-#{ratable.id.to_s}-class' value='#{n*10}' title='#{n/2.0}' #{ 'checked=\'checked\'' if value == n*10 }/> "
    end
    res + "</div>"
  end
  
  def static_rating_field(ratable)
    rating = (ratable.average_rating * 10).round
    rating = case rating
      when 1..10 then 10
      when 11..20 then 20
      when 21..30 then 30
      when 31..40 then 40
      when 41..50 then 50
      when 51..60 then 60
      when 61..70 then 70
      when 71..80 then 80
      when 81..90 then 90
      when 91..100 then 100
      else 0
    end
    return 'rating_stars rating_stars0 png_bg' if rating == 0
    return 'rating_stars rating_stars100 png_bg' if rating > 100
    return "rating_stars rating_stars#{rating} png_bg"
  end
  
  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end
  
  def flash_banner_top(top_banner)
    url = " onclick='nav_from_top_banner(#{top_banner.id});'"
    banner_info = "<div class='top_parent'><div class='flash_clickable' #{url}></div><div class='flash_source'><embed height='60'\
       width='468'\
       type='application/x-shockwave-flash' \
       allowscriptaccess='always' \
       menu='false' \
       quality='best' \
       loop='true' \
       wmode='transparent' \
       play='true' \
       flashvars='source=http://list.if.ua' \
       src='#{top_banner.banner.url}'/></div></div>"
    banner_info
  end
  
  def image_banner_top(top_banner)
    url = " onclick='nav_from_top_banner(#{top_banner.id});'"
    banner_info = "<div class='top_parent png_bg'><div class='flash_clickable png_bg' #{url}></div><div class='flash_source png_bg'>\
    <img src='#{top_banner.banner.url}' alt='#{top_banner.id}' class='png_bg'/></div></div>"
    banner_info    
  end
  
  def top_banner
    return unless StatisticsHelper.allowed_ip?(request)
    @adv = AdvTop.active.random.first
    return unless @adv
    @adv.views_count += 1
    @adv.save
    @adv.adv_top_views_by_dates.create
    if @adv.flash_banner?
      flash_banner_top(@adv)
    else
      image_banner_top(@adv)
    end
  end
  
  def flash_banner_right(right_banner)
    url = " onclick='nav_from_right_banner(#{right_banner.id});'"
    banner_info = "<div class='right_parent'><div class='flash_clickable' #{url}></div><div class='flash_source'>\
      <embed height='160'\
       width='120'\
       type='application/x-shockwave-flash' \
       allowscriptaccess='always' \
       menu='false' \
       quality='best' \
       loop='true' \
       wmode='transparent' \
       play='true' \
       flashvars='source=http://list.if.ua' \
       src='#{right_banner.banner.url}'/></div></div>"
    banner_info
  end
  
  def image_banner_right(right_banner)
    url = " onclick='nav_from_right_banner(#{right_banner.id});'"
    banner_info = "<div class='right_parent'><div class='flash_clickable' #{url}></div><div class='flash_source png_bg'>\
    <img src='#{right_banner.banner.url}' alt='#{right_banner.id}' class='png_bg'/></div></div>"
    banner_info    
  end
  
  def right_banner(right_banner)
    return unless right_banner
    right_banner.views_count += 1
    right_banner.save
    if right_banner.flash_banner?
      flash_banner_right(right_banner)
    else
      image_banner_right(right_banner)
    end
  end
  
  def sort_link(title, column, options = {})
    sort_dir = params[:d] == 'down' ? 'up' : 'down'
    link_to title, request.parameters.merge( {:c => column, :d => sort_dir} ), :rel => 'nofollow', :id => 'sort_link_sorting'
  end
  
  def google_map
    content_for :map do
      if Rails.env == 'production'
        '<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=' + GOOGLE_MAP[:production_key] + '&hl=en" type="text/javascript"></script>'+
        '<script src="http://gmaps-utility-library.googlecode.com/svn/trunk/markermanager/release/src/markermanager.js" type="text/javascript"></script>'
      else
        '<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=' + GOOGLE_MAP[:development_key] + '&hl=en" type="text/javascript"></script>'+
        '<script src="http://gmaps-utility-library.googlecode.com/svn/trunk/markermanager/release/src/markermanager.js" type="text/javascript"></script>'
      end
    end
  end
  
  def flag_link(flag, locale = nil)
    locale ||= flag
    (link_to (image_tag "#{flag}.png"), url_for(request.parameters.merge({:locale => locale})), :title => locale ) 
  end
  
end
