class AddAssetsRole < ActiveRecord::Migration
  def self.up
    if Role.create!(:role_name => 'Assets', :description => 'Users in this role will be able to edit Assets.')
      puts "Assets role created."
    end
  end
  def self.down
    Role.find_by_role_name('Assets').destroy
  end
end