class DynamicFileLinkApplicationHeaderHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    o = javascript_include_tag('dynamic_file_link', :plugin => 'redmine_dynamic_file_link')
    return o
  end
end