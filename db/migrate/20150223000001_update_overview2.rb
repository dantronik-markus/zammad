class UpdateOverview2 < ActiveRecord::Migration
  def up

    overview_role = Role.where( :name => 'Agent' ).first
    if overview_role
      UserInfo.current_user_id = 1
      Overview.create_or_update(
        :name       => 'My assigned Tickets',
        :link       => 'my_assigned',
        :prio       => 1000,
        :role_id    => overview_role.id,
        :condition  => {
          'tickets.state_id' => [ 1,2,3,7 ],
          'tickets.owner_id' => 'current_user.id',
        },
        :order => {
          :by        => 'created_at',
          :direction => 'ASC',
        },
        :view => {
          :d => [ 'title', 'customer', 'group', 'created_at' ],
          :s => [ 'title', 'customer', 'group', 'created_at' ],
          :m => [ 'number', 'title', 'customer', 'group', 'created_at' ],
          :view_mode_default => 's',
        },
      )
    end
  end

  def down
  end

end