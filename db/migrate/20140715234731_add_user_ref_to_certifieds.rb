class AddUserRefToCertifieds < ActiveRecord::Migration
  def change
    add_reference :certifieds, :user, index: true
  end
end
