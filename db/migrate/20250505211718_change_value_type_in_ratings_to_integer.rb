class ChangeValueTypeInRatingsToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :ratings, :value, :integer, using: 'value::integer'
  end
end

