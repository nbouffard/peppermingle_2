class AddDefaultValueToEvents < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :paid, :boolean, default: false
  end
end
