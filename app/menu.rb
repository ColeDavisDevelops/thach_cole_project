class Menu
  @@prompt = TTY::Prompt.new


  def display_response(resp)
    print_title
    puts "\n"
    p resp
    puts "\n"
    where_to = @@prompt.select("Where to next?", ["Main menu!", "That is all the help I need!"])
    session = false if where_to == "That is all the help I need!"
  end 
    
  def user_menu(user)
    session = true
    while session do 
      print_title
      p "Welcome to your own personal workout portal #{user.name}!"
      option = @@prompt.select("How can we help you today?", %w(
        what_gyms_are_available?
        which_gym_has_served_the_most_clients?
        which_gym_has_served_the_least_clients?
        what_trainers_are_available?
        what_is_my_total_weight_lifted?
        what_trainer_burned_the_most_calories?
        what_trainer_has_the_most_experience_lifting_weights?
        end_session
      ))
      case option 
      when "what_is_my_total_weight_lifted?"
        display_response(user.total_weight_for_all_workouts)
      when "what_gyms_are_available?"
        p Gym.all.map { |g| g.name }
      when "which_gym_has_served_the_most_clients?"
        p Gym.most_user
      when "which_gym_has_served_the_least_clients?"
        p Gym.least_user
      when "what_trainers_are_available?"
        p Trainer.all.map { |t| t.name }
      when "what_trainer_burned_the_most_calories?"
        t = Trainer.most_calories_burned
        p "#{t.name} who burned #{t.total_calories_burned} calories"
      when "what_trainer_has_the_most_experience_lifting_weights?"
        t = Trainer.most_experience_with_lifting
        p "#{t.name} who has delivered #{t.num_workouts_with_weight_lifting} weight lifting sessions"
      when "end_session"
        p "ending session"
        session = false
      end
    end 
  end
end 