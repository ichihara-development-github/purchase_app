module HubenyDistance

  include Math

    def distance(lat1, lng1, lat2, lng2)

      lat1 = rad(lat1)
      lat2 = rad(lat2)
      lng1 = rad(lng1)
      lng2 = rad(lng2)

      dy = (lat1 - lat2).abs
      dx = (lng1 - lng2).abs
      rx = 6378.136.freeze
      ry = 6356.775.freeze
      ave = (lat1 + lat2)/2

      eccentricity = Math.sqrt(((rx)**2 - (ry)**2) / (rx)**2)

      w2 = Math.sqrt( (1.0 - (eccentricity**2 * (Math.sin(ave)**2))) )

      meridian_radius = rx*(1- eccentricity**2)/w2**3

      boyu_line = rx / Math.sqrt(w2)

      return Math.sqrt((dy * (meridian_radius))**2 + (dx * boyu_line * (Math.cos(ave)))**2 )
    end

    def rad(degree)
      degree * Math::PI / 180
    end

  #------------------------------------------


end
