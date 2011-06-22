#----------------------------------------------
# Author : Upender (upender@jasita.com)
# Updated : 21-06-2011
#-----------------------------------------------


module ApplicationHelper
 def tab_heading(heading)
   content = ""
   content << "<a href='#'>"
   content << "<div class='menu-l'>&nbsp;</div><div class='menu-c'><span>&nbsp;&nbsp;#{heading}&nbsp;&nbsp;&nbsp;</span></div>"
   content << "<div class='menu-r'>&nbsp;</div></a>"
   content.html_safe
 end 
 def sub_heading(main,sub)
   "<h3>#{main}<span>&nbsp;|&nbsp;#{sub}</span></h3>".html_safe
 end 
## alias for submit_tag ########
=begin
  def button_for(name, options={})
    return content_tag(:button, content_tag(:span, name), :class => options[:class], :type => options[:button_type])
  end
=end  
  
end
