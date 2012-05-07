orm_adapter_activeresource
==========================

Extends [orm_adapter] to support ActiveResource.

This enables you to use devise and other libraries based on orm_adapter with your ActiveResource models.

Installation
------------

    gem install orm_adapter_activeresource
    
or add this to your Gemfile:

    gem 'orm_adapter_activeresource'

This will automatically load the orm_adapter methods into all ActiveResource models.

Testing
-------

To run the integration tests (launches a full ActiveResource Rails-based server)

    rake spec

Usage with devise
-----------------

Sample model for devise:

    class User < ActiveResource::Base
      self.site = # ...
  
      # Devise compatibility
      def self.before_validation(*args); end
      def authenticatable_salt; end
  
      devise :database_authenticatable, :recoverable
    end

[orm_adapter]: https://github.com/ianwhite/orm_adapter