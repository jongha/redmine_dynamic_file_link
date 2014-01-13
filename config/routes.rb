# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do 
  get 'projects/:id/files/:filename', :to => 'dynamic_file_link#get', :filename => /.*/
end
