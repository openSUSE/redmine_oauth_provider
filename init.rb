# -*- encoding : utf-8 -*-
require 'redmine'

require 'oauth/rack/oauth_filter'
Rails.application.config.middleware.use OAuth::Rack::OAuthFilter

# Patches to the Redmine core.
Rails.configuration.to_prepare do
  require_dependency 'project'
  require_dependency 'user'

  User.send(:include, OauthProviderUserPatch)
end

Redmine::Plugin.register :redmine_oauth_provider do
  name 'Redmine Oauth Provider plugin'
  author 'Jana Dvořáková'
  description 'Oauth Provider plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/Virtualmaster/redmine-oauth-provider'
  author_url 'http://www.jana4u.net/'

  menu :admin_menu, :oauth_clients, { :controller => 'oauth_clients', :action => 'index' }, :caption => :oauth_client_applications
end
