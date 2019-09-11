# # frozen_string_literal: true
#
# class CodebreakerRack
#   include CodebreakerVk::Database
#   include GameHelper
#
#
#   URLS = {
#     index: '/',
#     stats: "/#{PAGES[:stats]}",
#     rules: "/#{PAGES[:rules]}",
#     registration: '/registration',
#     win: "/#{PAGES[:win]}",
#     lose: "/#{PAGES[:lose]}",
#     show_hint: '/show_hint',
#     game: "/#{PAGES[:game]}",
#     make_guess: '/make_guess'
#   }.freeze
#
#   def self.call(env)
#     new(env).response.finish
#   end
#
#   def initialize(env)
#     @request = Rack::Request.new(env)
#     @act = GameProcess.new(@request)
#   end
#
#   def response
#     session_contain?(@request, :game) ? active_game_phase : absent_game_phase
#   end
#
#   def show_stats
#     CodebreakerVk::GameMenu.stats
#   end
#
#   def session_destroy
#     @request.session.clear
#   end
#
#   private
#
#   def absent_game_phase
#     case @request.path
#     when URLS[:index] then show_page(PAGES[:menu])
#     when URLS[:stats] then show_page(PAGES[:stats])
#     when URLS[:rules] then show_page(PAGES[:rules])
#     when URLS[:registration] then @act.register_new_game
#     else redirect_to(URLS[:index])
#     end
#   end
#
#   def active_game_phase
#     @act.update_game_data
#     case @request.path
#     when URLS[:game] then show_page(PAGES[:game])
#     when URLS[:show_hint] then @act.show_hint
#     when URLS[:make_guess] then @act.start_round
#     when URLS[:win] then check_game_over(PAGES[:win])
#     when URLS[:lose] then check_game_over(PAGES[:lose])
#     else redirect_to(URLS[:game])
#     end
#   end
#
#   def check_game_over(page)
#     session_contain?(@request, :game_over) ? show_page(page) : redirect_to(URLS[:game])
#   end
# end