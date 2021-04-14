require './lib/line_templates'


class WelcomeController < ApplicationController

    include LineTemplates

  def top
    p menu_template
  end
end
