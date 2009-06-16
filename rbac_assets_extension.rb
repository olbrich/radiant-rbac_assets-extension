# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RbacAssetsExtension < Radiant::Extension
  version "1.0"
  description "Uses RBAC Base to change the editors of Assets."
  url "http://saturnflyer.com/"
  
  class MissingRequirement < StandardError; end
  
  def activate
    raise RbacAssetsExtension::MissingRequirement.new('RbacBaseExtension must be installed and loaded first.') unless defined?(RbacBaseExtension)
    admin.tabs["Assets"].visibility = [:assets]
    Admin::AssetsController.class_eval {
      only_allow_access_to(:index, :new, :edit, :update, :create, :destroy,
        :when => :assets,
        :denied_url => {:controller => 'welcome', :action => 'index'},
        :denied_message => "You do not have access rights for Assets.")
    }
  end
  
  def deactivate
    # admin.tabs.remove "Rbac Assets"
  end
  
end