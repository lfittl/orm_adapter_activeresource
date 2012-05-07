require 'spec_helper'
require 'orm_adapter/example_app_shared'

module ActiveResourceOrmSpec
  class User < ActiveResource::Base
    self.site = "http://localhost:31777/"
    schema do
      string 'name'
      integer 'rating'
    end
    def notes; Note.find(:all, :params => {:owner_id => id}) || []; end
  end

  class Note < ActiveResource::Base
    self.site = "http://localhost:31777/"
    schema do
      integer 'owner_id'
    end
    def owner; User.find(owner_id); end
  end

  # here be the specs!
  describe OrmAdapter::ActiveResource do
    before(:all) do
      @server_pid = fork do
        begin
          server_dir = File.expand_path(__FILE__ + '/../activeresource_server')
          server_log = server_dir + '/server.log'
          FileUtils.rm(server_log) rescue nil
          $stdout.reopen('/dev/null', 'w')
          $stderr.reopen('/dev/null', 'w')
          exec('bundle exec rackup -p 31777 ' + server_dir + '/config.ru > ' + server_log + ' 2>&1')
        rescue => e
          puts e.inspect
        end
      end
      sleep 5
    end
    after(:all) do
      Process.kill "KILL", @server_pid
      Process.waitpid @server_pid
      Process.kill "KILL", (@server_pid + 1)
    end

    before do
      User.find(:all).each {|u| u.destroy }
      Note.find(:all).each {|n| n.destroy }
    end

    describe "the OrmAdapter class" do
      subject { ActiveResource::Base::OrmAdapter }

      specify "#model_classes should return all model classes" do
        subject.model_classes.should include(User, Note)
      end
    end

    it_should_behave_like "example app with orm_adapter" do
      let(:user_class) { User }
      let(:note_class) { Note }

      def create_model(klass, attrs = {})
        klass.create(attrs)
      end
    end
  end
end
