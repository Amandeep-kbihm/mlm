module Admin::UsersHelper

  def user_level(users)
    if users.chain_count <= 5
      1
    elsif users.chain_count <= 125
      2
    elsif users.chain_count <= 25
      3
    elsif users.chain_count <= 625
      4
    elsif users.chain_count <= 3125
      5
    elsif users.chain_count <= 15625
      6
    elsif users.chain_count <= 78125
      7
    end
  end

  def get_links_for(user)
    link_to 'ASD'
  end

end
