require 'open-uri'

Show.delete_all
(1..26).each do |i|
  response = open('https://api.themoviedb.org/3/discover/tv?api_key=401b1b1c2360ebe7559fdd9c1328359f&language=en-US&sort_by=name.asc&with_keywords=10586&page='+i.to_s).read
  data = JSON.parse(response)

  movies = data['results']

  movies.each do |movie|
    if movie['poster_path'] != ""
    	show = Show.new

    	show.id = movie['id']
    	show.title = movie['name']
    	show.description = movie['overview']
    	show.popularity = movie['popularity']
    	show.vote_average = movie['vote_average']
    	show.backdrop_path = movie['poster_path']
    	
    	begin
    		show.release_date = Date.parse(movie['first_air_date'])	
    	rescue

    	ensure

    	end

    	show.save
    end
  end
end