class CreateCertifieds < ActiveRecord::Migration
  def change
    create_table :certifieds do |t|
      t.string :slug

      t.timestamps
    end
  end
end
