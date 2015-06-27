class Zwitter

  MAIN_MENU = ['1. Login', '2. Sign up for Zwitter', '3. Exit']

  attr_accessor :meesh, :poe, :ken, :show_user_menu

  def initialize 
    @meesh = Zombie.new
    @meesh.username = "meesh"
    @meesh.password = "tibby"

    @poe = Zombie.new
    @poe.username = "poe"
    @poe.password = "secret"

    @ken = Zombie.new
    @ken.username = "ken"
    @ken.password = "grains"
    show_main_menu
  end

  def show_main_menu
    error = {}
    puts "Welcome to Zwitter! "
    puts "Login to learn the latest on all things bwaaains!"
    puts ""
    main_menu_sel = get_menu_selection(MAIN_MENU)
    case main_menu_sel
      # zombie login
    when 1
      @show_user_menu = false
      zombie = nil
      login = get_zombie_login()
      zombie = get_zombie(login)
      while @show_user_menu
        user_menu(zombie)
      end
      # Join Zwitter
    when 2
      puts "Join Zwitter today"
      puts ""
      zombie = Zombie.new
      # Create username
      print "CREATE USERNAME: "
      zombie_name = gets.chomp
      zombie.username = zombie_name
      puts ""
      # 2: Create Password
      print "CREATE PASSWORD: "
      pass = gets.chomp
      zombie.password = pass
      puts ""
      zombie.logged_in = true
      @show_user_menu = true
      while @show_user_menu
        user_menu(zombie)
      end
    when 3
      puts "Happy hunting! Goodbye."
      puts ''
    else 
      display_error()
      @logout = true
      error[:error] = "The world is ending. Drop this device and enjoy your last brain!"
    end
  end

  def exit_zwit
    @exit_zwit
  end

  def get_input(prompt)
    var = ""
    while var == ""
      puts "#{prompt}"
      print '>> '
      var = gets.chomp
      puts ''
    end
    var
  end

  def get_zombie_login
    username = get_input('Please enter your username')
    password = get_input('Please enter your password')
    login = { username: username, password: password }
    login
  end

  def get_menu_selection(menu)
    menu_sel = 0
    until (1..menu.count).include?(menu_sel)
      menu_sel = get_input(menu.join("\n")).to_i
      unless (1..menu.count).include?(menu_sel)
        puts "You must have bwain poisoning. Try again."
        puts ''
      end
    end
    menu_sel
  end

  def get_zombie(login)
    matching_zombie = false
    Zombie.instances.each do | zombie |
      if zombie.username == login[:username] && zombie.password == login[:password]
        @show_user_menu = true
        matching_zombie = zombie
        matching_zombie.logged_in = true
        puts "Your account has been verified."
        puts ''
      end
    end
    unless matching_zombie
      puts "Start over."
      puts ''
    end
    matching_zombie
  end

  def display_tweets(username)
    zombie = Zombie.find_zombie(username)
    if zombie
      tweets = zombie.tweets
      tweets.reverse_each do | tweet |
        puts "Content: #{tweet.content} "
        print "Author: #{tweet.zombie.username} "
        puts "Tweet Id: #{tweet.unique_id} "
        print "Favs: #{tweet.favs.length} "
        puts ""
      end
    end
  end

  def display_tweet_feed(username)
    zombie = Zombie.find_zombie(username)
    if zombie
      tweet_feed = []
      user_tweets = zombie.tweets
      tweet_feed.push(user_tweets)
      zombie.prey.each do | target | 
        tweet_feed.push(target.tweets)
      end
      tweet_feed.flatten!
      tweet_feed.sort_by! { | tweet | tweet.unique_id }
      puts "Your ZWITTER Feed:"
      tweet_feed.reverse_each do | tweet |
        puts "Content: #{tweet.content} "
        print "Author: #{tweet.zombie.username} "
        print "Tweet Id: #{tweet.unique_id} "
        print "Favs: #{tweet.favs.length} "
        # Add retweet counter & favorites
        puts ""
      end
    end
  end

  def display_my_prey(username)
    zombie = Zombie.find_zombie(username)
    if zombie
      prey = zombie.prey
      prey.each do | target |
        puts "Victim Name: #{target.username} "
      end
      puts ""
    end
  end

  def display_my_stalkers(username)
    zombie = Zombie.find_zombie(username)
    if zombie
      stalkers = zombie.stalkers
      stalkers.each do | lurker |
        puts "Lurker Name: #{lurker.username} "
      end
      puts ""
    end
  end
end


