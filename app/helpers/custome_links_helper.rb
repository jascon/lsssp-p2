module CustomeLinksHelper
  def link_to_edit(path)
    link_to content_tag(:span,"&uarr; Edit".html_safe), path,:class=>'btn-blue'
  end

  def link_to_delete(path)
    link_to content_tag(:span,"&darr; Delete".html_safe), path, :confirm => 'Are you sure?', :method => :delete,:class=>'btn-red'
  end

  def link_to_show(path)
    link_to content_tag(:span,"Show".html_safe), path,:class=>'btn-yellow'
  end

  def link_to_all(path)
    link_to content_tag(:span, "Back To List &rarr;".html_safe), path,:class=>'btn-gray'
  end

  def link_to_back
    link_to content_tag(:span,'&larr; Back'.html_safe),:back,:class=>'btn-ltgray'
  end
  

end
