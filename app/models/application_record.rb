class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

 protected

  def geocode
    res = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=AIzaSyBKnVvlCy9D9nY3-WJ5frpbVzuZK3DIy2Y")
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
