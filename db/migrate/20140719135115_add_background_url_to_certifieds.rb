class AddBackgroundUrlToCertifieds < ActiveRecord::Migration
  def change
    add_column :certifieds, :background_url, :string
  end
end
