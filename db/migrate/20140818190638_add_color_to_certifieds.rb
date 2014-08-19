class AddColorToCertifieds < ActiveRecord::Migration
  def change
    add_column :certifieds, :name_color, :string
  end
end
